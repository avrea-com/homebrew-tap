class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  version "0.4.0"
  license "Apache-2.0"

  # Prebuilt PyApp binary (a Rust launcher wrapping the avr-cli PyPI wheel);
  # the tarball contains `avr` plus a `completions/` dir.
  on_macos do
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.4.0/avr_0.4.0_darwin_arm64.tar.gz"
      sha256 "e51c50be71187a4090fa8a25e9132adf0b0d0b24fe7d88159cbe8412a2144903"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/avrea-com/cli/releases/download/v0.4.0/avr_0.4.0_linux_amd64.tar.gz"
      sha256 "3f938e45d755a2c5d4b5cae4e9dafb1bdd07bc11f4b28017c6a5ef4dcdb1defd"
    end
  end

  def install
    bin.install "avr"

    # Completions are shipped pre-generated in the tarball rather than produced
    # from the executable at install time: the binary installs its Python
    # dependencies from PyPI on first run, and Homebrew's build sandbox blocks
    # network access during `install`, so running it here would fail.
    bash_completion.install "completions/avr.bash" => "avr"
    zsh_completion.install "completions/avr.zsh" => "_avr"
    fish_completion.install "completions/avr.fish" => "avr.fish"
  end

  def caveats
    <<~EOS
      The first `avr` invocation initializes a private environment (a one-time
      download of a few seconds); subsequent runs start instantly.
    EOS
  end

  test do
    # `avr` bootstraps its Python env from PyPI on first run; the `brew test`
    # sandbox denies network and home access, so validate the install without
    # executing the launcher.
    assert_path_exists bin/"avr"
    assert_predicate bin/"avr", :executable?
  end
end
