cask "crustdata" do
  version "0.3.1"
  sha256 "a47a82aa272e8d10aec6da8811262b60789c2f725ec78abb7e87843ee44689b1"

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
