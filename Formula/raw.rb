class Raw < Formula
  desc "A CLI Tool for Tracking Study and Work Time 🦇"
  homepage "https://github.com/dvodnenko/raw"
  url "https://github.com/dvodnenko/raw/releases/download/v1.3.4/raw.tar.gz"
  sha256 "9ec8fa0bc06bd8457434988030071a28004f9fde4989704577c2d9d2ed10811e"
  license "MIT"

  def install
    bin.install "raw"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/raw --help")
  end
end
