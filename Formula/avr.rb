class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  # `brew tap` loads the formula for every OS and architecture, so each needs
  # a URL. Intel Macs get this one but are refused by `depends_on arch`.
  url "https://github.com/avrea-com/cli/releases/download/v0.11.0/avr_0.11.0_darwin_arm64.tar.gz"
  version "0.11.0"
  sha256 "396f4d835721f7104b73b5d676ef7959e89d2ddef1821da9b07cd644493339e1"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :ventura
  end

  on_linux do
    on_intel do
      url "https://github.com/avrea-com/cli/releases/download/v0.11.0/avr_0.11.0_linux_amd64.tar.gz"
      sha256 "24c332d1207e1c3ff2ad707e75facc4a201e49c72b9a99ba4066bd4034903256"
    end
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.11.0/avr_0.11.0_linux_arm64.tar.gz"
      sha256 "0f88e0d1e0a44e76279e1760d50397853936ef37fde045079a334e02b4735e86"
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
