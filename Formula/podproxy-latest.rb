# typed: false
# frozen_string_literal: true

class PodproxyLatest < Formula
  desc "Kubernetes pod proxy that routes traffic through pod port-forwarding"
  homepage "https://github.com/entwico/podproxy"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_darwin_arm64.tar.gz"
      sha256 "940185f865d2f47ae035c83d7adf38e1937f46869b3324b9f547d64971493aee"
    else
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_darwin_amd64.tar.gz"
      sha256 "77844eac2d737944c5edfee3423b00ea1ee363761b36d43757b28f699140f7ba"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_linux_arm64.tar.gz"
      sha256 "85280d959b971401ef43368201708f5c17dd1a845e593b7b51d012094db4fe88"
    else
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_linux_amd64.tar.gz"
      sha256 "bb0f0752fddf144ae3fe0f6faeb87196632bd45ddb22deed1d93286699ece67c"
    end
  end

  def install
    bin.install "podproxy"
  end

  test do
    system "#{bin}/podproxy", "--version"
  end
end
