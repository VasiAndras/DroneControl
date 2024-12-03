#!/bin/bash

# Save the current directory (where compile_latex.sh is located)
root_dir=$(pwd)

# Create a temporary directory
tmp_dir=$(mktemp -d)

# Copy main.tex to the temporary directory
cp main.tex "$tmp_dir"

# Navigate to the temporary directory
cd "$tmp_dir" || exit

# Compile the LaTeX document
pdflatex main.tex

# Run BibTeX for bibliography management
bibtex main

# Compile the LaTeX document two more times to ensure all references are updated
pdflatex main.tex
pdflatex main.tex

# Move the compiled PDF back to the original directory where compile_latex.sh is located
mv main.pdf "$root_dir"

# Clean up: move other auxiliary files to the temporary directory
mv main.aux main.bbl main.blg main.log main.toc "$tmp_dir"

# Return to the root directory
cd "$root_dir" || exit

# Remove the temporary directory
rm -rf "$tmp_dir"

echo "Compilation process completed!"
