"""""""""""""""""""
" IDIOMATIC VIMRC "
"""""""""""""""""""
" Guidelines for sculpting your very own 'vimrc'.

" FILES AND DIRECTORIES

" Whatever you do to customize Vim, it should NEVER happen outside of '$HOME':
"
" - on Linux, BSD and Cygwin, '$HOME' is usually '/home/username/',
" - on Mac OS X, '$HOME' is '/Users/username/',
" - on Windows, '$HOME' is usually 'C:\Users\username\'.

" The canonical location for your 'vimrc' and your 'vim' directory is at
" the root of that directory:
"
"     on Unix-like systems    $HOME/vimrc
"                             $HOME/.vim/
"     on Windows              $HOME\_vimrc
"                             $HOME\vimfiles
"
" Vim 7.4 made it possible to keep your lovely 'vimrc' INSIDE your 'vim'
" directory. It is really a good idea, if only because it makes it easier to
" move your config around.
"
" If you use 7.4 exclusively, the following will be enough:
"
"     on Unix-like systems    $HOME/.vim/vimrc
"     on Windows              $HOME\vimfiles\vimrc
"
" If you use both 7.4 and an older version, or only an older version,
" the simplest, future-proof, solution is to put this line and only
" this line:
"
"     runtime vimrc
"
" in this file:
"
"     on Unix-like systems    $HOME/.vimrc
"     on Windows              $HOME\_vimrc
"
" and do your configuration in '$HOME/.vim/vimrc' or '$HOME\vimfiles\vimrc'.

" MISCELLANEOUS ADVICES

" - Using short names has ONLY cons and ZERO pros. Don't.
" - Learning how to use Vim's fantastic documentation is the most useful thing
"   a Vim newcomer could do:
"     :help :command
"     :help function()
"     :help 'option'
"     :help i_ctrl-a
"     :helpgrep foo
"     :help get<C-d>
"     <C-]> on an highlighted tag to jump to the corresponding entry
"     <C-t> to come back
" - Always refer to the relevant ':help' before adding anything to your vimrc.
" - You don't need 'set nocompatible' if you have a custom 'vimrc' at the
"   expected location.
" - 'set background=dark' doesn't do what you think it does.
" - 'set t_Co=256' is a bad idea, set your terminal up properly instead.
" - 'set paste' has a lot of side effects, don't put it in your 'vimrc'.
" - If you have a lot of autocommands for a lot of filetype-specific settings,
"   consider moving the setting to proper ftplugins:
"     ~/.vim/after/ftplugin/php.vim
" - If you have a lot of custom functions, consider moving them
"   to the 'autoload/' directory. See ':help autoload':
"     ~/.vim/autoload/myfunctions.vim
"     call myfunctions#foo()
" - Vim already gives you the ability to browse local and remote filesystems,
"   integrate 'ack' or 'ag', navigate, complete and compile your code, run
"   syntax checkers on write, consult documentation, filter text through
"   external commands, etc. Make sure you have exhausted Vim's features before
"   installing a plugin. Any plugin.

" OPTIONS

" There are three kinds of options:
" - boolean options,
" - string options,
" - number options.
" Checking the value of an option:
" - use ':set option?' to check the value of an option,
" - use ':verbose set option?' to also see where it was last set.

" Setting boolean options
set booloption      " Set booloption
set nobooloption    " Unset booloption

set booloption!     " Toggle booloption

set booloption&     " Reset booloption to its default value

" Setting string options
set stroption=baz   " baz

set stroption+=buzz " baz,buzz
set stroption^=fizz " fizz,baz,buzz
set stroption-=baz  " fizz,buzz

set stroption=      " Unset stroption

set stroption&      " Reset stroption to its default value

" Setting number options
set numoption=1     " 1

set numoption+=2    " 1 + 2 == 3
set numoption-=1    " 3 - 1 == 2
set numoption^=8    " 2 * 8 == 16

" MAPPINGS

