#!/bin/bash

if [ ! -f "ggml-alpaca-7b-q4.bin" ]; then
    read -p "The model has not been downloaded. Would you like to download it now? (y/n)" choice
    case "$choice" in 
        y|Y ) wget https://huggingface.co/Sosaka/Alpaca-native-4bit-ggml/resolve/main/ggml-alpaca-7b-q4.bin ;;
        n|N ) ;;
        * ) echo "Invalid choice. Please enter y or n." ;;
    esac
fi

filesize=$(stat -c%s "ggml-alpaca-7b-q4.bin")
if [ $filesize -le 3221225472 ]; then
    read -p "The file size is less than or equal to 3GB. Do you want to redownload and delete the older file? (y/n)" choice
    case "$choice" in 
        y|Y ) 
            rm ggml-alpaca-7b-q4.bin
            wget https://huggingface.co/Sosaka/Alpaca-native-4bit-ggml/resolve/main/ggml-alpaca-7b-q4.bin ;;
        n|N ) exit ;;
        * ) echo "Invalid choice. Please enter y or n." ;;
    esac
fi

docker-compose up

