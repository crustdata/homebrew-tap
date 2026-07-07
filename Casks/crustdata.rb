cask "crustdata" do
  version "0.4.6"
  sha256 "e6195d3b6bb00957a29bd4c8b39ce3755d774be97f57700254739c773ef7f63d"

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
