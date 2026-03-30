# Homebrew Tap Setup Context

This repository is intended to become a personal Homebrew tap for projects distributed by itsfrank.

## Goal

Set up this repo as a working Homebrew tap, with Portpal as the first package.

The source repo for Portpal lives separately at:

- `/Users/frk/dev/portpal`

This tap repo should eventually contain at least:

1. `Formula/portpal.rb`
2. `Casks/portpal.rb`
3. any minimal README or documentation you think is appropriate for a tap repo

## Current Portpal Packaging State

The Portpal source repo already contains draft Homebrew files and release packaging support:

1. Draft formula:
   - `/Users/frk/dev/portpal/packaging/homebrew/Formula/portpal.rb`
2. Draft cask:
   - `/Users/frk/dev/portpal/packaging/homebrew/Casks/portpal.rb`
3. Release packaging script:
   - `/Users/frk/dev/portpal/scripts/package-release.sh`
4. App bundle metadata:
   - `/Users/frk/dev/portpal/packaging/macos/Info.plist`
5. Release workflow:
   - `/Users/frk/dev/portpal/.github/workflows/release.yml`

The Portpal repo can already produce:

1. `Portpal.app.zip`
2. `portpal-cli.tar.gz`
3. `Portpal.app`

via:

```bash
cd /Users/frk/dev/portpal
VERSION=0.1.0 ./scripts/package-release.sh
```

## Important Portpal Behavior

The `portpal` CLI needs to be able to launch `PortpalService` after install.

That is already handled in the Portpal source repo by `PORTPAL_SERVICE_PATH` support in:

- `/Users/frk/dev/portpal/Sources/PortpalCore/Environment.swift`

The formula is designed to install:

1. `portpal` in `bin`
2. `PortpalService` in `libexec/Portpal/PortpalService`
3. a wrapper script for `portpal` that exports `PORTPAL_SERVICE_PATH`

Do not redesign that unless there is a concrete issue.

## Desired Outcome In This Repo

Set this repo up so it is a valid personal Homebrew tap with:

1. `Formula/portpal.rb`
2. `Casks/portpal.rb`

The files should be based on the drafts in the Portpal repo, but updated to be appropriate for the actual GitHub owner/repo names for the user.

If the exact GitHub owner is not yet known from local context, preserve clear placeholders and document exactly what must be filled in.

## Expected Homebrew Install UX

Eventually users should be able to run:

```bash
brew tap <owner>/tap
brew install <owner>/tap/portpal
brew install --cask <owner>/tap/portpal
```

Homebrew convention assumes this repo will likely be named:

- `homebrew-tap`

## What The Next Agent Should Do

1. Set up the standard tap layout in this repo:
   - `Formula/`
   - `Casks/`
2. Copy/adapt the Portpal draft formula and cask into this repo
3. Add a minimal `README.md` for the tap repo describing:
   - what it is
   - how to install `portpal`
   - that the source lives in the separate Portpal repo
4. Keep the formula and cask release-oriented, not local-path-oriented
5. If useful, include a short checklist of which placeholders need replacement before first public release

## Draft Formula Source

Current draft from the Portpal repo:

```ruby
class Portpal < Formula
  desc "Manage forwarded SSH ports from the CLI and a macOS menu bar app"
  homepage "https://github.com/REPLACE_WITH_OWNER/portpal"
  url "https://github.com/REPLACE_WITH_OWNER/portpal/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "REPLACE_WITH_SOURCE_ARCHIVE_SHA256"
  license "MIT"
  head "https://github.com/REPLACE_WITH_OWNER/portpal.git", branch: "main"

  depends_on :macos
  depends_on xcode: ["15.0", :build]

  def install
    system "swift", "build", "-c", "release", "--product", "portpal", "--product", "PortpalService"

    libexec.install ".build/release/PortpalService" => "Portpal/PortpalService"
    libexec.install ".build/release/portpal" => "portpal-bin"

    (bin/"portpal").write_env_script libexec/"portpal-bin",
      PORTPAL_SERVICE_PATH: libexec/"Portpal/PortpalService"
  end

  test do
    output = shell_output("#{bin}/portpal check --host brew-test --local-port 6553", 1)
    assert_match '"managed" : false', output
  end
end
```

## Draft Cask Source

Current draft from the Portpal repo:

```ruby
cask "portpal" do
  version "0.1.0"
  sha256 "REPLACE_WITH_PORTPAL_APP_ZIP_SHA256"

  url "https://github.com/REPLACE_WITH_OWNER/portpal/releases/download/v#{version}/Portpal.app.zip"
  name "Portpal"
  desc "Menu bar utility for managing forwarded SSH ports"
  homepage "https://github.com/REPLACE_WITH_OWNER/portpal"

  app "Portpal.app"
end
```

## Release Notes For The Next Agent

The Portpal release workflow is manual `workflow_dispatch` for now and only accepts refs that are tags matching:

```text
v<major>.<minor>.<patch>
```

Example:

```text
v0.1.0
```

The release workflow uploads:

1. `Portpal.app.zip`
2. `portpal-cli.tar.gz`

and computes SHA256 values for:

1. `Portpal.app.zip`
2. `portpal-cli.tar.gz`
3. the GitHub source tarball for the tag

The formula should use the GitHub source tarball SHA, not a local archive SHA.

The cask should use the `Portpal.app.zip` SHA.

## Constraints

1. Do not change the Portpal source repo unless absolutely necessary for the tap setup task
2. Keep this repo generic enough to host future formulas/casks unrelated to Portpal
3. Prefer minimal, conventional Homebrew tap structure
4. Avoid over-automation unless it clearly improves first-time setup

## Deliverable

When done, this repo should be ready for the user to:

1. initialize/push it as the Homebrew tap repo
2. fill in any remaining GitHub owner/release SHA placeholders
3. install Portpal from the tap once the first tagged release exists
