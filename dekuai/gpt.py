"""Multi-provider AI service."""

import json
from typing import Generator, Optional, Dict, Any
import requests
from rich.console import Console
from rich.progress import Progress, SpinnerColumn, TextColumn
from dekuai.config import Config, get_model, Model

console = Console()


class AIService:
    """Unified AI service for multiple providers."""

    def __init__(self, config: Config, model_id: Optional[str] = None):
        self.config = config
        self.model_id = model_id or config.model
        self.model = get_model(self.model_id)

        if not self.model:
            self.model = get_model("gpt-3.5-turbo")

        self.api_key = config.api_key or "not-needed"
        self.base_url = config.base_url or self.model.endpoint

    def _build_headers(self) -> Dict[str, str]:
        """Build request headers based on provider."""
        headers = {"Content-Type": "application/json"}

        if self.model.provider == "openai-compatible":
            headers["Authorization"] = f"Bearer {self.api_key}"
        elif self.model.provider in ("openai", "anthropic", "google"):
            # opencode.ai zen doesn't require auth for many models
            if self.api_key and self.api_key != "not-needed":
                headers["Authorization"] = f"Bearer {self.api_key}"

        return headers

    def _build_payload(self, prompt: str) -> Dict[str, Any]:
        """Build request payload based on model/provider."""
        if self.model.provider == "anthropic":
            # Anthropic uses /messages endpoint
            return {
                "model": self.model_id,
                "messages": [{"role": "user", "content": prompt}],
                "max_tokens": self.config.max_tokens,
            }
        else:
            # OpenAI-compatible uses /chat/completions
            return {
                "model": self.model_id,
                "messages": [{"role": "user", "content": prompt}],
                "max_tokens": self.config.max_tokens,
                "temperature": self.config.temperature,
                "stream": True,
            }

    def complete(self, prompt: str) -> str:
        """Generate completion (non-streaming)."""
        headers = self._build_headers()
        payload = self._build_payload()
        payload["stream"] = False

        with Progress(
            SpinnerColumn(),
            TextColumn("[progress.description]{task.description}"),
            console=console,
        ) as progress:
            progress.add_task(f"Generating with {self.model.name}...", total=None)

            response = requests.post(
                self.model.endpoint,
                headers=headers,
                json=payload,
                timeout=120,
            )

        if response.status_code != 200:
            raise Exception(f"API error: {response.status_code} - {response.text}")

        data = response.json()

        # Parse response based on endpoint type
        if "/messages" in self.model.endpoint:
            return data.get("content", [{}])[0].get("text", "")
        else:
            return data.get("choices", [{}])[0].get("message", {}).get("content", "")

    def complete_streaming(self, prompt: str) -> Generator[str, None, None]:
        """Generate streaming completion."""
        headers = self._build_headers()
        payload = self._build_payload()

        response = requests.post(
            self.model.endpoint,
            headers=headers,
            json=payload,
            stream=True,
            timeout=120,
        )

        if response.status_code != 200:
            raise Exception(f"API error: {response.status_code} - {response.text}")

        # Parse streaming response
        for line in response.iter_lines():
            if line:
                line = line.decode("utf-8")
                if line.startswith("data: "):
                    data_str = line[6:]
                    if data_str == "[DONE]":
                        break
                    try:
                        data = json.loads(data_str)
                        content = self._extract_content(data)
                        if content:
                            yield content
                    except json.JSONDecodeError:
                        continue

    def _extract_content(self, data: Dict) -> Optional[str]:
        """Extract content from response data."""
        # OpenAI format
        if "choices" in data:
            delta = data["choices"][0].get("delta", {})
            return delta.get("content") or delta.get("text")

        # Anthropic format
        if "content" in data:
            if isinstance(data["content"], list):
                return data["content"][0].get("text")
            return data["content"]

        # Generic
        return None

    def generate(self, prompt: str, size: str = "1024x1024", count: int = 1) -> list:
        """Generate images (only for models that support it)."""
        if not self.model.supports_images:
            raise Exception(f"Model {self.model_id} does not support image generation")

        # Use OpenAI's image generation endpoint
        headers = {
            "Authorization": f"Bearer {self.api_key}",
            "Content-Type": "application/json",
        }
        payload = {
            "model": "dall-e-3",
            "prompt": prompt,
            "n": min(count, 10),
            "size": size,
        }

        with Progress(
            SpinnerColumn(),
            TextColumn("[progress.description]{task.description}"),
            console=console,
        ) as progress:
            progress.add_task("Generating images...", total=None)

            response = requests.post(
                "https://api.openai.com/v1/images/generations",
                headers=headers,
                json=payload,
                timeout=120,
            )

        if response.status_code != 200:
            raise Exception(f"API error: {response.status_code} - {response.text}")

        data = response.json()
        return [item["url"] for item in data["data"]]