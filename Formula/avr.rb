class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  version "0.7.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.7.0/avr_0.7.0_darwin_arm64.tar.gz"
      sha256 "410809c41c7ac787090a7b069fe7096396a91fe78d89994925f055ca9732e0df"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/avrea-com/cli/releases/download/v0.7.0/avr_0.7.0_linux_amd64.tar.gz"
      sha256 "ba81772dfed9d423a59f5ea798eb8285a6ef94dfa6527f61fa75e433e4a56601"
    end
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.7.0/avr_0.7.0_linux_arm64.tar.gz"
      sha256 "05128a8cd53702cb394c18b8052b75001c5d8fb6f4c57d0c9d89599de112aee3"
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
