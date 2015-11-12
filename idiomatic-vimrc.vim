" The canonical location for your 'vimrc' is your '$HOME' directory:
"
"   on Unix-like systems    ~/.vimrc
"   on Windows              %userprofile%\_vimrc
"
" Since 7.4, it is now possible to keep your lovely 'vimrc' INSIDE of your 'vim
" directory. It is really a good idea, if only because it makes it easier to
" move your config around.
"
" If you are using 7.4 exclusively, the following will be enough:
"
"   on Unix-like systems    ~/.vim/vimrc
"   on Windows              %userprofile%\vimfiles\vimrc
"
" If you use both 7.4 and an older version, the simplest, future-proof,
" solution is to put this line and *only* this line:
"
"   runtime vimrc
"
" in this file:
"
"   on Unix-like systems    ~/.vimrc
"   on Windows              %userprofile%\_vimrc
"
" and do your configuration in '~/.vim/vimrc' or '%userprofile%\vimfiles\vimrc'.

" MISCELLANEOUS ADVICES

" * Using short names has *only* cons and *zero* pros. Don't.
" * Learning how to use Vim's fantastic documentation is the most useful thing
"   a Vim newcomer could do:
"       :help :command
"       :help function()
"       :help 'option'
"       :help i_ctrl-a
"       :helpgrep foo
"       :help get<C-d>
"       <C-]> on an highlighted tag to jump to the corresponding entry
"       <C-t> to come back
" * Always refer to the relevant ':help' page before adding anything to your vimrc.
" * You don't need 'set nocompatible' if you have a custom 'vimrc' at the expected
"   location.
" * 'set background=dark' doesn't do what you think it does.
" * 'set t_Co=256' is a bad idea, set your terminal emulator up properly instead.
" * 'set paste' has a lot of side effects, don't put it in your 'vimrc'.
" * If you have a lot of autocommands for a lot of filetype-specific settings,
"   consider moving those setting to proper ftplugins.
" * If you have a lot of custom functions, consider moving them
"   to the 'autoload/' directory. See ':help autoload'.
" * You can have syntax checking on write with three lines in your 'vimrc',
"   same for 'ack' or 'ag' integration, so make sure you have exhausted Vim's features
"   before installing a plugin.

" OPTIONS

" There are three kinds of options:
" * boolean options,
" * string options,
" * number options.
" Checking the value of an option:
" * use ':set option?' to check the value of an option,
" * use ':verbose set option?' to also see where it was last set.

" Boolean options
set booloption      " Set booloption
set nobooloption    " Unset booloption

set booloption!     " Toggle booloption

set booloption&     " Reset booloption to its default value

" String options
set stroption=baz   " baz

set stroption+=buzz " baz,buzz
set stroption^=fizz " fizz,baz,buzz
set stroption-=baz  " fizz,buzz

set stroption=      " Unset stroption

set stroption&      " Reset stroption to its default value

" Number options
set numoption=1     " 1

set numoption+=2    " 1 + 2 == 3
set numoption-=1    " 3 - 1 == 2
set numoption^=8    " 2 * 8 == 16

" MAPPINGS

" * Don't put comments after mappings.
" * Use ':map <F6>' to see what is mapped to '<F6>' and in which mode.
" * Use ':verbose map <F6>' to also see where it was last mapped.
" * See ':help key-notation'.

" Normal mode mapping
nmap <key> yyp
" Insert mode mapping
imap <key> <Esc>yyp
" Visual mode mapping
xmap <key> y<Esc>p

" With the three mappings above, the commands used in the RHS
" are executed with their current meaning. If the meaning of one
" of those commands is already changed with a mapping somewhere,
" your mapping may not do what you expect it to do.
" It is generally preferred to use this form:
nnoremap <key> yyp
inoremap <key> <Esc>yyp
xnoremap <key> y<Esc>p
" unless you actually want recursion.

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

" In Vim, variables can be scoped by prepending a single letter
" and a colon to their name. Plugin authors use that feature to
" mimic options:
let g:plugin_variable = 1

" Read up on the subject in ':help internal-variables'.

" COMMANDS

" * Don't forget the bang to allow Vim to overwrite that
"   command the next time you reload your vimrc.
" * Custom commands must start with an uppercase.
" * See ':help user-commands'.
command! MyCommand call SomeFunction()
command! MyOtherCommand command | Command | command

" FUNCTIONS

" * Don't forget the bang to allow Vim to overwrite that 
"   function the next time you reload your vimrc.
" * Custom functions must start with an uppercase.
" * See ':help user-functions'.
function! MyFunction(foo, bar)
  return a:foo . a:bar
endfunction

" AUTOCOMMANDS

" * Autocommand groups are good for organization but they can be useful
"   for debugging too. Think of them as small namespaces that you
"   can enable/disable at will.
" * See ':help autocommand'.
augroup MyGroup
  " Clear the autocmds of the current group
  " to prevent them from piling up each time
  " you reload your vimrc.
  autocmd!

  " These autocmds are fired after the filetype of a buffer
  " is defined to 'foo'. Don't forget to use 'setlocal' (for options)
  " and '<buffer>' (for mappings) to prevent your settings to
  " leak in other buffers with a different filetype.
  autocmd FileType foo setlocal bar=baz
  autocmd FileType foo nnoremap <buffer> <key> :command<CR>

  " This autocmd calls 'MyFunction()' everytime Vim tries to create/edit
  " a buffer tied to a file in /'path/to/project/**/'.
  autocmd BufNew,BufEnter /path/to/project/**/* call MyFunction()
augroup END

" CONDITIONALS

if v:version >= 704
    " do something if Vim is the right version
endif

if has('patch666')
    " do something if Vim has the right patch-level
    " see ':help has-patch'
endif

if has('feature')
  " do something if Vim is built with 'feature'
  " see ':help feature-list'
endif

" SUGGESTED MINIMAL SETTINGS FOR PROGRAMMING

" filetype support and syntax highlighting
filetype plugin indent on
syntax on

" built-in 'matchit.vim'
" hit '%' on 'if' to jump to 'else'â€¦
runtime macros/matchit.vim

" various settings
set autoindent                 " automatic indenting for buffers not associated with a filetype
set backspace=indent,eol,start " proper backspace behavior
set hidden                     " possibility to have more than one unsaved buffers
set incsearch                  " incremental search, hit '<CR>' to stop
set ruler                      " shows the current line number at the bottom right
set wildmenu                   " great command-line completion, use '<Tab>' to move around and `<CR>` to validate
