cask "google-drive" do
  version "47.0.19"
  sha256 :no_check

  url "https://dl.google.com/drive-file-stream/GoogleDrive.dmg"
  name "Google Drive"
  desc "Client for the Google Drive storage service"
  homepage "https://www.google.com/drive/"

  livecheck do
    url :url
    strategy :extract_plist
  end

  depends_on macos: ">= :el_capitan"

  pkg "GoogleDrive.pkg"

  uninstall login_item: "Google Drive",
            quit:       "com.google.drivefs",
            pkgutil:    [
              "com.google.drivefs",
              "com.google.drivefs.x86_64",
              "com.google.drivefs.filesystems.dfsfuse.x86_64",
              "com.google.drivefs.shortcuts",
            ]

  zap trash:     [
    "~/Library/Application Support/Google/DriveFS",
    "~/Library/Caches/com.google.drivefs",
    "~/Library/Preferences/Google Drive File Stream Helper.plist",
    "~/Library/Preferences/com.google.drivefs.plist",
  ],
      launchctl: [
        "com.google.keystone.agent",
        "com.google.keystone.system.agent",
        "com.google.keystone.daemon",
        "com.google.keystone.xpcservice",
        "com.google.keystone.system.xpcservice",
      ]

  caveats <<~EOS
    Although #{token} may be installed alongside Google Backup and Sync, you should not use the same account with both.

      https://support.google.com/a/answer/7496409#allowboth
  EOS
end
