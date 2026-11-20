class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  url "https://github.com/avrea-com/cli/releases/download/v0.10.0/avr_0.10.0_darwin_arm64.tar.gz"
  version "0.10.0"
  sha256 "a541d30b3a3f7f3bb203f6be7ffc5aaa3e8c68696e0b7ea9c27044d29fe69e0c"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :ventura
  end

  on_linux do
    on_intel do
      url "https://github.com/avrea-com/cli/releases/download/v0.10.0/avr_0.10.0_linux_amd64.tar.gz"
      sha256 "a778ae54145b8df11afe6d10f51a799743f1d9f545d3403cb6950a274828c203"
    end
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.10.0/avr_0.10.0_linux_arm64.tar.gz"
      sha256 "637c7a0dab50f067da3f18be06b1601a1bfea923153f9a6591dd39262bdf2d20"
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
