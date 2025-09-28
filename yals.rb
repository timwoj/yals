# Formula for Homebrew
class Yals < Formula
  desc "Yet Another Log Server - A web-based log viewer"
  homepage "https://github.com/timwoj/yals"
  url "https://github.com/timwoj/yals/archive/refs/tags/v0.1.1.tar.gz"
  version "0.1.1"
  sha256 "68a60a55667daade5faea7b0121239808e7e63ff14fd59a0397bfdea65df7aea"
  license "MIT"

  depends_on "node"
  depends_on "npm"
  depends_on "typescript" => :build

  def install
    # Install npm dependencies
    system "npm", "install"

    # Build the application
    system "npm", "run", "build"

    # Install the built application to the prefix
    prefix.install Dir["*"]

    # Create a wrapper script in bin
    (bin/"yals").write <<~EOS
      #!/bin/bash
      cd "#{prefix}" && node out/server.js --stdio
    EOS

    # Make the wrapper script executable
    chmod 0755, bin/"yals"
  end

  test do
    # Basic test to ensure the installation completed
    assert_predicate prefix/"package.json", :exist?
    assert_predicate prefix/"node_modules", :exist?
  end
end
