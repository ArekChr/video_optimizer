#!/bin/bash

# Directory containing the videos
input_directory="./input"

# Output directory for optimized videos
output_directory="./output"

# Create the output directory if it doesn't exist
mkdir -p "$output_directory"

# Iterate over each video file in the input directory
for video_file in "$input_directory"/*.mov; do
    echo "Optimizing $video_file"
    
    # Get the filename without extension
    filename=$(basename "$video_file" .mov)

    # Construct the output file path
    output_file="$output_directory/$filename.mov"

    # Use FFmpeg to optimize the video file
    ffmpeg -i "$video_file" -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 128k "$output_file"

    # Get the size of the optimized video file
    optimized_file_size=$(du -h "$output_file" | cut -f 1)

    # Print the optimized video file path and size
    echo "Optimized video: $output_file ($optimized_file_size)"
done