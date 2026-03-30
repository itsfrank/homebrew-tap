class Portpal < Formula
  desc "Manage forwarded SSH ports from the CLI and a macOS menu bar app"
  homepage "https://github.com/itsfrank/portpal"
  url "https://github.com/itsfrank/portpal/releases/download/v0.1.3/portpal-cli.tar.gz"
  sha256 "a403b6e4e9835e114328b4f27fa2b49da948db0ebe4a05402ed0fd48cd0c8e9b"
  license "MIT"

  depends_on :macos

  def install
    (libexec/"Portpal").mkpath
    (libexec/"Portpal").install "PortpalService"
    libexec.install "portpal" => "portpal-bin"

    (bin/"portpal").write_env_script libexec/"portpal-bin",
      PORTPAL_SERVICE_PATH: libexec/"Portpal/PortpalService"
  end

  test do
    output = shell_output("#{bin}/portpal check --host brew-test --local-port 6553", 1)
    assert_match '"managed" : false', output
  end
end
