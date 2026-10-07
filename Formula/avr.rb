class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  version "0.4.1"
  license "Apache-2.0"

  # Prebuilt PyApp binary (a Rust launcher wrapping the avr-cli PyPI wheel);
  # the tarball contains `avr` plus a `completions/` dir.
  on_macos do
    on_arm do
      url "https://github.com/avrea-com/cli/releases/download/v0.4.1/avr_0.4.1_darwin_arm64.tar.gz"
      sha256 "1a3adad6ddcc220c64491c2bee1a4a6a3e3e70fb4945df918e0f23dbe85bf7b9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/avrea-com/cli/releases/download/v0.4.1/avr_0.4.1_linux_amd64.tar.gz"
      sha256 "2c57a2cb42879870a9d34bfe85609175faccf2c4fa69a3febf02f457212e5fe6"
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
