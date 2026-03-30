cask "portpal-app" do
  version "0.1.3"
  sha256 "13fffce16333d9d15221d1d39d72714d7df89b5f06d6b021b0459c82e11a61ae"

  url "https://github.com/itsfrank/portpal/releases/download/v#{version}/Portpal.app.zip"
  name "Portpal"
  desc "Menu bar utility for managing forwarded SSH ports"
  homepage "https://github.com/itsfrank/portpal"

  app "Portpal.app"
end
