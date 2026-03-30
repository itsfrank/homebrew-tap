class Portpal < Formula
  desc "Manage forwarded SSH ports from the CLI and a macOS menu bar app"
  homepage "https://github.com/itsfrank/portpal"
  url "https://github.com/itsfrank/portpal/releases/download/v0.1.0/portpal-cli.tar.gz"
  sha256 "7e2a1d57c973994e73e21cf4310a1493db3c30d102a872d6e7324fc36217faf2"
  license "MIT"

  depends_on :macos

  def install
    libexec.install "PortpalService" => "Portpal/PortpalService"
    libexec.install "portpal" => "portpal-bin"

    (bin/"portpal").write_env_script libexec/"portpal-bin",
      PORTPAL_SERVICE_PATH: libexec/"Portpal/PortpalService"
  end

  test do
    output = shell_output("#{bin}/portpal check --host brew-test --local-port 6553", 1)
    assert_match '"managed" : false', output
  end
end
