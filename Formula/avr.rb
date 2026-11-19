class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  version "0.9.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.9.0/avr_0.9.0_darwin_arm64.tar.gz"
      sha256 "57abcd9b2206e732fb5807d00446740dbe0224a615373da42a32b028343342ac"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/avrea-com/cli/releases/download/v0.9.0/avr_0.9.0_linux_amd64.tar.gz"
      sha256 "4a4582d0cf6d6cce2c183f02fac25d532556ce26cca3fa25d1707e3ff52cf2e6"
    end
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.9.0/avr_0.9.0_linux_arm64.tar.gz"
      sha256 "eac3d0f4485b9eb3eee82650f6b060ad6c8e2ae9ecc2add948d7ac19e49daa7e"
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
