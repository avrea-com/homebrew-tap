class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  version "0.1.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.1.3/avr_0.1.3_darwin_arm64.tar.gz"
      sha256 "f9ee1ed89dba9d9ca26b90d88578a6912c5798a759e05a2288910c25c7bb62bc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/avrea-com/cli/releases/download/v0.1.3/avr_0.1.3_linux_amd64.tar.gz"
      sha256 "493257de9d490c83273ce11b4f109061e36097662c6a7d15953a3e4b26801994"
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
