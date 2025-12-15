#!/bin/bash

source_dir="/music"
target_dir="Music opus"

convert_flac_to_opus() {
    flac_file="$1"
    relative_path="${flac_file#$source_dir/}"
    opus_file="${relative_path%.flac}.opus"
    mkdir -p "$target_dir/$(dirname "$opus_file")"
    opusenc --bitrate 160 "$flac_file" "$target_dir/$opus_file"
}

start_time=$(date +%s)

export -f convert_flac_to_opus
export source_dir
export target_dir

find "$source_dir" -type f -name "*.flac" -print0 | parallel -0 convert_flac_to_opus

end_time=$(date +%s)

elapsed_time=$(( end_time - start_time ))
echo "Conversion completed in $elapsed_time seconds."

