class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  # `brew tap` loads the formula for every OS and architecture, so each needs
  # a URL. Intel Macs get this one but are refused by `depends_on arch`.
  url "https://github.com/avrea-com/cli/releases/download/v0.10.1/avr_0.10.1_darwin_arm64.tar.gz"
  version "0.10.1"
  sha256 "536768e4f517580cc8b6fe52cace8aac02d0dbae24ffd23ebf3c663c7fdad92a"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :ventura
  end

  on_linux do
    on_intel do
      url "https://github.com/avrea-com/cli/releases/download/v0.10.1/avr_0.10.1_linux_amd64.tar.gz"
      sha256 "fbc6522a8db556b5d493cbea98e7ddc0112c175f38abd7415e54c90f7a6c0178"
    end
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.10.1/avr_0.10.1_linux_arm64.tar.gz"
      sha256 "f3f021cdd2675785bd92166fc642b4c951a9fc55d49b41b877a71306af69f10f"
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
