#!/bin/bash

print_colored_message() {

    YELLOW='\033[1;33m'

    NC='\033[0m'

    echo -e "${YELLOW}"
    echo "      _  _                        ___  "
    echo "  ___| || |  ___ _ __   ___ _ __ / _ \ "
    echo " / __| || |_/ __| '_ \ / _ \ '__| | | |"
    echo "| (__|__   _\__ \ |_) |  __/ |  | |_| |"
    echo " \___|  |_| |___/ .__/ \___|_|   \___/ "
    echo "                 |_|                    "
    echo "#################################################################################"
    echo "#| 'Technologies Web' Tool check for Technologies Web in Domain/subdomain       #"
    echo "#|  Author: By C4sper0                                                          #"
    echo "#|  account Twitter(X): @C4sper0                                                #"
    echo "#################################################################################"
    echo -e "${NC}"
}

print_colored_message

input_file="http200.txt"


if [[ ! -f "$input_file" ]]; then
    echo "File $input_file does not exist."
    exit 1
fi


declare -a technologies=("WordPress" "Amazon" "Ruby" "Drupal" "Nginx" "Pantheon" "Varnish" "PHP" "Laravel" "Kentico CMS" "Craft CMS" "IIS" "Vue.js" "Nuxt.js" "Apache" "Ruby" "Python" "Bootstrap" "Less" "Node.js" "Odoo" "LocomotiveCMS" "vuetify" "swiper" "jQuery" "OpenResty" "Java" "Atlassian Confluence" "Angular" "Zone.js" "Clarity" "Marked" "Axios" "Adobe Experience Manager" "ZURB Foundation" "React" "Contentful" "Envoy" "Express")


output_dir="output"
mkdir -p "$output_dir"


processed_urls="processed_urls.txt"
> "$processed_urls"


while IFS= read -r line; do
    url=$(echo "$line" | awk '{print $1}')
    

    if grep -q "$url" "$processed_urls"; then
        continue
    fi


    url_added=false


    for tech in "${technologies[@]}"; do
        if echo "$line" | grep -q "$tech"; then
            output_file="$output_dir/${tech}.txt"
            

            if ! grep -q "$url" "$output_file"; then
                echo "$url" >> "$output_file"
                echo "$url" >> "$processed_urls"
                url_added=true
            fi
            

            if [ "$url_added" = true ]; then
                break
            fi
        fi
    done
done < "$input_file"


for tech in "${technologies[@]}"; do
    output_file="$output_dir/${tech}.txt"
    sort -u "$output_file" -o "$output_file"
done

echo -e '\033[1;33m [*] Done Technologies Extracted'
