#!/bin/sh

# Generate the Surroundings amalgamated org file from the .org files
# from content/reading/surroundings to latex/

# 0. Create the latex directory
rm -rf latex 2&>/dev/null
mkdir -p latex
cp -r content/reading/surroundings/images latex/

# 1. Copy the files to a temporary directory
mkdir -p .tmp
cp -r content/reading/surroundings .tmp/
rm .tmp/surroundings/surroundings.org

# 2. Trim the first line and the last line for each file
for file in .tmp/surroundings/*.org; do
    trimmed_file="${file}.trimmed"
    line_count=`wc -l < "$file"`
    # If the file has more than 2 lines, trim it
    if [ "$line_count" -gt 2 ]; then
        # tail +2 skips the first line, head -n -1 drops the last
        # Since 'head -n -1' is not POSIX, use 'sed' instead
        sed '1d' "$file" | sed '$d' > "$trimmed_file"
    else
        # If not enough lines to trim, just copy the file as-is
        cp "$file" "$trimmed_file"
    fi
done

# 3. Merge all the trimmed files into surroundings-final.org
cat .tmp/surroundings/*.trimmed > latex/surroundings-final.org

# 4. Cleanup
rm -r .tmp
