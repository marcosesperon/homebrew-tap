# Fórmula (cask) de Homebrew para GitSwitcher.
# La genera scripts/release.sh a partir de esta plantilla; no se edita a mano
# en el tap.
cask "gitswitcher" do
  version "1.2.2"
  sha256 "f98e4ceb935428b5af502f78096f24ca46b38b82d7338551c03bb9b6dfe67e28"

  url "https://github.com/marcosesperon/GitSwitcher/releases/download/v#{version}/GitSwitcher-#{version}.zip"
  name "GitSwitcher"
  desc "Menu bar app to switch between GitHub CLI (gh) accounts"
  homepage "https://github.com/marcosesperon/GitSwitcher"

  depends_on macos: :sonoma
  depends_on formula: "gh"

  app "GitSwitcher.app"

  # La app no está firmada con Developer ID: le quitamos la marca de
  # «descargado de internet» para que macOS no bloquee la primera apertura.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/GitSwitcher.app"]
  end

  uninstall quit: "com.marcosesperon.GitSwitcher"

  zap trash: "~/Library/Preferences/com.marcosesperon.GitSwitcher.plist"
end
