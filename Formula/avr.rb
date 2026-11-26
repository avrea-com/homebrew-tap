class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  # `brew tap` loads the formula for every OS and architecture, so each needs
  # a URL. Intel Macs get this one but are refused by `depends_on arch`.
  url "https://github.com/avrea-com/cli/releases/download/v0.12.0/avr_0.12.0_darwin_arm64.tar.gz"
  version "0.12.0"
  sha256 "d65b2ea858d4be23015a423c8a50e92161af3f730d2f873b25bde67384e035d9"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :ventura
  end

  on_linux do
    on_intel do
      url "https://github.com/avrea-com/cli/releases/download/v0.12.0/avr_0.12.0_linux_amd64.tar.gz"
      sha256 "97b0dbaa7dedcd019d4d709e5172bd4b7c9775453da5e67e356aa633713b1830"
    end
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.12.0/avr_0.12.0_linux_arm64.tar.gz"
      sha256 "88c8f7f12090f5791cf6522ec439441d9416a850969ffa5e6b3f69b926601430"
    end
  end

  def install
    bin.install "avr"
    bash_completion.install "completions/avr.bash" => "avr"
    zsh_completion.install "completions/_avr"
    fish_completion.install "completions/avr.fish"
    man1.install Dir["man/man1/*.1"]
    doc.install "README.md", "THIRD-PARTY-NOTICES.txt"
  end

  test do
    assert_match "avr version #{version}", shell_output("#{bin}/avr --version")
    assert_match "USAGE", shell_output("#{bin}/avr repo --help")
  end
end
