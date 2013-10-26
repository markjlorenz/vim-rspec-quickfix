# VIM Rspec Quickfix
> Get your rspec errors in VIM's quickfix

## TL;DR, A Screen Shot
![vim-rspec-quickfix](https://raw.github.com/dapplebeforedawn/vim-rspec-quickfix/master/vim-rspec-quickfix.png)

## Installation
This repo is more of a how-to, than packaged sofware.  Imma show you how to do it, but once you see how all the pieces fit togeather, you gotta adapt it how you like.  Don't worry ruby, VIM and rspec all play by the unix rule, "streams of text", so it's really simple!

In your shell:
```bash
# Setup the spec formatter, so VIM can read rspec's output:
cp spec/support/formatters/VIM_formatter.rb YOURREPO/spec/support/formatters/vim_formatter.rb

# Run rspec with the formatter, and put the output where VIM can get it.
# (rspec lets you specify more than one formatter, so we still get nice
# documentation/progress output too! )
rspec --require=support/formatters/VIM_formatter.rb --format VimFormatter --out quickfix.out  --format progress

# `quickfix.out` now has the VIM-friendly spec output.
```

In VIM:
```
# ( these are all VIM built-in commands )
:cg quickfix.out        # load the quickfix file (you'll need to do this everytime the specs run)
:cwindow                # open the quickfix

# In the quickfix buffer
:cn                     # Jump to the first failure
:<a-line-number> <cr>   # Jump to a specific failure

# From any buffer
:ccl                    # Close the quickfix

# BONUS POINTS:
:map <leader>s :cg quickfix.out \| cwindow    #use leader-s to reload the file and open the quickfix
```

## Working with Guard
Yea, this works with Guard too, cause @mikepgee loves guard.

In your Guardfile:
```
# Requires guard >= 4.0.0

rspec_quick =  ' rspec '
rspec_quick << ' --require=support/formatters/VIM_formatter.rb '
rspec_quick << ' --format VimFormatter '
rspec_quick << ' --out quickfix.out '
rspec_quick << ' --format progress '

guard :rspec, cmd: rspec_quick do
  # normal guard config stuffs
end
```

## Konami Code:
I generally dislike extensive extra-app tooling like guard.  I also dislike leaving VIM to run rspec.  So, lets map the mother of all leader commands:
```
# Run the specs, and open the updated quickfix on `<leader>s`
map <leader>s :call system('rspec --require=support/formatters/VIM_formatter.rb --format VimFormatter --out quickfix.out  --format progress') \| cg quickfix.out \| cwindow
```
