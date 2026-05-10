"""CLI commands using Click."""

import click
from rich.console import Console
from dekuai.gpt import GPTService
from dekuai.dalle import DalleService
from dekuai.config import Config, load_config

console = Console()


@click.group()
@click.version_option(version="0.2.0")
def cli():
    """DekuAI - OpenAI CLI tool with GPT and DALL-E support."""
    pass


@cli.command()
@click.option("--config", "-c", type=click.Path(), help="Config file path")
def auth(config):
    """Store your OpenAI API key."""
    config_obj = load_config(config)
    if config_obj.api_key:
        console.print(f"[green]API key already set (starts with {config_obj.api_key[:7]}...)[/green]")
    else:
        key = click.prompt("Enter your OpenAI API key", hide_input=True)
        config_obj.save_api_key(key)
        console.print("[green]API key saved successfully![/green]")


@cli.command()
@click.option("--config", "-c", type=click.Path(), help="Config file path")
def chat(config):
    """Start an interactive chat with GPT."""
    config_obj = load_config(config)
    if not config_obj.api_key:
        console.print("[red]No API key found. Run: dekuai auth[/red]")
        return
    service = GPTService(config_obj)
    console.print("[bold green]DekuAI Chat - Press Ctrl+C to exit[/bold green]\n")
    while True:
        try:
            prompt = click.prompt("You")
            if not prompt.strip():
                continue
            response = service.complete(prompt)
            console.print(f"[cyan]DekuAI:[/cyan] {response}\n")
        except KeyboardInterrupt:
            console.print("\n[yellow]Exiting chat...[/yellow]")
            break


@cli.command()
@click.argument("prompt")
@click.option("--size", "-s", default="1024x1024", help="Image size (256x256, 512x512, 1024x1024)")
@click.option("--count", "-n", default=1, help="Number of images")
@click.option("--config", "-c", type=click.Path(), help="Config file path")
def generate(prompt, size, count, config):
    """Generate images with DALL-E."""
    config_obj = load_config(config)
    if not config_obj.api_key:
        console.print("[red]No API key found. Run: dekuai auth[/red]")
        return
    service = DalleService(config_obj)
    console.print(f"[bold green]Generating {count} image(s)...[/bold green]")
    urls = service.generate(prompt, size=size, count=count)
    for i, url in enumerate(urls, 1):
        console.print(f"[yellow]Image {i}:[/yellow] {url}")


@cli.command()
@click.option("--config", "-c", type=click.Path(), help="Config file path")
def configure(config):
    """Show current configuration."""
    config_obj = load_config(config)
    console.print("[bold]Current Configuration:[/bold]")
    console.print(f"Config file: {config_obj.config_path}")
    console.print(f"Model: {config_obj.model}")
    console.print(f"Max tokens: {config_obj.max_tokens}")
    has_key = "Yes" if config_obj.api_key else "No"
    console.print(f"API key set: {has_key}")