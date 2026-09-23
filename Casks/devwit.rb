# Homebrew Cask for DevWit — 个人 tap（eeyzs1/homebrew-tap）分发。
# 用户安装：brew install --cask eeyzs1/tap/devwit
# sha256 实证来源：对应版本 Release 的 dmg 资产 digest（GitHub API）。
cask "devwit" do
  version "0.7.30"
  sha256 "fc901e0be421386c8a52215806e6cbf57c35357609bfe68060f79b855c47c0a4"

  url "https://github.com/eeyzs1/DevWit/releases/download/v#{version}/DevWit-#{version}-arm64.dmg"
  name "DevWit"
  desc "Lean-context AI-native desktop IDE (简洁上下文 AI 原生桌面 IDE)"
  homepage "https://github.com/eeyzs1/DevWit"

  # 仅发布 Apple Silicon 资产（CI macos arm64 runner 构建）；Intel Mac 暂无对应包。
  depends_on arch: :arm64

  app "DevWit.app"

  # 未签名开发分发：Gatekeeper 首次打开会拦截，brew 安装后执行一次去隔离即可。
  # （homebrew 对 cask 默认保留 quarantine 属性）
  caveats <<~EOS
    DevWit is distributed unsigned. After install, run once:
      xattr -dr com.apple.quarantine /Applications/DevWit.app
    Auto-update on macOS requires a signed build; until then, upgrade via:
      brew upgrade --cask eeyzs1/tap/devwit
  EOS

  zap trash: [
    "~/Library/Application Support/DevWit",
    "~/Library/Preferences/com.devwit.app.plist",
  ]
end
