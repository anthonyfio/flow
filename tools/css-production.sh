#!/bin/bash

# for every file in `src/css/` that has a `css` extension do
for file in src/css/*.css

do

  echo "Generating CSS …"

  # line 13 run through postcss using imports, cssnext and optimizations
  # line 32 output file to dist/css/
  # line 33 input file
  "$(npm bin)/postcss" \
    -u postcss-import \
    -u cssnext \
    -u postcss-colormin \
    -u postcss-minify-font-values \
    -u postcss-merge-longhand \
    -u postcss-minify-selectors \
    -u postcss-unique-selectors \
    -u postcss-zindex \
    -u postcss-merge-rules \
    -u postcss-merge-idents \
    -u postcss-reduce-idents \
    -u postcss-discard-duplicates \
    -u postcss-discard-empty \
    -u postcss-discard-comments \
      --postcss-discard-comments.removeAll true \
    -u postcss-discard-unused \
    -u cssnano \
    -u autoprefixer \
    -o dist/css/"$(basename "$file")" \
    src/css/"$(basename "$file")"

  # line 41 run through uncss
  # line 42 pass in html files to check usage
  # line 43 input file
  # line 45-47 run through postcss and clean-css to make sure it's optimized
  # # and has appropriate prefixes
  # line 48 output file to `dist/css/`
  "$(npm bin)/uncss" \
    -H dist/*.html \
    -s css/"$(basename "$file")" | \
    "$(npm bin)/cleancss" | \
    "$(npm bin)/postcss" \
    -u cssnano \
    -u autoprefixer \
    -o dist/css/"$(basename "$file")"

done
