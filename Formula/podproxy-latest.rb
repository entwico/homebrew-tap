# typed: false
# frozen_string_literal: true

class PodproxyLatest < Formula
  desc "Kubernetes pod proxy that routes traffic through pod port-forwarding"
  homepage "https://github.com/entwico/podproxy"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_darwin_arm64.tar.gz"
      sha256 "ffc81807271f414ecff6ee8acedc7730d69eb419b8d76c3498a3e323aa356d36"
    else
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_darwin_amd64.tar.gz"
      sha256 "e9cccacc4bacd1da1b832f20172c4b80c6cd4dba84ea71e102f09a5bb07a5c70"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_linux_arm64.tar.gz"
      sha256 "f86f2520bdb028a1deed428ec9c807f0830df98f7649fd0757858877f7a292f6"
    else
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_linux_amd64.tar.gz"
      sha256 "e9d7b75e3bb0704745a4c1410f26f51594ceff178cd33bfc20228bb49fd53b5c"
    end
  end

  def install
    bin.install "podproxy"
  end

  test do
    system "#{bin}/podproxy", "--version"
  end
end
