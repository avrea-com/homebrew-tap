class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  version "0.1.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.1.5/avr_0.1.5_darwin_arm64.tar.gz"
      sha256 "e277b06a52a4810c89c5808eb6b399bc59a69cdc4042a67773e8d869486c2d00"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/avrea-com/cli/releases/download/v0.1.5/avr_0.1.5_linux_amd64.tar.gz"
      sha256 "1ad97e4e54bffb64035c947e1b28f32d9b608aa4a5599b5e06141351a89714e9"
    end
  end

  def install
    bin.install "avr"
    generate_completions_from_executable(bin/"avr",
                                         shells:                 [:bash, :zsh, :fish],
                                         shell_parameter_format: :click)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/avr --version")
  end
end
