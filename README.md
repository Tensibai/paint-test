# Descripion

This is code made in a live exam around paint behavior to replace a color in an image or only in a zone of adjacent pixels(up, down, right, left, diagonals are excluded), description of code is made as comments in change-color.rb

## Testing it

You'll need a ruby environment and bundler installed.

run
```
bundle install
rspec -f documentation
```

## Specs

The test are made from an original image of 4x4 pixels.
First test handle all colors replaced
Second test handle only a zone replacement.