class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  version "0.1.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.1.4/avr_0.1.4_darwin_arm64.tar.gz"
      sha256 "1af3e04e983aa5ad278235b191530757544c774df1133d2548df7a4284583533"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/avrea-com/cli/releases/download/v0.1.4/avr_0.1.4_linux_amd64.tar.gz"
      sha256 "421e41c8ec68310e18d3c14504f3fa26d00cbcb0db6cb37a6e5c5d604cf0c129"
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
