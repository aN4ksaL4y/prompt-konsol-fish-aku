# Fish Shell Prompt with Hacker News Fetcher

This script is a Fish shell configuration that customizes the shell prompt and provides system information along with the top Hacker News stories. It includes:
- A function to fetch and display the top 7 stories from Hacker News with caching.
- Display of system information such as RAM usage, top CPU consumers, and the current date.
- A Git integration to show the current branch when inside a Git repository.
- A customized Fish prompt with user and directory information.

## Features

### 1. **Fetch Top Hacker News Stories with Caching**
- The `fetch_hacker_news` function retrieves the top 7 stories from Hacker News using the Hacker News Firebase API.
- The fetched titles are cached for 1 hour to avoid unnecessary network requests.
- If the cached data is less than 1 hour old, it is displayed from the cache.
  
### 2. **System Information**
- Displays current RAM usage.
- Lists the top 5 processes consuming CPU resources.
- Displays the current date and time in `YYYY-MM-DD HH:MM:SS` format.

### 3. **Fish Shell Prompt**
- The prompt displays the user, hostname, current directory, and the current Git branch (if inside a Git repository).
- A custom red `➜` prompt symbol is used, with a blinking block cursor.

## Installation

1. **Install Fish Shell**:
   If you don't already have Fish shell installed, you can install it by following the [installation instructions](https://fishshell.com/).
   
2. **Add Script to `config.fish`**:
   Copy the script into your Fish shell configuration file located at `~/.config/fish/config.fish`.

   ```bash
   nano ~/.config/fish/config.fish
