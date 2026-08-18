# typed: false
# frozen_string_literal: true

class PodproxyLatest < Formula
  desc "Kubernetes pod proxy that routes traffic through pod port-forwarding"
  homepage "https://github.com/entwico/podproxy"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_darwin_arm64.tar.gz"
      sha256 "1129114e0007d5855e2818d8631c64428968bcc34717d564b470d255766d36ac"
    else
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_darwin_amd64.tar.gz"
      sha256 "5ea226fdc8b997c8fffeb31001c95d4bcfe548c6bbd06ea34fce66b4d049f04b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_linux_arm64.tar.gz"
      sha256 "508e7b2def7c8ff6ac6d8982e11b061d68881c9bcbf615da036ad8bd0073854d"
    else
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_linux_amd64.tar.gz"
      sha256 "83421a87ab587af212e67ddcd22b66a16d702ad21bf48c33c432b4c07ac30ce3"
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
