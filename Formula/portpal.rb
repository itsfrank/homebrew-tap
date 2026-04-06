class Portpal < Formula
  desc "CLI and background service for managing forwarded SSH ports"
  homepage "https://github.com/itsfrank/portpal"
  url "https://github.com/itsfrank/portpal/releases/download/v0.2.3/portpal-cli.tar.gz"
  sha256 "4975865cd71b01c20d9e6f2c84c8c780278116c00e0f926fbed21139f74e2e9a"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    bin.install "portpal"
  end

  service do
    run [opt_bin/"portpal", "serve"]
    keep_alive true
    log_path var/"log/portpal.log"
    error_log_path var/"log/portpal.log"
  end

  test do
    expected_path = testpath/"Library/Application Support/Portpal/config.toml"
    assert_equal expected_path.to_s, shell_output("#{bin}/portpal config path").strip
  end
end
