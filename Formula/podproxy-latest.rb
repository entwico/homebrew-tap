# typed: false
# frozen_string_literal: true

class PodproxyLatest < Formula
  desc "Kubernetes pod proxy that routes traffic through pod port-forwarding"
  homepage "https://github.com/entwico/podproxy"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_darwin_arm64.tar.gz"
      sha256 "1dd91a83a550a258562b6a548df9f5b4d0b1ec625b37342d6b6f1d08da4437f3"
    else
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_darwin_amd64.tar.gz"
      sha256 "8d3eeaba0c15c4554aa348e255464275d39186a7dd25bc599c5812580b2db045"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_linux_arm64.tar.gz"
      sha256 "86903fc02ac5f2b4adb71b56dc147a1fa45b6834f998661e0c9c23fd32851ac9"
    else
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_linux_amd64.tar.gz"
      sha256 "590556f412a5922d89c8026d914a66f1bc8a09cadc8a5a563a3dde0b49ff13af"
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
