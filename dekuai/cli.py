"""CLI commands using Click."""

import sys
import click
from rich.console import Console
from rich.table import Table
from dekuai.config import load_config, list_models, get_model, Config
from dekuai.gpt import AIService

console = Console()


@click.group()
@click.version_option(version="0.2.0")
def cli():
    """DekuAI - Multi-model AI CLI tool (OpenAI, Claude, Gemini, and more)."""
    pass


@cli.command()
@click.option("--config", "-c", type=click.Path(), help="Config file path")
def auth(config):
    """Store your API key."""
    config_obj = load_config(config)
    if config_obj.api_key:
        console.print(f"[green]API key already set (starts with {config_obj.api_key[:7]}...)[/green]")
    else:
        key = click.prompt("Enter your API key", hide_input=True)
        config_obj.api_key = key
        save_config(config_obj)
        console.print("[green]API key saved successfully![/green]")


def save_config(config: Config):
    """Save config to file."""
    try:
        import tomllib
    except ImportError:
        try:
            import tomli as tomllib
        except ImportError:
            return

    config_path = config.config_path
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


@cli.command()
@click.argument("prompt")
@click.option("--model", "-m", default=None, help="Model to use")
@click.option("--config", "-c", type=click.Path(), help="Config file path")
def ask(prompt, model, config):
    """Ask a single question and get response."""
    config_obj = load_config(config)
    model_id = model or config_obj.model

    model_info = get_model(model_id)
    if not model_info:
        console.print(f"[red]Unknown model: {model_id}[/red]")
        return

    service = AIService(config_obj, model_id)

    console.print(f"[dim]Using {model_info.name}...[/dim]")
    try:
        for chunk in service.complete_streaming(prompt):
            print(chunk, end="", flush=True)
        print()
    except Exception as e:
        console.print(f"[red]Error: {e}[/red]")


@cli.command()
@click.option("--model", "-m", default=None, help="Model to use")
@click.option("--config", "-c", type=click.Path(), help="Config file path")
def chat(model, config):
    """Start an interactive chat."""
    config_obj = load_config(config)
    model_id = model or config_obj.model

    model_info = get_model(model_id)
    if not model_info:
        console.print(f"[red]Unknown model: {model_id}[/red]")
        return

    service = AIService(config_obj, model_id)

    console.print(f"[bold green]DekuAI Chat - {model_info.name}[/bold green]")
    console.print("[dim]Press Ctrl+C to exit | Type 'model <name>' to switch | Type 'models' to list[/dim]\n")

    conversation = []

    while True:
        try:
            user_input = click.prompt("You")

            if user_input.lower() == "exit":
                break
            elif user_input.lower() == "models":
                list_available_models()
                continue
            elif user_input.lower().startswith("model "):
                new_model = user_input[6:].strip()
                new_model_info = get_model(new_model)
                if new_model_info:
                    model_id = new_model
                    model_info = new_model_info
                    service = AIService(config_obj, model_id)
                    console.print(f"[green]Switched to {model_info.name}[/green]")
                else:
                    console.print(f"[red]Unknown model: {new_model}[/red]")
                continue

            console.print(f"[cyan]{model_info.name}:[/cyan] ", end="")

            conversation.append({"role": "user", "content": user_input})

            try:
                for chunk in service.complete_streaming(user_input):
                    print(chunk, end="", flush=True)
                print()
            except Exception as e:
                console.print(f"\n[red]Error: {e}[/red]")

            conversation.append({"role": "assistant", "content": ""})

        except KeyboardInterrupt:
            console.print("\n[yellow]Exiting chat...[/yellow]")
            break


@cli.command()
def models():
    """List all available models."""
    list_available_models()


def list_available_models():
    """Display available models in a table."""
    all_models = list_models()

    table = Table(title="Available Models")
    table.add_column("ID", style="cyan")
    table.add_column("Name", style="green")
    table.add_column("Provider", style="yellow")

    for model in all_models:
        table.add_row(model.id, model.name, model.provider)

    console.print(table)
    console.print(f"\n[dim]Total: {len(all_models)} models[/dim]")


@cli.command()
@click.argument("prompt")
@click.option("--size", "-s", default="1024x1024", help="Image size")
@click.option("--count", "-n", default=1, help="Number of images")
@click.option("--config", "-c", type=click.Path(), help="Config file path")
def generate(prompt, size, count, config):
    """Generate images with DALL-E."""
    config_obj = load_config(config)
    if not config_obj.api_key:
        console.print("[red]API key required for image generation. Run: dekuai auth[/red]")
        return

    service = AIService(config_obj)
    console.print(f"[bold green]Generating {count} image(s)...[/bold green]")

    try:
        urls = service.generate(prompt, size=size, count=count)
        for i, url in enumerate(urls, 1):
            console.print(f"[yellow]Image {i}:[/yellow] {url}")
    except Exception as e:
        console.print(f"[red]Error: {e}[/red]")


@cli.command()
@click.option("--config", "-c", type=click.Path(), help="Config file path")
def configure(config):
    """Show or set configuration."""
    config_obj = load_config(config)
    model_info = get_model(config_obj.model)

    console.print("[bold]Current Configuration:[/bold]")
    console.print(f"Config file: {config_obj.config_path}")
    console.print(f"Model: {model_info.name if model_info else config_obj.model} ({config_obj.model})")
    console.print(f"Max tokens: {config_obj.max_tokens}")
    console.print(f"Temperature: {config_obj.temperature}")
    console.print(f"Base URL: {config_obj.base_url}")
    has_key = "Yes" if config_obj.api_key else "No"
    console.print(f"API key set: {has_key}")


@cli.command()
@click.option("--model", "-m", default=None, help="Set default model")
@click.option("--max-tokens", "-t", default=None, type=int, help="Set max tokens")
@click.option("--temperature", default=None, type=float, help="Set temperature")
@click.option("--config", "-c", type=click.Path(), help="Config file path")
def setconfig(model, max_tokens, temperature, config):
    """Update configuration values."""
    config_obj = load_config(config)

    if model:
        model_info = get_model(model)
        if model_info:
            config_obj.model = model
            console.print(f"[green]Model set to {model_info.name}[/green]")
        else:
            console.print(f"[red]Unknown model: {model}[/red]")
            return

    if max_tokens is not None:
        config_obj.max_tokens = max_tokens
        console.print(f"[green]Max tokens set to {max_tokens}[/green]")

    if temperature is not None:
        config_obj.temperature = temperature
        console.print(f"[green]Temperature set to {temperature}[/green]")

    save_config(config_obj)