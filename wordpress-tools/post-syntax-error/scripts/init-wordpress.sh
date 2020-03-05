#!/bin/bash

# Copied from: https://stackoverflow.com/questions/8880603/loop-through-an-array-of-strings-in-bash
function installPlugins() {
    WPCLI="$1"
    # Take the top 20 plugins: https://themegrill.com/blog/best-wordpress-plugins/
    # Add top 15: https://www.hostgator.com/blog/most-popular-wordpress-plugins/
    declare -a arr=(
                    "all-in-one-schemaorg-rich-snippets"
                    "akismet"
                    "bj-lazy-load"
                    "broken-link-checker"
                    "contact-form-7"
                    "disable-comments"
                    "everest-forms"
                    "google-analytics-for-wordpress"
                    "google-sitemap-generator"
                    "jetpack"
                    "mailchimp-for-wp"
                    "nextgen-gallery"
                    "mailchimp-for-wp"
                    "nivo-slider-lite"
                    "redirection"
                    "siteorigin-panels"
                    "social-icons"
                    "w3-total-cache"
                    "woocommerce"
                    "wordfence"
                    "wordpress-seo"
                    "wp-smushit"
                    "wp-optimize"
                    "xml-sitemap-feed"
                    "vaultpress"
                    )

    ## now loop through the above array
    for i in "${arr[@]}"
    do
       echo "Installing $i"
       $WPCLI plugin install --activate $i
       # or do whatever with individual element of the array
    done
}

if [[ "$WP_SLUG" == "" ]]; then
        echo "No \$WP_SLUG specified. Not setting up the site automatically."
else
    WPCLI="/usr/local/bin/s_php /usr/local/bin/wp.phar --allow-root"

    cd /wordpress

    if [[ "$DEBUG" == "true" ]]; then
        user="foo"
        password="bar"
    else
        user=$(pwgen 40 1)
        password=$(pwgen 40 1)
    fi

    echo "Initializing Wordpress root site..."
    $WPCLI core install --url=$WP_SLUG --title="Syntax Error Poster" --admin_user=$user --admin_email="support@polyscripted.com" --admin_password=$password

    echo "Installing plugins..."
    installPlugins "$WPCLI"

    echo "Listing all installed plugins in a blog post..."
    plugins=$($WPCLI plugin list --format=json)
    echo "==> Current list of plugins: $plugins"
    $WPCLI post create --post_status=publish --post_title='Installed Plugins' --post_content="$plugins"
fi


