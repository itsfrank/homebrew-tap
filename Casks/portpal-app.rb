cask "portpal-app" do
  version "0.2.0"
  sha256 "2c17ac41389e8f9c3db63ef95bdef128877bbcabc8272397891a0853d83242fb"

  url "https://github.com/itsfrank/portpal/releases/download/v#{version}/Portpal.app.zip"
  name "Portpal"
  desc "Menu bar utility for managing forwarded SSH ports"
  homepage "https://github.com/itsfrank/portpal"

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Portpal.app"
end
