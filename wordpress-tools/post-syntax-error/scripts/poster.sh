#!/bin/bash

WPCLI="/usr/local/bin/s_php /usr/local/bin/wp.phar --allow-root"
cd /wordpress
$WPCLI post create --post_status=publish --post_title='Syntax Error Poster Initialzed' --post_content='This site will create a new blog post, every time a syntax error is detected in logs.'

# Check to see if a pipe exists on stdin.
if [ -p /dev/stdin ]; then
        echo "Receiving piped data!"

        # If we want to read the input line by line
        while IFS= read line; do
                echo "Line: ${line}"
                if [[ "$line" =~ syntax\ error ]]; then
                    echo "Error detected. Posting..."
                    $WPCLI post create --post_status=publish --post_title='Syntax Error' --post_content="$line"
                fi
        done
        # Or if we want to simply grab all the data, we can simply use cat instead
        # cat
else
        echo "No input was found on stdin, skipping!"
fi
