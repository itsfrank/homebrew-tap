# itsfrank/homebrew-tap

Personal Homebrew tap for projects published by itsfrank.

Portpal is the first package distributed from this tap.

## Install

```bash
brew tap itsfrank/tap
brew install itsfrank/tap/portpal
brew install --cask itsfrank/tap/portpal-app
```

## Packages

- `portpal` - CLI formula
- `portpal-app` - macOS app cask

Portpal source lives in the separate repository at `https://github.com/itsfrank/portpal`.

Install both if you want the CLI and the app side-by-side without Homebrew link conflicts.

## Release Notes

The tap is currently set up for `v0.1.2` of Portpal.

When publishing a new release:

- Update the version and CLI archive SHA in `Formula/portpal.rb`.
- Update the version and app zip SHA in `Casks/portpal-app.rb`.

## Automation

This repo includes a manual GitHub Actions workflow at `.github/workflows/update-homebrew-shas.yml`.

Run `Update Homebrew SHAs` from the Actions tab and provide:

- `project`: one of the supported tap projects
- `version`: the release version, with or without a leading `v`

The workflow will:

- fetch the GitHub release for the selected project
- download the formula asset and cask asset
- compute fresh SHA256 values
- update the matching formula and cask files
- open a pull request with the updated metadata

To add another project later, update:

- the `PROJECTS` hash in `scripts/update-homebrew-release.rb`
- the `project` dropdown options in `.github/workflows/update-homebrew-shas.yml`
