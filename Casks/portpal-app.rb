cask "portpal-app" do
  version "0.2.1"
  sha256 "be47658d82bdc9096102b585c9688aebc8e06d91f6be250fdf615db8a78fee98"

  url "https://github.com/itsfrank/portpal/releases/download/v#{version}/Portpal.app.zip"
  name "Portpal"
  desc "Menu bar utility for managing forwarded SSH ports"
  homepage "https://github.com/itsfrank/portpal"

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Portpal.app"
end
