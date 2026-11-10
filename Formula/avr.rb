class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  version "0.8.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.8.0/avr_0.8.0_darwin_arm64.tar.gz"
      sha256 "fe29576b8439d369f109f62bdde771975cad877ab432df30dcf65ff6381de4c8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/avrea-com/cli/releases/download/v0.8.0/avr_0.8.0_linux_amd64.tar.gz"
      sha256 "d3f6f26e836c7bb941cd8082ee5a88256bd4815fc2c56d5947176ad8ea8c16b5"
    end
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.8.0/avr_0.8.0_linux_arm64.tar.gz"
      sha256 "1cb8f84f0b09b558f551817e85ac4aeed04c622c279540aef2b24a2cb2bd3816"
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
