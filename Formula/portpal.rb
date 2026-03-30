class Portpal < Formula
  desc "Manage forwarded SSH ports from the CLI and a macOS menu bar app"
  homepage "https://github.com/itsfrank/portpal"
  url "https://github.com/itsfrank/portpal/releases/download/v0.1.2/portpal-cli.tar.gz"
  sha256 "2a030e3088bb5dcbda1e49594b2acebceb37b1decde1a7c3a086b9e34674f768"
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
