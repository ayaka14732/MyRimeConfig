# My Rime Configuration

## Design Philosophy

In the Rime input method, there's the concept of shared directory and user directory, where the configurations in the user directory override those in the shared directory. When users need to configure, they should place their own configuration files in the user directory.

Typically, Rime users add custom input schemata by directly downloading the desired schemata from GitHub and placing them in the user directory. However, the schemata on GitHub may be updated, while the local versions remain outdated and do not update automatically. Managing and manually updating each schema can become quite troublesome when there are many.

Moreover, configuring Rime in a new system involves manually downloading the necessary schemata one by one from GitHub, which is also very troublesome.

To avoid the above problems, this project catgorises my Rime configuration into "files in other GitHub projects" and "files not in other GitHub projects," and proceeds as follows:

1. For files in other GitHub projects, use a script to automatically download these contents, without saving and tracking them in this repository;
2. For files not in other GitHub projects, save them in this repository;
3. After downloading files from other GitHub projects, use another script to make necessary modifications to the downloaded content.

This ensures the produced configuration files are always the latest version and can be used in the Rime user directory.

## Build Method

Linux/macOS:

```sh
scripts/prepare_schema.sh
scripts/patch.sh
```

Windows Command Prompt:

```cmd
scripts\prepare_schema.cmd
scripts\patch.cmd
```

## Trime (Android) Setup

After building the configuration, a fresh installation of Trime still needs the following one-time setup:

1. Install an official Trime release or nightly build, enable Trime in Android's input-method settings, and select it as the default input method.
2. Open **Trime > Profile > User data directory**. This configuration uses `/storage/emulated/0/rime` (also written as `/sdcard/rime`). Copy:
   - everything under `root/` to the user data directory;
   - everything under `opencc/` to `<user-data-directory>/opencc/`;
   - `android/creatlach.trime.yaml` to `<user-data-directory>/creatlach.trime.yaml`;
   - the private font files to `<user-data-directory>/fonts/`: `HanaMinB.ttf`, `ModernExtended-T-OT-italic-letter-only.otf`, and `LokYuenMingHK_Regular_noeng.ttf`.
3. Tap **Deploy** (the refresh button in Trime's top app bar). Select the desired input schemata under **Schemata** if they have not already been restored by `default.custom.yaml`.
4. Open **Theme** and set:
   - **Themes**: `Creatlach`;
   - **Colors**: `Material Dark / Dubh` (select `Material Light / Liath` manually if a light palette is desired);
   - **Follow system day/night color**: enabled. Creatlach links `Material Dark / Dubh` and `Material Light / Liath` with `dark_scheme` and `light_scheme`, so Trime can switch palettes with the system.
5. On a phone using gesture navigation, open **Advanced** and enable **Ignore system gesture insets**. This avoids adding the system gesture safe inset on top of Creatlach's bottom spacing. Leave it disabled if the device needs that safety area.

After setup, open any text field and check that the custom key font is loaded, candidate comments appear above the candidates, and the quick bar contains the persistent `粵文`/`西文` switch. After later configuration updates, copy the changed files to the same user directory and deploy again. Trime app updates normally preserve its preferences; a clean installation requires the theme and advanced options above to be selected again.

## Update Method

First, execute the following command to clear the files from other GitHub projects:

```sh
python delete_old_files.py
```

Of course, in the GitHub repository, you can also use the `git clean -xdf` command to clear them.

After clearing, execute the build commands mentioned above to update.

---

# 我的 rime 配置

## 設計思想

在 rime 輸入法中有共享文件夾和用户文件夾的概念，用户文件夾中的配置高於共享文件夾中的配置。當用户需要配置時，要將自己的配置檔放在用户文件夾中。

通常，rime 用户在添加自定義的輸入方案時，往往會直接從 GitHub 下載想要的輸入方案，放入用户文件夾中。但是，GitHub 上的方案會被更新，而用户本地的方案還是舊的方案，不會隨之更新。當方案數量較多時，管理並手動更新每個方案會產生很大的麻煩。

此外，當在新的系統中配置 rime 時，需要從 GitHub 上逐一手動下載需要的方案，這也非常麻煩。

為了避免上述問題，本專案將我的 rime 配置分為「在 GitHub 其他專案中的檔案」和「不在 GitHub 其他專案中的檔案」，並進行如下操作：

1. 對於在 GitHub 其他專案中的檔案，使用腳本自動下載這些內容，而不保存在這個倉庫中；
1. 對於不在 GitHub 其他專案中的檔案，將它們保存在這個倉庫中；
1. 從 GitHub 其他專案下載檔案後，再使用腳本對下載的內容進行必要的修改。

由此生成的配置檔永遠是最新版本的，可以放入 rime 用户文件夾中使用。

## 構建方法

Linux/macOS：

```sh
scripts/prepare_schema.sh
scripts/patch.sh
```

Windows 命令提示字元：

```cmd
scripts\prepare_schema.cmd
scripts\patch.cmd
```

## Trime（Android）安裝後設定

構建配置後，全新安裝的 Trime 仍需進行以下一次性設定：

1. 安裝 Trime 官方正式版或 nightly 版，在 Android 的輸入法設定中啟用 Trime，並將其選為預設輸入法。
2. 打開 **Trime > 配置 > 使用者資料夾**。本配置使用 `/storage/emulated/0/rime`（亦可寫作 `/sdcard/rime`）。將：
   - `root/` 下的全部內容複製到用户資料夾；
   - `opencc/` 下的全部內容複製到 `<用户資料夾>/opencc/`；
   - `android/creatlach.trime.yaml` 複製為 `<用户資料夾>/creatlach.trime.yaml`；
   - 私有字體檔複製到 `<用户資料夾>/fonts/`：`HanaMinB.ttf`、`ModernExtended-T-OT-italic-letter-only.otf` 及 `LokYuenMingHK_Regular_noeng.ttf`。
3. 點擊 **部署**（Trime 頂部工具列的重新整理按鈕）。若 `default.custom.yaml` 尚未恢復所需方案，再到 **方案** 中選取它們。
4. 打開 **鍵盤樣式**並設定：
   - **主題**：`Creatlach`；
   - **配色**：`Material Dark / Dubh`（如需淺色配色，可手動選擇 `Material Light / Liath`）；
   - **跟隨系統設定主題色調**：打開。Creatlach 已用 `dark_scheme`、`light_scheme` 配對 `Material Dark / Dubh` 與 `Material Light / Liath`，Trime 可據此跟隨系統切換配色。
5. 使用手勢導航的手機，請到 **高級** 打開 **忽略系統手勢插邊**，以免在 Creatlach 的底部間距之外再次疊加系統手勢安全區。若裝置確實需要該防誤觸空間，則保持關閉。

設定完成後，請在任意文字框檢查：按鍵自訂字體已載入、候選注音顯示於候選字上方，以及快捷欄中有常駐的 `粵文`／`西文` 切換鍵。日後更新配置時，只需把有改動的檔案再次複製到同一用户資料夾並重新部署。Trime 更新通常會保留應用程式偏好；全新安裝後則需重新選擇上述主題及高級選項。

## 更新方法

首先執行以下命令清除在 GitHub 其他專案中的檔案：

```sh
python delete_old_files.py
```

當然，在 GitHub 倉庫也可以使用 `git clean -xdf` 命令清除。

清除後，再次執行上述構建命令，即可更新。
