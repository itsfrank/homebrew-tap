cask "portpal-app" do
  version "0.2.3"
  sha256 "19ce75091d6a38dae80e1980f26e83c90a26d06276dad5b53e10c364e280ad81"

  url "https://github.com/itsfrank/portpal/releases/download/v#{version}/Portpal.app.zip"
  name "Portpal"
  desc "Menu bar utility for managing forwarded SSH ports"
  homepage "https://github.com/itsfrank/portpal"

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Portpal.app"
end
