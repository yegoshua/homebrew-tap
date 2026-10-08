cask "notch-orchestrator" do
  version "0.3.0"
  sha256 "bba8d10b02cc31d38c14524c1e002b2a8481e39865b2edd90a7f7e4b255ac25a"

  url "https://github.com/yegoshua/notch-orchestrator/releases/download/v#{version}/NotchOrchestrator.zip"
  name "Notch Orchestrator"
  desc "Claude Code sessions in the MacBook notch"
  homepage "https://github.com/yegoshua/notch-orchestrator"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Notch Orchestrator.app"

  # The app is not notarized, and Homebrew marks what it downloads the way a browser does, so
  # macOS would refuse to open it. The mark is taken off again; see the caveats.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Notch Orchestrator.app"]
  end

  uninstall quit: "dev.notch-orchestrator.app"

  zap trash: [
    "~/Library/Application Support/notch-orchestrator",
    "~/Library/Preferences/dev.notch-orchestrator.app.plist",
  ]

  caveats <<~EOS
    Notch Orchestrator is signed with its project's own certificate and is not
    notarized by Apple. This cask removes the quarantine mark from the app so
    that macOS opens it.

    Before removing it, choose "Remove Completely" in its menu, so that its
    hooks leave ~/.claude/settings.json.
  EOS
end
