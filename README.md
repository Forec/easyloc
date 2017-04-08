# EasyLOC - 小型代码行统计工具

easyloc 是一个模块化、易扩展的代码行统计工具。

## 安装
### 下载预构建版本
选择并下载 easyloc 最新的预构建版本。
* [Windows](#)
* [Linux](#)
* [Mac OS](#)

下载的二进制文件名为 `easyloc`，将其放置在环境变量 `$PATH$` 包含的目录下。 

### 从源码编译
要从源码编译，你的环境需要 GHC >= 8.0.2。
```shell
git clone https://github.com/Forec/easyloc.git
cd easyloc
ghc -O2 easyloc.hs -threaded -rtsopts
```
编译成功将生成二进制文件 `easyloc`，将其放置在环境变量 `$PATH$` 包含的目录下。 

## 使用
执行 `easyloc [Language] [path]` 对指定目录下的文件按指定语言的语法规则进行统计。

可以通过增加运行时选项 `+RTS -Ni` 提高效率，默认情况下 easyloc 只使用单核，通过改变参数 i 的值可使用多核。

## 待实现功能
* ~区分文件类型~
* 对文件内容按指定语法规则解析
* 忽略 Unknown 文件
* 并发搜索

## 许可证
此仓库中的全部代码均受仓库中 [License](https://github.com/Forec/easyloc/blob/master/LICENSE) 声明的许可证保护。