" - Don't put comments after mappings.
" - Use ':map <F6>' to see what is mapped to '<F6>' and in which mode.
" - Use ':verbose map <F6>' to also see where it was last mapped.
" - See ':help key-notation'.
" - ':map' and ':map!' are too generic. Use ':n*' for normal mode mappings,
"   ':i*' for insert mode, ':x*' for visual mode, etc.
"   See ':help map-commands'.

" Use non-recursive mappings ONLY if you intend to use default commands in
" your mappings, wWhich is almost always what you want.
nnoremap <key> yyp

" Use recursive mappings ONLY if you intend to use other mappings
" in your mappings.
nnoremap b     B
nmap     <key> db

" Executing a command from a mapping
nnoremap <key> :MyCommand<CR>

" Executing multiple commands from a mapping
nnoremap <key> :MyCommand <bar> MyOtherCommand <bar> SomeCommand<CR>

" Calling a function from a mapping
nnoremap <key> :call SomeFunction()<CR>

" VARIABLES

" Like most scripting languages, vimscript has variables.
" One can define a variable with the ':let' command:
let variable = value

" And delete it with ':unlet':
unlet variable

" In Vim, variables can be scoped by prepending a single letter and a colon
" to their name. Plugin authors use that feature to mimic options:
let g:plugin_variable = 1

" Read up on the subject in ':help internal-variables'.

" COMMANDS

" - Don't forget the bang to allow Vim to overwrite that command next time
"   you reload your vimrc.
" - Custom commands must start with an uppercase character.
" - See ':help user-commands'.
command! MyCommand call SomeFunction()
command! MyOtherCommand command | Command | command

" FUNCTIONS

" - Don't forget the bang to allow Vim to overwrite that function next time
"   you reload your vimrc.
" - Custom functions must start with an uppercase character.
" - See ':help user-functions'.
function! MyFunction(foo, bar)
  return a:foo . a:bar
endfunction

" AUTOCOMMANDS

" - Autocommand groups are good for organization but they can be useful
"   for debugging too. Think of them as small namespaces that you
"   can enable/disable at will.
" - See ':help autocommand'.
augroup MyGroup
  " Clear the autocmds of the current group to prevent them from piling
  " up each time you reload your vimrc.
  autocmd!

  " These autocmds are fired after the filetype of a buffer is defined to
  " 'foo'. Don't forget to use 'setlocal' (for options) and '<buffer>'
  " (for mappings) to prevent your settings to leak in other buffers with
  " a different filetype.
  autocmd FileType foo setlocal bar=baz
  autocmd FileType foo nnoremap <buffer> <key> :command<CR>

  " This autocmd calls 'MyFunction()' everytime Vim tries to create/edit
  " a buffer tied to a file in /'path/to/project/**/'.
  autocmd BufNew,BufEnter /path/to/project/**/* call MyFunction()
augroup END

" CONDITIONALS

if v:version >= 704
    " Do something if Vim is the right version.
endif

if has('patch666')
    " Do something if Vim has the right patch-level.
    " See ':help has-patch'.
endif

if has('feature')
  " Do something if Vim is built with 'feature'.
  " See ':help feature-list'.
endif

" SUGGESTED MINIMAL SETTINGS FOR PROGRAMMING

" Enabling filetype support provides filetype-specific indenting
" and syntax highlighting.
filetype plugin indent on
syntax on

" 'matchit.vim' is built-in so let's enable it!
" Hit '%' on 'if' to jump to 'else'.
runtime macros/matchit.vim

" various settings
set autoindent                 " Minimal automatic indenting for any filetype
set backspace=indent,eol,start " Proper backspace behavior
set hidden                     " Possibility to have more than one
                               " Unsaved buffers
set incsearch                  " Incremental search, hit '<CR>' to stop
set ruler                      " Shows the current line number at the bottom
                               " Right of the screen
set wildmenu                   " Great command-line completion, use '<Tab>' to
                               " Move around and '<CR>' to validate
