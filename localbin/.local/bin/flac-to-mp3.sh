#!/bin/bash

source_dir="/music"
target_dir="Music mp3"

convert_flac_to_mp3() {
    flac_file="$1"
    relative_path="${flac_file#$source_dir/}"
    mp3_file="${relative_path%.flac}.mp3"
    mkdir -p "$target_dir/$(dirname "$mp3_file")"

    # Convert using ffmpeg with good quality settings and metadata copying
    ffmpeg -i "$flac_file" -q:a 2 -map_metadata 0 "$target_dir/$mp3_file" -y
}

start_time=$(date +%s)

export -f convert_flac_to_mp3
export source_dir
export target_dir

find "$source_dir" -type f -name "*.flac" -print0 | parallel -0 convert_flac_to_mp3

end_time=$(date +%s)
elapsed_time=$(( end_time - start_time ))
echo "Conversion completed in $elapsed_time seconds."

