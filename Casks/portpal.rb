cask "portpal" do
  version "0.1.1"
  sha256 "39df864727d5a913a128a40f63f2fc615df173110187319607554dccb0810793"

  url "https://github.com/itsfrank/portpal/releases/download/v#{version}/Portpal.app.zip"
  name "Portpal"
  desc "Menu bar utility for managing forwarded SSH ports"
  homepage "https://github.com/itsfrank/portpal"

  app "Portpal.app"
end
