"""""""""""""""""""""
"""""""""""""""""""""
"" IDIOMATIC VIMRC ""
"""""""""""""""""""""
"""""""""""""""""""""

" * Using short names has *only* cons and *zero* pros. Don't.
" * Always refer to the relevant ':help' page before adding anything to your vimrc.
" * You don't need 'set nocompatible' if you have a vimrc:
"     UNIX & Co.:   $HOME/.vimrc (in 7.4, use $HOME/.vim/vimrc)
"     Windows   :   $HOME\_vimrc (in 7.4, use $HOME\vimfiles\vimrc)
" * 'set background=dark' doesn't do what you think it does.
" * 'set t_Co=256' is pointless, set your terminal emulator up correctly instead.
" * If you have a lot of autocmds for a lot of filetype-specific settings,
"   consider moving those setting to proper ftplugins.
" * If you have a lot of custom functions, consider moving them
"   to '~/.vim/autoload/'. See ':help autoload'.

"""""""""""
" OPTIONS "
"""""""""""

" * Use ':set option?' to check the value of an option.
" * Use ':verbose set option?' to also see where it was last set.
" * See ':help options'.

" Binary options
set binoption       " Set binoption
set nobinoption     " Unset binoption

set binoption!      " Toggle binoption

set binoption&      " Reset binoption to its default value

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

"""""""""""""
" VARIABLES "
"""""""""""""

" Plugins use global variables as options. Note the spacing
" around the equal sign:
let g:my_plugin_variable = 'baz'

""""""""""""
" MAPPINGS "
""""""""""""

" * Don't put comments after mappings.
" * Use ':map <key>' to see what's mapped to '<key>' and in which mode.
" * Use ':verbose map <key>' to also see where it was last mapped.
" * See ':help mapping' and ':help key-notation'.

" Normal mode
nmap <key> something
" Insert mode
imap <key> something
" Visual mode
xmap <key> something

" Recursive mappings vs non-recursive mappings
" ============================================
" The three recursive mappings above will do 'something', whatever it
" currently means. If 'something' hasn't been remapped by you
" or some plugin, your mapping will work as intended but, if its meaning
" was changed you'll get the new meaning which may or may not do unexpected
" things. Non-recursive mappings, on the other hand, always use the original
" meaning of the commands you use in your mappings.
" Rule of thumbs:
" * If you use another mapping (custom or third-party) in your
"   mapping, go with a recursive mapping like the ones above.
" * If you use a built-in command in your mapping, go with
"   a non-recursive mapping:
nnoremap <key> something
inoremap <key> something
xnoremap <key> something

" Executing a command from a mapping
nnoremap <key> :MyCommand<CR>

" Executing multiple commands from a mapping
nnoremap <key> :MyCommand <bar> MyOtherCommand <bar> SomeCommand<CR>

" Calling a function from a mapping
nnoremap <key> :call SomeFunction()<CR>

""""""""""""
" COMMANDS "
""""""""""""

" * Custom commands must start with an uppercase.
" * See ':help user-commands'.

" * Defining a command that calls a function.
" * Don't forget the bang to allow Vim to overwrite that command
"   the next time you reload your vimrc.
command! MyCommand call SomeFunction()

" * Defining a command that calls other commands.
" * Don't forget the bang to allow Vim to overwrite that command
"   the next time you reload your vimrc.
command! MyCommand SomeCommand | SomeOtherCommand

"""""""""""""
" FUNCTIONS "
"""""""""""""

" * Custom functions must start with an uppercase.
" * See ':help user-functions'.

" * Defining a function.
" * Don't forget the bang to allow Vim to overwrite that command
"   the next time you reload your vimrc.
function! MyFunction(foo, bar)
  return a:foo . a:bar
endfunction

""""""""""""""""
" AUTOCOMMANDS "
""""""""""""""""

" * Autocommands are a handy way to automize the setting
"   of options or the execution of commands upon specific events
"   like opening a file or entering insert mode but they
"   tend to pile up and lead to performance issues over time.
"   So we create a named `augroup` that automatically clears
"   itself each time it is sourced.
" * See ':help autocommand'.
augroup MyGroup

  " Clear the autocommands of the current group
  " to prevent them from piling up each time
  " you reload your vimrc.
  autocmd!

  " These autocommands are fired after the filetype of a buffer
  " is defined. Don't forget to use setlocal (for options)
  " and <buffer> (for mappings) to prevent your settings to
  " 'leak' in other buffers with a different filetype.
  autocmd FileType foo setlocal foo bar=baz
  autocmd FileType foo nnoremap <buffer> <key> :command<CR>

  " This autocommand calls MyFunction() everytime Vim tries to create/edit
  " a buffer tied to a file in /path/to/project/**/.
  autocmd BufNew,BufEnter /path/to/project/**/* call MyFunction()

augroup END

""""""""""""""""
" CONDITIONALS "
""""""""""""""""

if has('feature')
  " do something if Vim is built with 'feature'
  " see ':help feature-list'
endif

if v:version >= 704
    " do something if Vim is the right version
    " '704' is '7.4', '600' is '6.0'
endif

if has('patch666')
    " do something if Vim has the right patch-level
    " see ':help has-patch'
endif

""""""""""""""""""""""""""""
" SYSTEM-SPECIFIC SETTINGS "
""""""""""""""""""""""""""""

if has('win32') || has('win16')
    " do something if we are on Windows
else
    let OS = substitute(system('uname'), '\n', '', '')
    if OS == 'Darwin'
        " do something if we are on Mac OS X
    elseif OS == 'Linux'
        " do something if we are on Linux
    endif
endif
