"""GPT text completion service."""

from typing import Optional
from openai import OpenAI
from rich.console import Console
from rich.progress import Progress, SpinnerColumn, TextColumn
from dekuai.config import Config

console = Console()


class GPTService:
    """Service for GPT text completion."""

    def __init__(self, config: Config):
        self.client = OpenAI(api_key=config.api_key)
        self.model = config.model
        self.max_tokens = config.max_tokens
        self.temperature = config.temperature

    def complete(self, prompt: str, stream: bool = True) -> str:
        """Generate text completion."""
        with Progress(
            SpinnerColumn(),
            TextColumn("[progress.description]{task.description}"),
            console=console,
        ) as progress:
            progress.add_task("Thinking...", total=None)

            response = self.client.chat.completions.create(
                model=self.model,
                messages=[{"role": "user", "content": prompt}],
                max_tokens=self.max_tokens,
                temperature=self.temperature,
                stream=stream,
            )

        if stream:
            full_response = ""
            for chunk in response:
                if chunk.choices[0].delta.content:
                    content = chunk.choices[0].delta.content
                    print(content, end="", flush=True)
                    full_response += content
            print()
            return full_response
        else:
            return response.choices[0].message.content

    def complete_streaming(self, prompt: str):
        """Return generator for streaming responses."""
        return self.client.chat.completions.create(
            model=self.model,
            messages=[{"role": "user", "content": prompt}],
            max_tokens=self.max_tokens,
            temperature=self.temperature,
            stream=True,
        )