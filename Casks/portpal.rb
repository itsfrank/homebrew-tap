cask "portpal" do
  version "0.1.2"
  sha256 "c67da1cbce656bef8cb3200bd35ba51c67f76eaea8a33a055d45223dca8217af"

  url "https://github.com/itsfrank/portpal/releases/download/v#{version}/Portpal.app.zip"
  name "Portpal"
  desc "Menu bar utility for managing forwarded SSH ports"
  homepage "https://github.com/itsfrank/portpal"

  app "Portpal.app"
end
