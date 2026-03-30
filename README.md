# itsfrank/homebrew-tap

Personal Homebrew tap for projects published by itsfrank.

Portpal is the first package distributed from this tap.

## Install

```bash
brew tap itsfrank/tap
brew install itsfrank/tap/portpal
brew install --cask itsfrank/tap/portpal
```

## Packages

- `portpal`

Portpal source lives in the separate repository at `https://github.com/itsfrank/portpal`.

## Release Notes

The tap is currently set up for `v0.1.0` of Portpal.

When publishing a new release:

- Update the version and source tarball SHA in `Formula/portpal.rb`.
- Update the version and app zip SHA in `Casks/portpal.rb`.
