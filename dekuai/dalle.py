"""DALL-E image generation service."""

from typing import List
from openai import OpenAI
from rich.console import Console
from rich.progress import Progress, SpinnerColumn, TextColumn
from dekuai.config import Config

console = Console()


class DalleService:
    """Service for DALL-E image generation."""

    def __init__(self, config: Config):
        self.client = OpenAI(api_key=config.api_key)

    def generate(
        self,
        prompt: str,
        size: str = "1024x1024",
        count: int = 1,
        quality: str = "standard",
    ) -> List[str]:
        """Generate images from text prompt."""
        with Progress(
            SpinnerColumn(),
            TextColumn("[progress.description]{task.description}"),
            console=console,
        ) as progress:
            progress.add_task("Generating images...", total=None)

            response = self.client.images.generate(
                model="dall-e-3",
                prompt=prompt,
                n=min(count, 10),  # OpenAI limits n
                size=size,
                quality=quality,
            )

        return [item.url for item in response.data]

    def generate_variations(self, image_path: str, size: str = "1024x1024") -> List[str]:
        """Generate variations of an existing image."""
        with Progress(
            SpinnerColumn(),
            TextColumn("[progress.description]{task.description}"),
            console=console,
        ) as progress:
            progress.add_task("Creating variations...", total=None)

            response = self.client.images.create_variation(
                image=open(image_path, "rb"),
                n=1,
                size=size,
            )

        return [item.url for item in response.data]