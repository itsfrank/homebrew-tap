cask "portpal" do
  version "0.1.0"
  sha256 "4f3f55597c54295d16475efa78b41a5794d57da87ec834fa0be149d7d4c1bf06"

  url "https://github.com/itsfrank/portpal/releases/download/v#{version}/Portpal.app.zip"
  name "Portpal"
  desc "Menu bar utility for managing forwarded SSH ports"
  homepage "https://github.com/itsfrank/portpal"

  app "Portpal.app"
end
