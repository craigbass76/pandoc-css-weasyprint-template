#!/bin/bash

# First, the script prints out a blank line, just to have a bit of a buffer between the command prompt and the script output.
echo " "

# Now it lists out all of the files in the current directory that have a .md extension. It does not print out the .md
ls -a *.md | cut -d "." -f 1

# This is prompting us for the file we want to convert. Copy the one from the output of the ls command and paste it here.
read -p "Filename: " filename

# Now the script will account for whether or not we want a Landscape or Portrait layout

PS3='Please enter your choice: '
options=("Landscape" "Portrait")
select opt in "${options[@]}"
do
    case $opt in
        "Landscape")
            while true; do
            filename=$filename
# This is what happens is we picked Landscape (it uses the style-landscape.css stylesheet)
            pandoc -s --template="templates/default.html" -f markdown-smart --toc -c style-landscape.css "$filename.md" -o "$filename.html"
            python3 -m weasyprint "$filename.html" "$filename.pdf"

            echo " "
            echo " "
            read -p "Press [Enter] key to make another PDF, or [Ctrl + C] to kill the script"

            done
            ;;
        "Portrait")
            while true; do
            filename=$filename
# This is what happens is we picked  Portrait (it uses the style-portrait.css stylesheet)
            pandoc -s --template="templates/default.html" -f markdown-smart --toc -c style-portrait.css "$filename.md" -o "$filename.html"
            python3 -m weasyprint "$filename.html" "$filename.pdf"

            echo " "
            echo " "
            read -p "Press [Enter] key to make another PDF, or [Ctrl + C] to kill the script"

            done
            ;;
        *) echo "invalid option $REPLY";;
    esac

done
