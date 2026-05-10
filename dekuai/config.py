"""Configuration management."""

import os
from pathlib import Path
from dataclasses import dataclass
from typing import Optional
from dotenv import load_dotenv


@dataclass
class Config:
    api_key: Optional[str] = None
    model: str = "gpt-3.5-turbo"
    max_tokens: int = 4000
    temperature: float = 0.7
    config_path: Optional[Path] = None


def get_config_path() -> Path:
    """Get the config directory path."""
    xdg_config = os.environ.get("XDG_CONFIG_HOME")
    if xdg_config:
        return Path(xdg_config) / "dekuai"
    return Path.home() / ".config" / "dekuai"


def load_config(config_file: Optional[str] = None) -> Config:
    """Load configuration from file and environment."""
    load_dotenv()  # Load .env if present

    config_dir = get_config_path()
    config_dir.mkdir(parents=True, exist_ok=True)

    if config_file:
        config_path = Path(config_file)
    else:
        config_path = config_dir / "config.toml"

    config = Config(config_path=config_path)

    # Load from env
    config.api_key = os.environ.get("OPENAI_API_KEY") or os.environ.get("OPENAI_TOKEN")

    # Load from config file
    if config_path.exists():
        config = _parse_config_file(config_path, config)

    return config


def _parse_config_file(path: Path, config: Config) -> Config:
    """Parse TOML config file."""
    try:
        import tomllib
    except ImportError:
        import tomli as tomllib

    with open(path, "rb") as f:
        data = tomllib.load(f)

    if "api_key" in data and not config.api_key:
        config.api_key = data["api_key"]
    if "model" in data:
        config.model = data["model"]
    if "max_tokens" in data:
        config.max_tokens = data["max_tokens"]
    if "temperature" in data:
        config.temperature = data["temperature"]

    return config


def save_config(config: Config):
    """Save configuration to file."""
    import tomllib

    config_path = config.config_path or get_config_path() / "config.toml"
    config_path.parent.mkdir(parents=True, exist_ok=True)

    data = {
        "model": config.model,
        "max_tokens": config.max_tokens,
        "temperature": config.temperature,
    }
    if config.api_key:
        data["api_key"] = config.api_key

    with open(config_path, "wb") as f:
        tomllib.dump(data, f)