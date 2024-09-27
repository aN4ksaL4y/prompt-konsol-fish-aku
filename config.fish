if status is-interactive
function fetch_hacker_news
    set cache_file ~/.cache/hacker_news_titles.txt
    set cache_time_file ~/.cache/hacker_news_timestamp.txt

    # Check if the cache file exists and if it's older than 1 hour
    if test -f $cache_file
        set last_fetched (cat $cache_time_file)
        set current_time (date +%s)  # Get the current time in seconds since epoch

        # Check if the cache is older than 1 hour (3600 seconds)
        set time_diff (math "$current_time - $last_fetched")
        if test $time_diff -lt 3600
            # If the cache is recent, read from it
            echo "Top Hacker News (from cache):"
            cat $cache_file
            return
        end
    end

    # Fetch the top stories from Hacker News
    set news (curl -s "https://hacker-news.firebaseio.com/v0/topstories.json")

    # Create cache directory if it doesn't exist
    mkdir -p ~/.cache

    # Loop through the first 5 news IDs and get their titles
    echo "Top Hacker News:"
    set titles ""
    for id in (echo $news | jq -r '.[]' | head -n 7)
        set title (curl -s "https://hacker-news.firebaseio.com/v0/item/$id.json" | jq -r '.title')
        set titles "$titles- $title\n"
    end

    # Save titles to cache file
    echo -e $titles > $cache_file
    echo (date +%s) > $cache_time_file  # Store current time in seconds

    # Display the fetched titles
    echo $titles
end

function show_system_info
    fetch_hacker_news
    # RAM Usage
    echo -n "RAM: "
    set_color red
    echo -n (free -m | awk '/Mem:/ {print $3"MB / "$2"MB"}')

    set_color normal
    echo -n ' | Top CPU Consumers:'

    # Display top 5 CPU-consuming processes
    set_color blue
    echo (ps -eo comm,%cpu --sort=-%cpu | head -n 6 | tail -n 5 | awk '{print "\n" $1 ": " $2 "%"}')

    # Date
    set_color normal
    echo -n ' | Date: '
    set_color green
    echo (date "+%Y-%m-%d %H:%M:%S")

    echo  # Newline for spacing
end

function fish_prompt
# Show system info only when entering a new terminal session
if status is-interactive
    show_system_info
end

    # User@Host
    set_color cyan
    echo -n (whoami) "@" (hostname | cut -d '.' -f 1)

    # In Directory
    set_color magenta
    echo -n ' in '

    set_color yellow
    echo -n (prompt_pwd)

# Check if we're inside a Git repository
if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set_color normal
    set branch (git branch --show-current ^/dev/null)
if test -n "$branch"
    set_color green
    echo -n ' (git:' $branch ')'
end
end

    # Prompt Symbol and Blinking Cursor
    set_color red
    echo -n ' ➜ '
    echo -ne '\033[5 q'  # Blinking block cursor
    set_color normal
end


end
