#!/bin/bash

# Script to copy app/ directory files to grubdaily-gourmet without overwriting existing files
# Source directory
SOURCE_DIR="/Users/tomcorley/dev/grubdaily/app"
# Destination directory
DEST_DIR="/Users/tomcorley/dev/grubdaily-gourmet/app"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting copy process from grubdaily to grubdaily-gourmet${NC}"
echo -e "Source: ${SOURCE_DIR}"
echo -e "Destination: ${DEST_DIR}"
echo ""

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}Error: Source directory does not exist: $SOURCE_DIR${NC}"
    exit 1
fi

# Create destination directory if it doesn't exist
if [ ! -d "$DEST_DIR" ]; then
    echo -e "${YELLOW}Creating destination directory: $DEST_DIR${NC}"
    mkdir -p "$DEST_DIR"
fi

# Copy files using rsync with options:
# -a: archive mode (preserves permissions, timestamps, etc.)
# -v: verbose output
# -r: recursive
# --ignore-existing: skip files that already exist in destination
# --exclude: exclude .DS_Store files
echo -e "${GREEN}Copying files (skipping existing files)...${NC}"

rsync -avr --ignore-existing --exclude='.DS_Store' "$SOURCE_DIR/" "$DEST_DIR/"

# Check if rsync was successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Copy completed successfully!${NC}"
    echo ""
    echo -e "${YELLOW}Note: Existing files in destination were preserved (not overwritten)${NC}"
    echo ""
    echo -e "Files copied to: $DEST_DIR"
else
    echo -e "${RED}✗ Copy failed with errors${NC}"
    exit 1
fi

# Optional: Show what directories were created/updated
echo -e "${GREEN}Directory structure in destination:${NC}"
ls -la "$DEST_DIR" 