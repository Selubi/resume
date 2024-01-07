# Makefile for compiling LaTeX to PDF using XeLaTeX

# Specify the name of the main .tex file (without extension)
MAIN_TEX_FILE = $(basename $(lastword $(MAKECMDGOALS)))

# Output directory for the PDF
BUILD_DIR = ./build

# LaTeX compiler
LATEX_COMPILER = xelatex

# Make command to compile the PDF
pdf:
	mkdir -p $(BUILD_DIR)
	$(LATEX_COMPILER) -output-directory=$(BUILD_DIR) $(MAIN_TEX_FILE).tex

# Help message
help:
	@echo "Usage: make pdf <arg.tex>"
