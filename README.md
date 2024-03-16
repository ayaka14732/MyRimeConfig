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

```sh
scripts/prepare_schema.sh
scripts/patch.sh
```

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

```sh
scripts/prepare_schema.sh
scripts/patch.sh
```

## 更新方法

首先執行以下命令清除在 GitHub 其他專案中的檔案：

```sh
python delete_old_files.py
```

當然，在 GitHub 倉庫也可以使用 `git clean -xdf` 命令清除。

清除後，再次執行上述構建命令，即可更新。
