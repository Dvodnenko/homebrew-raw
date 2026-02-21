class Raw < Formula
  desc "unstable lifeos"
  homepage "https://github.com/Dvodnenko/raw"
  url "https://github.com/Dvodnenko/raw/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "ad52c4621d5179c089ad30beaf86f977412abeb53c48da8115f3ee17635d21d8"
  license "MIT"

  depends_on "python@3.12" => :build
  depends_on "poetry" => :build

  def install
    system "poetry", "config", "virtualenvs.in-project", "true"
    system "poetry", "install", "--only=main", "--no-root"
    system "poetry", "run", "pip", "install", "nuitka"
    
    system "poetry", "run", "python", "-m", "nuitka",
           "--standalone",
           "--include-package=src",
           "--follow-imports",
           "--output-filename=raw",
           "run.py"
    
    # Debug: see what was created
    ohai "Checking build output..."
    system "ls", "-lR"
    
    # Find the .dist directory
    dist_dir = Dir.glob("*.dist").first
    odie "No .dist directory found!" unless dist_dir
    
    ohai "Installing from #{dist_dir}"
    libexec.install Dir["#{dist_dir}/*"]
    bin.install_symlink libexec/"raw"
  end

  test do
    system bin/"raw", "--help"
  end
end