#!/usr/bin/env python3
"""Main CLI entry point."""

import sys
from rich.console import Console
from dekuai.cli import cli

def main():
    console = Console()
    try:
        cli()
    except KeyboardInterrupt:
        console.print("\n[yellow]Exiting DekuAI...[/yellow]")
        sys.exit(0)

if __name__ == "__main__":
    main()