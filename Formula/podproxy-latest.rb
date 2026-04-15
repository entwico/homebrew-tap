# typed: false
# frozen_string_literal: true

class PodproxyLatest < Formula
  desc "Kubernetes pod proxy that routes traffic through pod port-forwarding"
  homepage "https://github.com/entwico/podproxy"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_darwin_arm64.tar.gz"
      sha256 "1fefd89c0182018e2450c5753c139fb7f259f5739bbdbfc72c2448b9e85f3703"
    else
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_darwin_amd64.tar.gz"
      sha256 "13f62694f19771d74e38ac331a895b6ab19db3ec87e9501ae5355cc9b25a41ef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_linux_arm64.tar.gz"
      sha256 "839933874fb07b1069cb4d8b7280719f3aa89eb6ef8c824ef529c10d71e41915"
    else
      url "https://github.com/entwico/podproxy/releases/download/latest/podproxy_linux_amd64.tar.gz"
      sha256 "aaf74024aa734a36ee1add3f0578de6391de4ae1cd165289fc63a2577aacf5e0"
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
