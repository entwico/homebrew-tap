# typed: false
# frozen_string_literal: true

class PodproxyLatest < Formula
  desc "Kubernetes pod proxy that routes traffic through pod port-forwarding"
  homepage "https://github.com/entwico/podproxy"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_darwin_arm64.tar.gz"
      sha256 "d2735d01ab1c8f469c363251653070d6e98fdb7c2fd7e18cb9888810ef9e0a06"
    else
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_darwin_amd64.tar.gz"
      sha256 "67d05c3e0f356f16fa5ae408268f0c1d05d25712c1452089e1fd85090491d7a8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_linux_arm64.tar.gz"
      sha256 "11ba73acfe163881baad5725e3fadd7d9cfbe419f1e4f1983310fd6cbf842e4d"
    else
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_linux_amd64.tar.gz"
      sha256 "e3ad8be9a9f92661dff85f61b210e128b55cc99c92c03bf4e585003e5d07b5ee"
    end
  end

  def install
    bin.install "podproxy"
    (etc/"podproxy").install "defaults.yaml" => "config.yaml" unless (etc/"podproxy/config.yaml").exist?
  end

  service do
    run [opt_bin/"podproxy", "--config", etc/"podproxy/config.yaml"]
    keep_alive true
    log_path var/"log/podproxy.log"
    error_log_path var/"log/podproxy.log"
    working_dir var
  end

  def caveats
    <<~EOS
      Configuration file:
        #{etc}/podproxy/config.yaml

      A default config is installed if one does not already exist.
      Edit it before starting the service:
         #{etc}/podproxy/config.yaml

      To start podproxy as a background service:
        brew services start #{name}

      To stop the service:
        brew services stop #{name}

      Logs are written to:
        #{var}/log/podproxy.log
    EOS
  end

  test do
    system "#{bin}/podproxy", "--version"
  end
end
