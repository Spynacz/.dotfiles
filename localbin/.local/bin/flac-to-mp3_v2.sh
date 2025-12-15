#!/bin/bash

source_dir="/music"
target_dir="Music mp3"

convert_flac_to_mp3() {
    flac_file="$1"
    relative_path="${flac_file#$source_dir/}"
    mp3_file="${relative_path%.flac}.mp3"
    target_path="$target_dir/$mp3_file"

    mkdir -p "$(dirname "$target_path")"

    # Skip if MP3 exists and is newer than the FLAC
    if [[ -f "$target_path" && "$target_path" -nt "$flac_file" ]]; then
        # echo "Skipping (up to date): $relative_path"
        return
    fi

    echo "Converting: $relative_path"

    # Temporary files for cover art
    cover_tmp="$(mktemp --suffix=.jpg)"
    resized_cover="$(mktemp --suffix=.jpg)"

    # Try to extract cover art
    ffmpeg -hide_banner -loglevel error -y -i "$flac_file" -an -vcodec copy "$cover_tmp" 2>/dev/null

    if [[ -s "$cover_tmp" ]]; then
        ffmpeg -hide_banner -loglevel error -y -i "$cover_tmp" \
            -vf "scale='min(300,iw)':'min(300,ih)':force_original_aspect_ratio=decrease" \
            "$resized_cover"

        # Convert with resized cover art
        ffmpeg -hide_banner -loglevel error -i "$flac_file" -i "$resized_cover" \
            -map 0:a -map 1:v \
            -c:a libmp3lame -q:a 2 \
            -id3v2_version 3 -map_metadata 0 \
            -c:v mjpeg -disposition:v attached_pic \
            "$target_path" -y
    else
        # Convert without cover art if none found
        ffmpeg -hide_banner -loglevel error -i "$flac_file" \
            -map 0:a \
            -c:a libmp3lame -q:a 2 \
            -id3v2_version 3 -map_metadata 0 \
            "$target_path" -y
    fi

    rm -f "$cover_tmp" "$resized_cover"
}

copy_album_art() { 
    source_file="$1"
    relative_path="${source_file#$source_dir/}"
    target_file="$relative_path"
    target_path="$target_dir/$target_file"

    ext="${source_file##*.}"
    ext="${ext,,}"

    if [[ "$ext" == "png" ]]; then
        target_path="${target_path%.*}.jpg"
    fi

    if [[ -f "$target_dir" && "$target_path" -nt "$source_file" ]]; then
        return
    fi

    if [[ "$ext" == "jpg" || "$ext" == "jpeg" ]]; then
        cp "$source_file" "$target_path"
        magick "$target_path" -resize 600x600\> "$target_path"
    elif [[ "$ext" == "png" ]]; then
        magick "$source_file" -resize 600x600\> "$target_path"
    fi

}

start_time=$(date +%s)

export -f convert_flac_to_mp3
export -f copy_album_art
export source_dir
export target_dir

find "$source_dir" -type f -name "*.flac" -print0 | parallel -0 convert_flac_to_mp3

find "$source_dir" -type f -name "cover.*" -print0 | parallel -0 copy_album_art

end_time=$(date +%s)
elapsed_time=$(( end_time - start_time ))
echo "Conversion completed in $elapsed_time seconds."

