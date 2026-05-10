"""Configuration management."""

import os
from pathlib import Path
from dataclasses import dataclass, field
from typing import Optional, List
from dotenv import load_dotenv


@dataclass
class Model:
    """AI model definition."""
    id: str
    name: str
    provider: str
    endpoint: str
    supports_streaming: bool = True
    supports_images: bool = False


# Supported models from opencode.ai/zen
MODELS = [
    # GPT Models (responses endpoint)
    Model("gpt-5.5", "GPT 5.5", "openai", "https://opencode.ai/zen/v1/responses", supports_images=True),
    Model("gpt-5.5-pro", "GPT 5.5 Pro", "openai", "https://opencode.ai/zen/v1/responses"),
    Model("gpt-5.4", "GPT 5.4", "openai", "https://opencode.ai/zen/v1/responses"),
    Model("gpt-5.4-pro", "GPT 5.4 Pro", "openai", "https://opencode.ai/zen/v1/responses"),
    Model("gpt-5.4-mini", "GPT 5.4 Mini", "openai", "https://opencode.ai/zen/v1/responses"),
    Model("gpt-5.4-nano", "GPT 5.4 Nano", "openai", "https://opencode.ai/zen/v1/responses"),
    Model("gpt-5.3-codex", "GPT 5.3 Codex", "openai", "https://opencode.ai/zen/v1/responses", supports_images=True),
    Model("gpt-5.3-codex-spark", "GPT 5.3 Codex Spark", "openai", "https://opencode.ai/zen/v1/responses"),
    Model("gpt-5.2", "GPT 5.2", "openai", "https://opencode.ai/zen/v1/responses"),
    Model("gpt-5.2-codex", "GPT 5.2 Codex", "openai", "https://opencode.ai/zen/v1/responses"),
    Model("gpt-5.1", "GPT 5.1", "openai", "https://opencode.ai/zen/v1/responses"),
    Model("gpt-5.1-codex", "GPT 5.1 Codex", "openai", "https://opencode.ai/zen/v1/responses"),
    Model("gpt-5.1-codex-max", "GPT 5.1 Codex Max", "openai", "https://opencode.ai/zen/v1/responses"),
    Model("gpt-5.1-codex-mini", "GPT 5.1 Codex Mini", "openai", "https://opencode.ai/zen/v1/responses"),
    Model("gpt-5", "GPT 5", "openai", "https://opencode.ai/zen/v1/responses"),
    Model("gpt-5-codex", "GPT 5 Codex", "openai", "https://opencode.ai/zen/v1/responses"),
    Model("gpt-5-nano", "GPT 5 Nano", "openai", "https://opencode.ai/zen/v1/responses"),
    Model("gpt-3.5-turbo", "GPT 3.5 Turbo", "openai", "https://api.openai.com/v1/chat/completions"),
    Model("gpt-4", "GPT 4", "openai", "https://api.openai.com/v1/chat/completions"),

    # Claude Models (messages endpoint)
    Model("claude-opus-4-7", "Claude Opus 4.7", "anthropic", "https://opencode.ai/zen/v1/messages"),
    Model("claude-opus-4-6", "Claude Opus 4.6", "anthropic", "https://opencode.ai/zen/v1/messages"),
    Model("claude-opus-4-5", "Claude Opus 4.5", "anthropic", "https://opencode.ai/zen/v1/messages"),
    Model("claude-opus-4-1", "Claude Opus 4.1", "anthropic", "https://opencode.ai/zen/v1/messages"),
    Model("claude-sonnet-4-6", "Claude Sonnet 4.6", "anthropic", "https://opencode.ai/zen/v1/messages"),
    Model("claude-sonnet-4-5", "Claude Sonnet 4.5", "anthropic", "https://opencode.ai/zen/v1/messages"),
    Model("claude-sonnet-4", "Claude Sonnet 4", "anthropic", "https://opencode.ai/zen/v1/messages"),
    Model("claude-haiku-4-5", "Claude Haiku 4.5", "anthropic", "https://opencode.ai/zen/v1/messages"),
    Model("claude-3-5-haiku", "Claude Haiku 3.5", "anthropic", "https://opencode.ai/zen/v1/messages"),

    # Gemini Models
    Model("gemini-3.1-pro", "Gemini 3.1 Pro", "google", "https://opencode.ai/zen/v1/models/gemini-3.1-pro"),
    Model("gemini-3-flash", "Gemini 3 Flash", "google", "https://opencode.ai/zen/v1/models/gemini-3-flash"),

    # OpenAI-compatible (Qwen, MiniMax, GLM, Kimi, etc.)
    Model("qwen3.6-plus", "Qwen 3.6 Plus", "openai-compatible", "https://opencode.ai/zen/v1/chat/completions"),
    Model("qwen3.5-plus", "Qwen 3.5 Plus", "openai-compatible", "https://opencode.ai/zen/v1/chat/completions"),
    Model("minimax-m2.7", "MiniMax M2.7", "openai-compatible", "https://opencode.ai/zen/v1/chat/completions"),
    Model("minimax-m2.5", "MiniMax M2.5", "openai-compatible", "https://opencode.ai/zen/v1/chat/completions"),
    Model("minimax-m2.5-free", "MiniMax M2.5 Free", "openai-compatible", "https://opencode.ai/zen/v1/chat/completions"),
    Model("glm-5.1", "GLM 5.1", "openai-compatible", "https://opencode.ai/zen/v1/chat/completions"),
    Model("glm-5", "GLM 5", "openai-compatible", "https://opencode.ai/zen/v1/chat/completions"),
    Model("kimi-k2.5", "Kimi K2.5", "openai-compatible", "https://opencode.ai/zen/v1/chat/completions"),
    Model("kimi-k2.6", "Kimi K2.6", "openai-compatible", "https://opencode.ai/zen/v1/chat/completions"),
    Model("big-pickle", "Big Pickle", "openai-compatible", "https://opencode.ai/zen/v1/chat/completions"),
    Model("ring-2.6-1t-free", "Ring 2.6 1T", "openai-compatible", "https://opencode.ai/zen/v1/chat/completions"),
    Model("nemotron-3-super-free", "Nemotron 3 Super Free", "openai-compatible", "https://opencode.ai/zen/v1/chat/completions"),
]

