# Arch/KDE Wayland 安裝 Fcitx5-Rime 及本倉庫配置

## 安裝及桌面整合

1. 安裝所需軟件：

```sh
sudo pacman -Syu --needed \
  fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime \
  wget unzip
```

`fcitx5-rime` 會自動安裝 `librime`；`wget` 及 `unzip` 是倉庫建構指令碼的相依套件。

2. 在 KDE「系統設定 → 輸入及輸出 → 鍵盤 → 虛擬鍵盤」中選擇 **Fcitx 5**，不要另外建立自動啟動項目。

3. 為 XWayland 程式設定 XIM：

```sh
mkdir -p ~/.config/environment.d
printf '%s\n' 'XMODIFIERS=@im=fcitx' > ~/.config/environment.d/90-fcitx5.conf
```

在 KDE Wayland 下不要全域設定 `GTK_IM_MODULE`、`QT_IM_MODULE` 或 `SDL_IM_MODULE`，以免與原生 Wayland 輸入協定衝突。詳情可參閱 [Fcitx 官方建議](https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland/en)。

## 建構及部署倉庫配置

1. 在倉庫根目錄生成所有上游方案並套用本機修補：

```sh
cd /home/ayaka/Hub/MyRimeConfig
./scripts/prepare_schema.sh
./scripts/patch.sh
```

2. 確認核心檔案已經生成：

```sh
test -s root/default.yaml
test -s root/jyut6ping3.schema.yaml
test -s root/jyut6ping3.dict.yaml
test -s root/essay.txt
test -s opencc/t2hk.json
```

3. 測試 Rime 用戶資料夾不存在：

```sh
test ! -e "$HOME/.local/share/fcitx5/rime"
```

4. 只部署桌面版所需的 `root/` 及 `opencc/`；不要複製 `android/`、`windows/` 或指令碼資料夾：

```sh
mkdir -p ~/.local/share/fcitx5/rime/opencc
cp -a root/. ~/.local/share/fcitx5/rime/
cp -a opencc/. ~/.local/share/fcitx5/rime/opencc/
```

5. 建立 `~/.local/share/fcitx5/rime/default.custom.yaml`，預設只在方案選單啟用本倉庫的主要配置 `jyut6ping3`：

```yaml
patch:
  schema_list:
    - schema: jyut6ping3
```

其他反查方案及詞典仍會保留作為 `jyut6ping3` 的內部相依項目。Fcitx5-Rime 的標準用戶資料夾及 `schema_list` 格式可參閱 [ArchWiki Rime](https://wiki.archlinux.org/title/Rime)。

## 啟用及驗證

1. 登出並重新登入 Plasma，讓 KWin 啟動 Fcitx5 並載入環境變數。
2. 執行 `fcitx5-configtool`：
   - 按一下「新增輸入法」；
   - 在新增視窗中關閉「Only Show Current Language」；
   - 搜尋並加入 **Rime**；
   - 加入後刪除原有的英文鍵盤配置，只保留 **Rime**。
3. 切換至 Rime，在 Fcitx 選單中按一下 **Deploy／部署**。在 KDE Wayland 下不要以重新啟動 Fcitx 的方式部署，以免失去由 KWin 傳入的輸入法連線。
4. 驗收：
   - `~/.local/share/fcitx5/rime/build/jyut6ping3.schema.yaml` 已生成；
   - `Ctrl+Space` 可切換至 Rime；
   - 按 `F4` 可看到粵拼方案及「粵文／西文」等開關；
   - 輸入 `caumou` 可看到本倉庫的自訂詞「湫霧」；
   - 分別在 Kate 及瀏覽器文字方塊中驗證候選視窗及輸入結果；
   - 如有異常，執行 `fcitx5-diagnose` 檢查。

## 更新方式及假設

- 日後更新時依次執行：

```sh
cd /home/ayaka/Hub/MyRimeConfig
git pull --ff-only
python delete_old_files.py
./scripts/prepare_schema.sh
./scripts/patch.sh
cp -a root/. ~/.local/share/fcitx5/rime/
cp -a opencc/. ~/.local/share/fcitx5/rime/opencc/
```

然後再次按一下 **Deploy／部署**；不要刪除 `*.userdb`、`installation.yaml`、`user.yaml`、`sync/` 或個人的 `default.custom.yaml`。

- 本方案不會修改倉庫。
- 預設以 `jyut6ping3` 作為唯一的頂層方案。
- 本方案接受倉庫目前「每次下載各上游最新分支」的設計，因此建構結果不會固定於特定版本。
