cask "crustdata" do
  version "0.4.4"
  sha256 "9dd3276f0d81a1ac93b1ae2b8a524f895001e72f7ba6f59c117727a325194497"

  url "https://github.com/bhav-cd/homebrew-tap/releases/download/v#{version}/Crustdata_#{version}_aarch64.dmg",
      verified: "github.com/bhav-cd/homebrew-tap/"
  name "Crustdata"
  desc "Crustdata desktop app"
  homepage "https://crustdata.com"

  depends_on arch: :arm64

  app "Crustdata.app"

  # Unsigned / un-notarized build: strip the quarantine flag so Gatekeeper
  # doesn't block first launch. Belt-and-suspenders alongside --no-quarantine.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Crustdata.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.crustdata.mac-app",
    "~/Library/Preferences/com.crustdata.mac-app.plist",
    "~/Library/Saved Application State/com.crustdata.mac-app.savedState",
  ]
end
