# brew安装、卸载、常用命令

[brew官网](https://brew.sh/)

##### 安装：

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

##### 卸载：

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
```

##### 常用命令：

安装软件：`brew install xxx`
卸载软件：`brew uninstall xxx`
搜索软件：`brew search xxx`
更新软件：`brew upgrade xxx`
查看列表：`brew list`
更新brew：`brew update`



## Mac ruby更新

##### 1、先安装好 RVM

RVM 是一个便捷的多版本 ruby 环境的管理和切换工具

官网：https://rvm.io/

###### 1.1 在终端控制台命令：

$ curl -sSL https://get.rvm.io | bash -s stable 之后按回车键

###### 1.2 然后，载入 RVM 环境：

$ source ~/.rvm/scripts/rvm

###### 1.3 修改 RVM 下载 Ruby 的源，到 Ruby China 的镜像: ！！！记住这个镜像 是 ruby-china.org 不是其他的。

echo "ruby_url=https://cache.ruby-china.org/pub/ruby" > ~/.rvm/user/db

###### 1.3.1 检查一下是否安装正确

$ rvm -v

如果能显示版本号,则安装成功。

如果之前安装过 RVM 想要更新，则 

$ rvm get stable

##### 2、安装 ruby

列出 ruby 可安装的版本信息 (这里安装的是 2.4.0 的)

$ rvm list known

安装一个ruby版本

$ rvm install 2.4.0

如果想设置为默认版本，可以用这条命令来完成

$ rvm use 2.4.0 --default

##### 3、重装Ruby

###### 3.1 rvm uninstall 你当前的ruby版本

###### 3.2 如果无法卸载，提示如下：

Error running '__rvm_rm_rf /Users/xxx/.rvm/rubies/ruby-2.6.0-preview2',

please read /Users/xxx/.rvm/log/1538210544_ruby-2.6.0-preview2/remove.rubies.log

可以使用remove命令，sudo rvm remove 2.6.0，完全移除。

##### 3.3 安装需要的版本

rvm ruby 2.4.1

## Cocoapods

1 安装指定的cocoaPods版本

sudo gem install cocoapods --version <custom-version>

sudo gem install cocoapods -n /usr/local/bin 

### gem的相关操作

gem sources --remove https://gems.ruby-china.org/

gem sources -a https://gems.ruby-china.com/

gem sources -l

gem list --local | grep cocoapods

sudo gem update --system

sudo gem update --system 2.7.6

gem uninstall cocoapods -v 1.5.3

sudo gem install cocoapods --version 1.3.1