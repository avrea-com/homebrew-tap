class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  version "0.3.0"
  license "Apache-2.0"

  # Prebuilt PyApp binary (a Rust launcher wrapping the avr-cli PyPI wheel);
  # the tarball contains `avr` plus a `completions/` dir.
  on_macos do
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.3.0/avr_0.3.0_darwin_arm64.tar.gz"
      sha256 "cd392f04b7a87829705351fc2a89c7311ed09b512306464f191dc68c624d3e5b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/avrea-com/cli/releases/download/v0.3.0/avr_0.3.0_linux_amd64.tar.gz"
      sha256 "e3a8acde926ecfcc28a85dd593bbdcac603edeea295feeb387f56034669602e2"
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