MODEL_MAP = {m.id: m for m in MODELS}


@dataclass
class Config:
    api_key: Optional[str] = None
    model: str = "gpt-3.5-turbo"
    max_tokens: int = 4000
    temperature: float = 0.7
    config_path: Optional[Path] = None
    base_url: Optional[str] = "https://opencode.ai/zen/v1"


def get_config_path() -> Path:
    """Get the config directory path."""
    xdg_config = os.environ.get("XDG_CONFIG_HOME")
    if xdg_config:
        return Path(xdg_config) / "dekuai"
    return Path.home() / ".config" / "dekuai"


def load_config(config_file: Optional[str] = None) -> Config:
    """Load configuration from file and environment."""
    load_dotenv()

    config_dir = get_config_path()
    config_dir.mkdir(parents=True, exist_ok=True)

    if config_file:
        config_path = Path(config_file)
    else:
        config_path = config_dir / "config.toml"

    config = Config(config_path=config_path)

    # Load from env
    config.api_key = os.environ.get("OPENAI_API_KEY") or os.environ.get("OPENAI_TOKEN")
    config.base_url = os.environ.get("DEKUAI_BASE_URL") or config.base_url

    # Load from config file
    if config_path.exists():
        config = _parse_config_file(config_path, config)

    return config


def _parse_config_file(path: Path, config: Config) -> Config:
    """Parse TOML config file."""
    try:
        import tomllib
    except ImportError:
        try:
            import tomli as tomllib
        except ImportError:
            return config

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
    if "base_url" in data:
        config.base_url = data["base_url"]

    return config


def get_model(model_id: str) -> Optional[Model]:
    """Get model by ID."""
    return MODEL_MAP.get(model_id)


def list_models() -> List[Model]:
    """List all available models."""
    return MODELS


def save_config(config: Config):
    """Save configuration to file."""
    try:
        import tomllib
    except ImportError:
        try:
            import tomli as tomllib
        except ImportError:
            print("Warning: tomllib not available, config not saved")
            return

    config_path = config.config_path or get_config_path() / "config.toml"
    config_path.parent.mkdir(parents=True, exist_ok=True)

    data = {
        "model": config.model,
        "max_tokens": config.max_tokens,
        "temperature": config.temperature,
        "base_url": config.base_url,
    }
    if config.api_key:
        data["api_key"] = config.api_key

    with open(config_path, "wb") as f:
        tomllib.dump(data, f)