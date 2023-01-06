class Forgit < Formula
  desc "Interactive git commands in the terminal"
  homepage "https://github.com/wfxr/forgit"
  url "https://github.com/wfxr/forgit/releases/download/23.01.0/forgit-23.01.0.tar.gz"
  sha256 "2f7b0b4defbeb0945c5e644283749e62d901f1f1389eaddf9c591ab7091a27ae"
  license "MIT"

  depends_on "fzf"

  def install
    bin.install "bin/git-forgit" => "forgit"
  end

  test do
    system "which", "forgit"
  end
end
