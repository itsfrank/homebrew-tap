cask "portpal-app" do
  version "0.2.2"
  sha256 "987fba3b8a64038e59e28415fa7e5ae9b552552a786713af1c4dbc54319ed0c4"

  url "https://github.com/itsfrank/portpal/releases/download/v#{version}/Portpal.app.zip"
  name "Portpal"
  desc "Menu bar utility for managing forwarded SSH ports"
  homepage "https://github.com/itsfrank/portpal"

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Portpal.app"
end
