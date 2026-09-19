class Lute < Formula
  desc "Standalone Luau runtime for general-purpose programming"
  homepage "https://github.com/luau-lang/lute"
  url "https://github.com/luau-lang/lute/releases/download/v1.0.0/lute-macos-aarch64.zip"
  sha256 "6d120b5d2804e62ab2453565e755d022bd6902307cabcd0fedb4cdcbd4251e84"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :monterey

  def install
    bin.install "lute"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lute --version")
  end
end
