#!/bin/sh

###################################################
# Source: https://github.com/serversideup/docker-php/src/s6/etc/entrypoint.d/10-init-webserver-config.sh
# Usage: 10-init-web-server-config.sh
###################################################
# This script prepares the usage of PHP-FPM-NGINX and PHP-FPM-Apache with S6 overlay. The script
# will execute at container initialization and will process templates from environment variables
# and enable the necessary websites. This script is modified to suit specific needs.
script_name="init-webserver-config"

# Check if S6 is initialized
if [ "$S6_INITIALIZED" != "true" ]; then
    echo "ℹ️  [NOTICE]: Running custom command instead of web server configuration: '$*'"
    return 0
fi

##########
# Functions
##########

process_template() {
    template_file=$1
    output_file=$2

    if [ -f "$output_file" ]; then
        echo "ℹ️ NOTICE ($script_name): $output_file already exists, so we'll use the existing file."
        return 0
    fi

    if [ ! -f "$template_file" ]; then
        echo "🛑 ERROR ($script_name): Unable to initialize container. $output_file doesn't exist and we're unable to find a template for $template_file."
        return 1
    fi

    # Get all environment variables starting with 'NGINX_', 'SSL_', and `LOG_` 
    subst_vars=$(env | grep -E '^(PHP_|NGINX_|SSL_|LOG_)' | cut -d= -f1 | awk '{printf "${%s},",$1}' | sed 's/,$//')

    # Validate that all required variables are set
    for var_name in $(echo "$subst_vars" | tr ',' ' '); do
        eval "value=\$$var_name" # Use eval to get the value of var_name
        if [ -z "$value" ]; then
            echo "🛑 ERROR ($script_name): Environment variable $var_name is not set."
            return 1
        fi
    done

    echo "($script_name): Processing $template_file → $output_file..."
    envsubst "$subst_vars" < "$template_file" > "$output_file"

    if [ "$LOG_OUTPUT_LEVEL" = "debug" ]; then
        echo "$script_name: Contents of $output_file:"
        cat $output_file
        echo
    fi
}

##########
# Main
##########

if [ "$DISABLE_DEFAULT_CONFIG" = false ]; then
    process_template /etc/nginx/nginx.conf.template /etc/nginx/nginx.conf
    process_template /etc/nginx/site-opts.d/http.conf.template /etc/nginx/site-opts.d/http.conf
else
    if [ "$LOG_OUTPUT_LEVEL" = "debug" ]; then
        echo "👉 $script_name: DISABLE_DEFAULT_CONFIG does not equal \"false\", so web server initialization will NOT be performed."
    fi
fi