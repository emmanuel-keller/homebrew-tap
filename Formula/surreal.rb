class Surreal < Formula
  desc "A scalable, distributed, collaborative, document-graph database"
  homepage "https://surreal.io"

  version "0.1.0"
  url "https://download.surrealdb.com/surreal-v0.1.0.darwin-amd64.tgz"
  sha256 "823e65985061d59c92a69bc651fae502955da444d5527b77e169630f0650e588"

  bottle :unneeded

  def caveats; <<~EOS
    For local development only, this formula ships a launchd configuration to
    start a single-node cluster that stores its data that stores its data under:
      #{var}/
    The database is available on the default port of 8000:
      #{Formatter.url("http://localhost:8000")}
  EOS
  end

  plist_options :manual => "surreal start --log-level debug --path memory"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/surreal</string>
        <string>start</string>
        <string>--log-level=debug</string>
        <string>--path=file:#{var}/surreal.db</string>
      </array>
      <key>WorkingDirectory</key>
      <string>#{var}</string>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <true/>
    </dict>
    </plist>
  EOS
  end

  test do
    system "#{bin}/surreal version"
  end

end
