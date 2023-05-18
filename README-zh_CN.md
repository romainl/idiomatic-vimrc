# IDIOMATIC VIMRC

打造属于你自己的`~/.vimrc`的导引指南。

本文档有以下语言版本：

- [English](./README.md)
- [Simplified Chinese](./README-zh_CN.md)

不同于网络上众多所谓的“发行版”、“模板”、或“终极配置方案`vimrc`"配置文件，这份指南的意图**不是**提供一个可用的配置文件，也不是用带有个人偏好的“默认值”帮助你提升编辑效率，也不是告诉你应该在配置文件中添加什么内容。因此，不要把它复制到你的`$HOME`目录中以期待它会有任何帮助。

这份指南的目的在于记录那些经过考验的Vim配置的最佳实践。因此，请把它当作参考，而非配置Vim的起点。

除此之外，`vimrc`配置是很个性化的，随着你的Vim功夫（Vim-fu）的进步以及需求的改变，你的`vimrc`也会随之增长、缩减和演变。虽然借鉴其他人的`vimrc`配置可能是一个有趣的练习，但应该避免为不存在的问题寻找解决方案。

请记住，当你不加思考地使用别人的`vimrc`时，你就会像熊猫一样被送进“**熊猫监狱**”（Pandajail）！不要成为这样的人，也不要成为导致他人陷入“熊猫监狱”的人。

