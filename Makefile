# Makefile for compiling LaTeX to PDF using XeLaTeX

# Specify the name of the main .tex file (without extension)
MAIN_TEX_FILE = $(basename $(lastword $(MAKECMDGOALS)))

# Output directory for the PDF
BUILD_DIR = ./build

# Make command to compile the PDF
# Is aligned with the latex-workshop.latex.recipe.default in settings.json.
pdf:
	mkdir -p $(BUILD_DIR)
	latexmk -synctex=1 -interaction=nonstopmode -file-line-error -xelatex -outdir=$(BUILD_DIR) $(MAIN_TEX_FILE).tex

# Help message
help:
	@echo "Usage: make pdf <arg.tex>"
