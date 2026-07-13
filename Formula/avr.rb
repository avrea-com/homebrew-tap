class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  version "0.1.6"
  license "Apache-2.0"

  # Prebuilt PyApp binary (a Rust launcher wrapping the avr-cli PyPI wheel);
  # the tarball contains `avr` plus a `completions/` dir.
  on_macos do
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.1.6/avr_0.1.6_darwin_arm64.tar.gz"
      sha256 "f56900d83bc6cc576862e1eae88aad6b8ded4b19fa30d95bb18af635706aa6e2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/avrea-com/cli/releases/download/v0.1.6/avr_0.1.6_linux_amd64.tar.gz"
      sha256 "57cd692815f350633662b61b18738a5f3c43bc48bc58c23d3fc6381799c20ac3"
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
