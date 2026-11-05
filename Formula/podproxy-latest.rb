# typed: false
# frozen_string_literal: true

class PodproxyLatest < Formula
  desc "Kubernetes pod proxy that routes traffic through pod port-forwarding"
  homepage "https://github.com/entwico/podproxy"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_darwin_arm64.tar.gz"
      sha256 "3c3b6f21f99edd02187aca53dc5186160882f68d53c867cef69eb21796a932db"
    else
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_darwin_amd64.tar.gz"
      sha256 "3d06c85b9d2ad19e2dfc09ab51e88af2b6f97214f6d9a87b42ff12203c9ad865"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_linux_arm64.tar.gz"
      sha256 "483a18f601e87943cee1c4fa23d8995127ba8e5453308e9fbc75f3c89d95e9d6"
    else
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_linux_amd64.tar.gz"
      sha256 "4240aef2d8f42cbe47df733a6459c7c51a0aea93fd6da1c2d42ee103bbc5ea3a"
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