![pandajail](https://i.chzbgr.com/maxW500/7518742016/h59D3B471/)



## 目录

* [文件目录](#文件目录)
* [杂项建议](#杂项建议)
* [默认配置](#默认配置)
* [设置选项](#设置选项)
* [键盘映射](#键盘映射)
* [变量](#变量)
* [自定义命令](#自定义命令)
* [自定义函数](#自定义函数)
* [自动命令](#自动命令)
* [条件语句](#条件语句)
* [颜色配置](#颜色配置)
* [插件](#插件)
* [针对编程的最小推荐配置](#针对编程的最小推荐配置)



## 文件目录

除非你*真的*知道自己在做什么（提示：如果你从这份指南中学到了任何东西，说明你还没有达到这种水平），在自定义Vim相关设定时，所有的操作都不应该发生在`$HOME`目录之外：

- 在Linux、BSD和Cygwin上，`$HOME`通常是`/home/username/`
- 在Mac OS X上，`$HOME`是`/Users/username/`
- 在Windows上，`$HOME`通常是`C:\Users\username\`

如果你不确定，打开Vim并输入：

    :echo $HOME

在了解了`$HOME`目录之后，你还必须知道vim的“运行时文件”。Vim的正常运行依赖于其中几个文件，这些文件位于两个“运行时目录”中，一个是系统的运行时目录，另一个是用户的运行时目录。系统的运行时目录包含了Vim安装时提供的所有运行时文件，最好保持原样不变。用户运行时目录位于前述的`$HOME`中，对Vim进行的自定义大部分都位于这里的`vimrc`配置文件以及你自己的`vimfiles`运行时目录。

你的`vimrc`配置文件以及`vimfiles`目录的规范位置位于`$HOME`目录下：

| 操作系統  | `vimrc`        | `vimfiles`        |
| --------- | -------------- | ----------------- |
| UNIX-like | `$HOME/.vimrc` | `$HOME/.vim/`     |
| Windows   | `$HOME\_vimrc` | `$HOME\vimfiles\` |

注意：Vim本身并不会创建这些文件和目录，*你需要自己去创建它们*。

从Vim 7.4开始，你也可以把你心爱的`vimrc`配置放到`vimfiles`目录中。这是一个很好的主意，因为这样一来你就可以更加轻松地将你的Vim配置从一台机器迁移到另一台机器。

以下是从7.4版本开始的一种整洁的设置方式：

| 操作系统  | 位置                   |
| --------- | ---------------------- |
| UNIX-like | `$HOME/.vim/vimrc`     |
| Windows   | `$HOME/vimfiles/vimrc` |

不过，当你决定把你的`vimrc`配置放到`vimfiles`目录中时，请注意以下几点：

* 文件名是`vimrc`，不要添加前缀的点号（`.vimrc`）或者下划线（`_vimrc`）；
* 确保你的`.vimrc`或者`_vimrc`没有被创建符号链接，确保你在*移动*它们，而不是复制。

为简单起见，指南的剩余部分将使用`vimrc`、`vimfiles`和`$HOME`而非它们的实际名称和路径。

### 关于教程的说明

Vim教程（包括这份指南）以及插件说明通常都是从Unix视角编写的，这一直以来都让Windows用户感到困惑。如果你是Windows用户，并尝试遵循针对Unix的说明，请牢记以下几点：

- 当作者说`~`、`~/`、`$HOME`或`$HOME/`时，请将其理解为`C:\Users\username\`；
- 当作者说`vimrc`、`.vimrc`或`~/.vimrc`时，请将其理解为`C:\Users\username\_vimrc`，或者`C:\Users\username\vimfiles\vimrc`如果你遵循了上述建议；
- 当作者说 `.vim`、`.vim/`、`~/.vim` 或 `~/.vim/` 时，请将其理解为 `C:\Users\username\vimfiles\`。



## 杂项建议

- 在命令行中输入时，使用像`fu`或`ai`这样的缩写名称是有意义的，但在你的`vimrc`文件中，这样做只会降低可读性，所以不要这样做。
- 学习如何使用Vim说明文件对于Vim初学者来说是最有帮助的建议：

      :help command
      :help function()
      :help 'option'
      :help i_ctrl-a
      :helpgrep foo
      :help get<C-d>
      在高亮的标签上使用<C-]> （Ctrl+]）来跳转到相应的词条
      使用<C-t> （Ctrl+t）返回

- 在添加*任何*内容到你的`vimrc`文件之前，使用`:help`查看相关的内容。
- 如果你的`vimrc`文件放置正确（如上所述），你并不需要使用`set nocompatible`。
- `set background=dark`并不是你想的那样。
- `set t_Co=256`是一个坏主意。Vim会根据`$TERM`的值自动设定`t_Co`，你应该正确地配置你的终端。
- `set paste`有很多令人讨厌的副作用，在你认真地阅读`:help 'paste'`的内容之前，不要把它放进你的`vimrc`配置中。
- 如果你有许多针对特定文件类型的自动命令，你应该考虑把这些配置项移动到对应的文件类型插件中，例如

      $HOME/.vim/after/ftplugin/php.vim

- 如果你有很多自定义函数，你应该考虑把它们移动到`autoload/`目录下（如下所示）：

      $HOME/.vim/autoload/myfunctions.vim
      call myfunctions#foo()

  详见`:help autoload`。

- Vim已经提供了浏览本地和远程文件系统，集成`ack`、`ag`或者`rg`命令，导航，代码补全和编译，逐步查看错误，运行语法检查器，阅读文档，通过外部命令过滤文本等功能。在安装任何插件之前，请确保你已经充分了解并利用了Vim的功能。注意是任何插件。



## 默认配置

Vim的简朴的默认设置长期以来一直倍受争议。在Vim 7.4和8.0版本之间，Vim决定为新手提供一个更加用户友好的基础设置。如果在通常的位置（参见上文）都没有找到`vimrc`配置，Vim就会静默地加载一个特定的运行时文件`defaults.vim`。这个解决方案的确提升了新手的使用体验，在不添加自定义设置的情况下，默认的配置确实提供了比以前更加舒适的体验。

然而，这个解决方案仍有许多问题，其中之一就是：要深入学习Vim就意味着要创建自己的`vimrc`，而这实际上会禁用`defaults.vim`。这让新手的境遇比以前更加糟糕：他们面对着每个人都不喜欢的简朴默认配置，并且对如何找回他们习惯使用的有用功能一无所知，因为`defaults.vim`几乎就是一个黑盒。干得好！（反讽）

如果你恰好处于这样一个尴尬的境地，`:help defaults.vim`提供了两个快速简单但并不完美的解决方案。第一个办法是在你的`vimrc`文件中加载该文件：

    unlet! skip_defaults_vim
    source $VIMRUNTIME/defaults.vim

第二个办法是将`defaults.vim`文件的内容复制到你的`vimrc`文件中，例如通过以下方式：

    :0read $VIMRUNTIME/defaults.vim

详见`:help source`和`:help :read`。

注意：作者并不认为上述任何一种解决方案特别令人满意，而是建议尝试理解`defaults.vim`文件的作用，并最终将其中最有用的部分复制到自己的`vimrc`文件中。



## 设置选项

Vim中有三种选项（Options）：

- 布尔选项，
- 字符串选项，
- 数值选项。

检查选项的值：

- 使用`:set option?`来查看选项的值，
- 使用`:verbose set options?`查看最后设定选项的位置。

查看一个选项的相关文档：

    :help 'optionname'
    :help 'optionname
    :help optionname'

设定布尔选项（`booloption`不是一个实际的选项）：

    set booloption      " 启用booloption
    set nobooloption    " 关闭booloption

    set booloption!     " 切换booloption

    set booloption&     " 重设booloption为默认值

设定字符串选项（`stroption`不是一个实际的选项）：

    set stroption=baz   " baz

    set stroption+=buzz " baz,buzz
    set stroption^=fizz " fizz,baz,buzz
    set stroption-=baz  " fizz,buzz

    set stroption=      " 清空stroption

    set stroption&      " 重设stroption为默认值

设定数值选项（`numoption`不是一个实际的选项）：

    set numoption=1     " 1

    set numoption+=2    " 1 + 2 = 3
    set numoption-=1    " 3 - 1 = 2
    set numoption^=8    " 2 * 8 = 16

    set numoption&      " 重设numoption为默认值

- 除此之外，一个选项可以是全局的（适用于所有buffer），或窗口局部的（适用于设定该选项的窗口），或buffer局部的（适用于设定该选项的buffer），并且一个选项可以既有一个全局值，也有一个局部值。使用`:setlocal`取代`:set`可以方便地改变选项的局部值，但这并不是银弹，详见`:help :setlocal`。先认真的阅读文档中该选项的说明，再决定*如何*进行设置。
- `:set`一族命令并不接受表达式作为值，例如：

      :set stroption='my string'     " 值为'my string'，包含单引号
      :set stroption=MyFunction()    " 值为MyFunction()，而不是函数返回值
      :set numoption=23+4            " 报错

    因此，应使用`let-&`，详见`:help :let-&`：

      :let &stroption = 'my string'  " 值为my\ string，不包含单引号
      :let &stroption = MyFunction() " 值为MyFunction()的返回值
      :let &numoption = 23+4         " 值为27



## 键盘映射

- 不要在映射之后写注释，那不会有用的。
- 使用`:map <F6>`查看`<F6>`在什么模式下映射了什么。
- 使用`:verbose map <F6>`查看最后绑定位置。
- 关于如何表达一个回车或Ctrl键的组合，详见`:help key-notation`。
- `:map`和`:map!`涵盖了太多模式，使用`:nmap`在普通模式下进行映射，使用`:imap`在插入模式下进行映射，使用`:xmap`在可视模式下进行映射，等等。
- 详见`:help map-commands`。
- 除了像Netrw这样的内置插件，Vim本身没有提供*任何*映射。所有的映射由*你*决定。

如果你在映射中只使用Vim预设命令，那么你应该使用非递归的映射，你的大部分需求都应如此：

    nnoremap <key> yyp

只有当你想要在映射中使用你自己定义的映射时才使用递归映射：

    nnoremap b     B
    nmap     <key> db

在映射中执行命令：

    nnoremap <key> :MyCommands<CR>

在映射中执行多条命令：

    nnoremap <key> :MyCommand <bar> MyOtherCommand <bar> SomeCommand<CR>

在映射中调用函数：

    nnoremap <key> :call SomeFunction()<CR>

注意：自从8.2.1978版本起，推荐使用`<Cmd>`来调用Ex命令，详见`:help <Cmd>`，例如：

    nnoremap <key> <Cmd>MyCommand<CR>
    nnoremap <key> <Cmd>MyCommand <bar> MyOtherCommand <bar> SomeCommand<CR>
    nnoremap <key> <Cmd>SomeFunction()<CR>

映射的右端是一个宏，也即一连串的按键，你在这里输入的所有内容都会被输入，所以要注意空格等按键。例如，下面两个映射做的事请完全不同：

    nnoremap <key> w i foo <Esc>
    nnoremap <key> wifoo<Esc>



## 变量

就像绝大多数脚本语言一样，Vimscript也有变量。

可以通过`let`定义变量，详见`:help :let`：

    let variable = value

可以通过`echo`查看变量的值，详见`:help :echo`：

    echo variable

可以通过`unlet`删除变量，详见`:help :unlet`：

    unlet variable

在Vim中，可以通过在变量名称前添加单个字母加冒号的前缀来限定变量的作用域。插件的作者经常使用这个特性来提供类似选项的功能：

    let g:plugin_variable = 1

或者将其设定为“私有”变量：

    let s:script_variable = 'foo'

详见`:help internal-variables`中的相关内容。



## 自定义命令

- 不要忘记使用`!`来让Vim在下一次重新加载`vimrc`时覆盖该命令。
- 自定义命令名称必须以大写字母开头。
- 详见`:help user-commands`。

例子：

    command! MyCommand call SomeFunction()
    command! MyOtherCommand command | Command | command



## 自定义函数

- 不要忘记使用`!`来让Vim在下一次重新加载`vimrc`时覆盖该函数。
- 不要忘记在出现错误时使用`abort`来提前终止函数。
- 自定义函数名称必须以大写字母开头。
- 详见`:help user-functions`。
- 如之前所述，把自定义函数放到`$HOME/.vim/autoload/`是一个很好的做法。

例子：

    function! MyFunction(foo, bar) abort
    return a:foo . a:bar
    endfunction



## 自动命令

- 自动命令组（autocommand groups）不仅可以用来组织结构，也可以帮助进行调试。可以把它们当作可以随意启用/禁用的小型命名空间。
- 详见`:help autocommand`。

例子：

    augroup MyGroup
      " 清除当前组的自动命令，以防止它们在每次重新加载vimrc时堆积起来
      autocmd!
      " 每当Vim试图创建或者编辑一个与/`path/to/project**/`中的文件相联系的缓冲区时
      " 这个自动命令都会调用`MyFunction()`
      autocmd BufNew,BufEnter /path/to/project/**/* call MyFunction()
    augroup END


另一种方案：

    " 在你的vimrc顶部的某个地方放一个空的、自动清除的组
    augroup MyGroup
      autocmd!
    augroup END

    " 在其他任何地方向该组添加自动命令
    autocmd MyGroup BufNew,BufEnter /path/to/project/**/* call MyFunction()



## 条件语句

- 详见`:help :if`。

判断Vim的版本，并执行相应的操作：

    if v:version >= 704
      " 详见:help v:version
    endif

判断Vim的补丁版本，并执行相应的操作：

    if has('patch666')
      " 详见:help has-patch
    endif

判断Vim是否具有某种特性，并执行相应的操作：

    if has('feature')
      " 详见:help feature-list
    endif

在星期三做些特殊的事情：

    if strftime("%u") == 3
      " 详见:help time-functions
    endif



## 颜色配置

- GUI Vim（`gvim`、GVim 或 MacVim GUI）可以显示数百万种颜色，在颜色方面提供了最大的灵活性。
- TUI Vim（在终端中运行的`vim`）受到终端模拟器（Terminal）能力的限制。
- 专为GUI设计的颜色方案不一定在TUI Vim中适用。
- 专为TUI设计的颜色方案不一定在GUI Vim中适用。
- 要确定一个漂亮的颜色方案是否适合你的环境，请参考以下几点提示：
	- `guibg`/`guifg`意味着支持GUI，并且可能也会支持“真彩色”；
	- `ctermbg`/`ctermfg`意味着支持TUI；
	- `if &t_Co >= 256`是测试终端模拟器是否支持256种颜色的测试，这可能意味着其能力达到一定水平；
	- `if &t_Co >= 16`是测试终端模拟器是否支持16种颜色的测试，这可能意味着其能力达到一定水平。
- 在Vim中，特性检测并不是一个已经完全解决的问题，所以最好不要假设任何事情。

独立颜色方案的标准存放位置是：

    $HOME/.vim/colors/foobar.vim

你可以使用以下命令将其设置为当前颜色方案：

    :colorscheme foobar

并通过在`vimrc`中添加下面这行来保持该选择：

    colorscheme foobar

注意：如今大多数颜色方案以“插件”的形式提供。请继续阅读以了解这些插件的工作方式。



## 插件

Vim虽然功能丰富，但当内置功能不够用时，我们可以利用其丰富的插件生态。在寻找插件时，应该遵循以下几点：

- 遵循Vim的哲学；
- 不要重复内置的功能；
- 允许你（重新）定义它们的映射；
- 没有不合理的需求。

Vim插件应该安装在你的`vimfiles`目录中，而不是其他**任何**地方。

设计得当的插件通常遵循Vim自身的运行时目录结构：

- 特定文件类型的脚本以其文件类型命名，并放入`ftplugin/`目录中

      $HOME/.vim/ftplugin/javascript.vim

- 特定文件类型的缩进脚本以其文件类型命名，并放入`indent/`目录中

      $HOME/.vim/indent/javascript.vim

- 特定文件类型的语法脚本以其文件类型命名，并放入`syntax/`目录中

      $HOME/.vim/syntax/javascript.vim

- 自动加载的脚本放入`autoload/`目录中

      $HOME/.vim/autoload/foo.vim

- 插件脚本放入`plugin/`目录中

      $HOME/.vim/plugin/foo.vim

- 插件说明文档放入`doc/`目录中

      $HOME/.vim/doc/foo.txt

- 等等。

在过去，安装插件的常规方法是将每个文件放入`vimfiles`目录下的相应目录中，正如上所述。这种方式比较混乱，添加的插件越多，`vimfiles`目录就会越混乱。

为了解决这个问题，出现了一些被人们称为“插件管理器”的工具，它们或多或少都围绕相同的逻辑构建：每个插件都保存在一个公共父目录下的自己的目录中，Vim通过`:help 'runtimepath'`指令来确定如何找到这些插件。

请注意，使用插件管理器并非绝对必要。毕竟，传统的方式虽然混乱但是可行，但如果您认为自己需要一个插件管理器，请务必在使用前阅读并理解其`README.md`文件。

### Vim 8的“package”特性

Vim 8引入了一种名为*package*的新方案，该方案允许您将插件组织成所谓的“包”（packages），并决定它们是在启动时启用还是手动启用： 

| 目录                     | 描述                           |
| ------------------------ | ------------------------------ |
| `pack/{任意名称}/start/` | 此目录中的插件在启动时自动启用 |
| `pack/{任意名称}/opt/`   | 此目录中的插件需要手动启用     |

例如，以下是作者的设置：

* `$HOME/.vim/pack/bundle/start/`是放置所有“生活质量”（quality of life）插件的地方；
* `$HOME/.vim/pack/lang/start/`是放置所有“语言支持”插件的地方。

虽然这个特性是一个明显的改进，但它仍然*不是*一个真正的插件管理器。如果你需要插件管理器，你可以考虑使用一个。

请参见`:help package`。



## 针对编程的最小推荐配置

你如何定制自己的工具完全取决于：(1) 你用它们来做什么，以及(2) 你对它们了解如何；因此每个人的情况都不同，要根据自己情况而定。以下的设定仅供参考，如果作者需要在一台新机器上工作几小时并且不想安装他完整的配置，作者会采用这样的基本设定：

    " 启用filetype，提供针对文件类型的缩进、语法高亮、关键字补全和其他有用的功能
    filetype plugin indent on
    syntax on

    " 既然`matchit.vim`是内置的，那就让我们启用它吧！
    " 光标放置在`if`时按下`%`来跳转到对应的`else`
    runtime macros/matchit.vim

    " 其他配置
    set autoindent                  " 针对几乎任何文件类型的最小自动缩进功能
    set backspace=indent,eol,start  " 符合直觉的退格键行为
    set hidden                      " 可以同时有多个未保存的buffer
    set incsearch                   " 增量搜索，按下`<CR>`停止搜索
    set ruler                       " 在屏幕右下角显示当前行的行号
    set wildmenu                    " 很棒的命令行自动补全，用`<Tab>`进行移动
                                    " 用`<CR>`来确定
