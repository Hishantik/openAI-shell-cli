# dekuai
# CLI tool for OpenAI GPT and DALL-E

from .cli import cli
from .config import Config

__version__ = "0.2.0"

__all__ = ["cli", "Config"]