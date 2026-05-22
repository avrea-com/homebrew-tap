class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  version "0.1.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.1.1/avr_0.1.1_darwin_arm64.tar.gz"
      sha256 "32543b2473a205f003df1779dc24e6d561b0d376571efe9366ece02682c0a15d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/avrea-com/cli/releases/download/v0.1.1/avr_0.1.1_linux_amd64.tar.gz"
      sha256 "f32ceaa29fa5c1ee3e7c28d4424f4ed89e9b4b352accf0665daed5837a8070ae"
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
