#!/bin/bash

MUSIC_DIR="$1"

if [ -z "$MUSIC_DIR" ]; then
    echo "Usage: $0 /path/to/music/directory"
    exit 1
fi

downsample() {
    file="$1"
    BIT_DEPTH=$(ffprobe -v error -select_streams a:0 -show_entries stream=bits_per_raw_sample -of default=noprint_wrappers=1:nokey=1 "$file")
    SAMPLE_RATE=$(ffprobe -v error -select_streams a:0 -show_entries stream=sample_rate -of default=noprint_wrappers=1:nokey=1 "$file")

    if [ -z "$BIT_DEPTH" ]; then
        BIT_DEPTH=$(ffprobe -v error -select_streams a:0 -show_entries stream=bits_per_sample -of default=noprint_wrappers=1:nokey=1 "$file")
    fi

    if [ -z "$BIT_DEPTH" ]; then
        BIT_DEPTH=16
    fi

    BIT_DEPTH=${BIT_DEPTH%.*}
    SAMPLE_RATE=${SAMPLE_RATE%.*}

    if [ "$BIT_DEPTH" -gt 16 ] || [ "$SAMPLE_RATE" -gt 48000 ]; then
        # echo "Converting $file from ${BIT_DEPTH}bit/${SAMPLE_RATE}Hz to 16bit/48000Hz (in place, using soxr)"
        TMPFILE="${file}.tmp"
        ffmpeg -hide_banner -loglevel warning -y -i "$file" -af aresample=48000:resampler=soxr:precision=33:osf=s16:dither_method=triangular -f flac "$TMPFILE" && mv "$TMPFILE" "$file"
        # else
        #     echo "Skipping $file (already CD quality or lower)"
    fi
}

export -f downsample

start_time=$(date +%s)

find "$MUSIC_DIR" -type f -iname "*.flac" -print0 | parallel -0 downsample

end_time=$(date +%s)
elapsed_time=$(( end_time - start_time ))

echo "Downsampling complete in $elapsed_time seconds."

