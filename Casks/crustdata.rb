cask "crustdata" do
  version "0.5.9"
  sha256 "ab7606dd6a38767b64aa34d5d63acfab221d4fb8b07e6bdc15e13de0db853154"

  url "https://github.com/crustdata/homebrew-tap/releases/download/v#{version}/Crustdata_#{version}_aarch64.dmg",
      verified: "github.com/crustdata/homebrew-tap/"
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
