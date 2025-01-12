require "language/node"

class CloudflareWrangler2 < Formula
  desc "CLI tool for Cloudflare Workers"
  homepage "https://github.com/cloudflare/wrangler2"
  url "https://registry.npmjs.org/wrangler/-/wrangler-2.6.2.tgz"
  sha256 "f2a5a803db8c5e8eaa2d75affc12330deb8cef33ec01c29bbc0ebdb3bb3b4985"
  license any_of: ["Apache-2.0", "MIT"]

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7f4e8b596235fd4b849493eaa4c3308d7926d19dff533401b2f56eac5543b8b4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7f4e8b596235fd4b849493eaa4c3308d7926d19dff533401b2f56eac5543b8b4"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7f4e8b596235fd4b849493eaa4c3308d7926d19dff533401b2f56eac5543b8b4"
    sha256 cellar: :any_skip_relocation, ventura:        "803991259e8c4fdd9c2d172deb05d9e2a940d1b292e40aa204c25c8111eb0ba1"
    sha256 cellar: :any_skip_relocation, monterey:       "803991259e8c4fdd9c2d172deb05d9e2a940d1b292e40aa204c25c8111eb0ba1"
    sha256 cellar: :any_skip_relocation, big_sur:        "803991259e8c4fdd9c2d172deb05d9e2a940d1b292e40aa204c25c8111eb0ba1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5f035147c59fd082102af366a36380e895ca3390d1947399c9be2c939efcaad6"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/wrangler2"]

    # Replace universal binaries with their native slices
    deuniversalize_machos libexec/"lib/node_modules/wrangler/node_modules/fsevents/fsevents.node"
  end

  test do
    system "#{bin}/wrangler2", "init", "--yes"
    assert_predicate testpath/"wrangler.toml", :exist?
    assert_match "wrangler", (testpath/"package.json").read

    assert_match "dry-run: exiting now.", shell_output("#{bin}/wrangler2 publish --dry-run")
  end
end
