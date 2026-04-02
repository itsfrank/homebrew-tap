class Portpal < Formula
  desc "CLI and background service for managing forwarded SSH ports"
  homepage "https://github.com/itsfrank/portpal"
  url "https://github.com/itsfrank/portpal/releases/download/v0.2.0/portpal-cli.tar.gz"
  sha256 "abf8b8604c2533aec38e32f9cc7d9154289dda6595ec2e4e575050a970f6a32e"
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
