" -- PRELIMINARIES {{{1

" This isn't Vi, sucka! So no need to pretend.
set nocompatible

"share the system clipboard aka the system register aka * (you know: yank and
"paste from and to other apps)
set clipboard=unnamed
set history=20

" Set line-ending types
set fileformats=unix,mac,dos

"" Pathogen is a great way to manage plugins, but sometimes I need
"" temporarily disable a plugin, which I do below.
" To disable a plugin, add it's bundle name to the following list. eg
" call add(g:pathogen_disabled, 'abolish')
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'easymotion')
"call add(g:pathogen_disabled, 'vim-pandoc-after')
"call add(g:pathogen_disabled, 'vim-pantondoc')
call add(g:pathogen_disabled, 'snipmate')

"using pathogen to manage plugins... waaay easier than doing it manually
"[http://www.vim.org/scripts/script.php?script_id=23321] these functions read
"all plugins and update tags (help) files. The latter can be a tiny bit slow, so I
"usually just run it from the command line with :Helptags
call pathogen#infect()
call pathogen#helptags()

"keep a lot of history... good for leaky memories like the one in my head
set history=1000

" Remember: <500 lines max in each register % restore buffer list '2000 marks
" from previously edited files /500 max number of items in search pattern
" history :500 max number of command-line history items @500 max number of
" items in input-line history f1 store all file marks n store all this info in
" ~/.viminfo file
set viminfo=<500,%,'2000,/500,"500,@500,f1,n~/.viminfo

"don't unload abandoned buffers, but hoard them for further use
set hidden

"and auto save them buffers when I leave them
au BufLeave,FocusLost * silent! :wall

"automatically update a file if something changes it from outside vim
set autoread

" highlight search terms
set hlsearch

"and highlight incrementally as you search
set incsearch

"but ignore case in those searchs
set ignorecase

"unless the search term(s) include a capital letter!
set smartcase

" Wrap search when EOF is reached
set wrapscan

"I'm not using Vim in a terminal over a dial-up modem, so... turn on the
"afterburners
set ttyfast

"We all make mistakes
set undofile

"but I don't want undofiles all over the place
set undodir=$HOME/tmp/vim

"make backup files in this directory (so they're not all over)
set backupdir=$HOME/tmp/vim

"save swap files to a specific directory (less mess!)
set directory=$HOME/tmp/vim

"vim can be weird... I'm still getting backups, but only when I close a file
set nowritebackup

"show possible completions in the command line (press TAB)
set wildmenu

"when completing, list all matches and complete until longest common
"i.e. complete only to the point where further completion is ambiguous
set wildmode=list:longest

"copy indentation when starting a new line
set autoindent

"smarter indentation, mostly for coding and {} etc
set smartindent

"allow wrapping only with cursor keys
set whichwrap+=<,>,h,l,[,]

" tabs (the old, spacy kind)
" I want 'tabs' to be 4 spaces and the tab key inserts said spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" when in front of a line, insert based on shiftwidth
set smarttab

" }}}

" -- APPEARANCE {{{1

" look at all the pretty colors
syntax enable

" turn that cursor up to 11!
set cursorline


" -- EDITING {{{1

"re-read files that have changed by forces outside of Vim
set autoread

"allow cursor to move one character beyond end of line
set virtualedit=onemore

"keep cursor eight lines from top and bottom as it scrolls
set scrolloff=12

"show line numbers... this is useful even with prose. Seriously. Would I lie?
set nu

"shorten messages so I don't get the whole yes/no/esc/etc business so often
"and hide or shorten various vim messages
set shortmess=atTI

"show three lines in the command line so I don't get 'press enter' msgs so
"much set cmdheight=1 for screen recording
set cmdheight=3

"disable all bells
set t_vb=
set noerrorbells
set visualbell

"display comments in lower-right corner
set showcmd

"show which mode I'm currently in down in the status line. Because I do forget
set showmode

"show position in file
set ruler

"and always show that awesome status line
set laststatus=2

"allow backspace over indentation, end of line, and to start of insert
set backspace=indent,eol,start

"keep 10 lines above and below cursor when possible
set scrolloff=10

"open folds when I need them for searching, etc
set foldopen = "block,hor,mark,percent,quickfix,search,tag,undo"
set foldopen&

" I generally use Voom to manage folds
set nofoldenable

" }}}

" -- FILETYPE STUFF {{{1

"load appropriate filetype plugins and their associated indenting

filetype plugin indent on

" if editing vimscript/vimrc, fold using {{{ }}}
augroup filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
augroup END

" if editing Pandoc/Markdown, set filetype, enable spell, reformat w/pandoc
au BufNewFile,BufRead *.md setlocal filetype=pandoc|setlocal equalprg=pandoc\ -t\ markdown\ --no-wrap|setlocal shiftwidth=4|set spell

" http://vim.wikia.com/wiki/Vim_as_XML_Editor
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
au FileType xml normal zR

"Open epub files to edit individual parts
au BufReadCmd   *.epub      call zip#Browse(expand("<amatch>"))

"  }}}

" -- GENERAL KEYBOARD REMAPS & ABBREVS {{{1
" mappings that aren't tired to specific plugins below

" move line by line with long lines
noremap j gj
noremap k gk

" arrow keys do nothing (no bad habits for me except beer donuts and bacon)
nnoremap <Up> <Esc>
vnoremap <Up> <NOP>
inoremap <Up> <NOP>
nnoremap <Down> <Esc>
vnoremap <Down> <NOP>
inoremap <Down> <NOP>
nnoremap <Left> <Esc>
vnoremap <Left> <NOP>
inoremap <Left> <NOP>
nnoremap <Right> <Esc>
vnoremap <Right> <NOP>
inoremap <Right> <NOP>

"disable use of the mouse...I don't need no steenkin mouse
set mouse=

"use a better key for leader commands (the ones that play 'Follow the Leader')
let mapleader = ","
let maplocalleader = ","

" Automatically set a mark 'z' when searching to easily return
" to location where I started searching with `z
nnoremap / mz/
nnoremap ? mz?

" delete without placing into register/clipboard
nnoremap <Leader>x "_d

"use jk to exit insert mode...no more reaching up for ESC key
"thanks Steve Losh http://learnvimscriptthehardway.stevelosh.com/chapters/10.html
inoremap jk <ESC>

"make top and bottom commands go to actual beginning and end of file
noremap gg gg^
noremap G G$

" press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" show word count of current buffer
noremap <leader>wc :echo WordCount()<CR>

" turn the annoying search highlighting off when I'm done
nnoremap <leader><space> :noh<cr>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

nmap <silent> <leader>sp :set spell!<CR>

" }}}

" -- MARKDOWN / PANDOC WORK {{{1

" vim-pantondoc (https://github.com/vim-pandoc/vim-pandoc)

"Use Pandoc mode for Markdown files
let g:pantondoc_use_pandoc_markdown = 1

" just use Tab key for completion. Thank you Supertab [https://github.com/ervandew/supertab]
let g:SuperTabDefaultCompletionType = "context"

" }}}

" -- FILE OPERATIONS {{{1

" Change directory to the current buffer when opening/entering files/buffers
set autochdir

"write the current file, no questions asked
nnoremap <leader>w :w!<cr>

"write and quit the current file, no questions asked
nnoremap <leader>Q :silent! wallq<cr>

"write current file and quit, no questions asked
nnoremap <leader>q :wq!<cr>

"shortcuts to some common files'
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>es :tabe ~/db/tmp/scratch.md<cr>
nnoremap <leader>es2 :tabe ~/db/tmp/scratch2.md<cr>
nnoremap <leader>es3 :tabe ~/db/tmp/scratch3.md<cr>
nnoremap <leader>eb :tabe ~/.bashrc<cr>

" :TOhtml configuration
let html_use_css = 1
let use_xhtml = 1
let html_ignore_folding = 1

" }}}

" -- PLUGINS AND PLUGIN SETTINGS {{{1

"" -- SnipMate {{{2
let g:snips_author='Chris Lott'
" }}}

"" -- Abolish {{{2
" Abolish provides a simple way to handle substitutions, including variants
" and complex abbrevs. https://github.com/tpope/vim-abolish

" Fix so-called smart quotes and typographic symbols
map ,sq :%Subvert/{“,”,‘,’,–,—,…}/{\",\",',',--,---,...}/g<CR>
"" }}}

"" -- CtrlP {{{2
" CtrlP [https://github.com/kien/ctrlp.vim] seems to be the best buffer
" switching, file finding, most-recently used selecting utility around.
nnoremap <leader>pp :CtrlP<CR>
nnoremap <leader>pa :CtrlPMixed<CR>
nnoremap <leader>pb :CtrlPBuffer<CR>
nnoremap <leader>pr :CtrlPMRUFiles<CR>
nnoremap <leader>pm :CtrlPBookmarkDir<CR>

let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.vim/.ctrlpcache/ctrlp'
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_open_new_file = 't'
let g:ctrlp_arg_map = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:10,results:10'
" }}}

"" -- Voom {{{2
" Va-va-Voom, the tree outliner folder with panache [http://vim-voom.github.com/]
let g:voom_tree_width=35
" make sure voomclose kills the outline
com! Voomclose call Voom_DeleteOutline('')
nnoremap <leader><leader>vo :Voom<CR>
nnoremap <leader><leader>vd :Voom markdown<CR>
nnoremap <leader><leader>vt :VoomToggle<CR>
"}}}

"" -- Gundo {{{2
" Gundo: visualize your undo tree. It's like back to the future!
" [http://sjl.bitbucket.org/gundo.vim/]
let g:gundo_width=22
let g:gundo_preview_bottom=1
nnoremap <leader>u :GundoToggle<CR>
"}}}

"" -- Vimwiki {{{2
let g:vimwiki_list = [{'path': '~/db/vimwiki/', 'path_html': '~/db/Apps/site44/vimwiki.site44.com/'}]
"}}}

"" -- Airline {{{2
" Airline is a lighter replacement for powerline (customize the status line)
" https://github.com/bling/vim-airline
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n' : 'N',
      \ 'i' : 'I',
      \ 'R' : 'R',
      \ 'c' : 'C',
      \ 'v' : 'V',
      \ 'V' : 'V',
      \ '' : 'V',
      \ 's' : 'S',
      \ 'S' : 'S',
      \ '' : 'S',
      \ }
let g:airline_theme = 'powerlineish'
let g:airline_section_b = '%{getcwd()}'
let g:airline_section_c = '%t'

" }}}

"" -- Spacehi {{{2
" Spacehi provides a toggle for showing and hiding trailing whitespace
" Whitespace can something in Markdown, so I don't want it all the time
" https://github.com/vim-scripts/spacehi.vim

map <silent> <leader>tws :ToggleSpaceHi<CR>

" }}}

"" -- LanguageTool {{{2
" LanguageTool provides grammar checking

let g:languagetool_jar='/Users/chris/db/appsupport/unix/languagetool/LanguageTool.jar'

" }}}

" -- FUNCTIONS {{{1

" Determine which platform Vim is running on
function! GetRunningOS()
  if has("win32")
    return "win"
  endif
  if has("unix")
    if system('uname')=~'Darwin'
      return "mac"
    else
      return "linux"
    endif
  endif
endfunction
let os=GetRunningOS()


"" close all buffers (with save)
function! Xall()
        for t in range(1, tabpagenr('$'))
                for b in tabpagebuflist(t)
                        if bufloaded(b)
                        \ && bufname(b) == ""
                        \ && getbufvar(b, '&mod')
                                exe 'bw!' b
                        endif
                endfor
        endfor
        xall
endfunc

command! Xall call Xall()


" function to search for word under cursor
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" BufOnly.vim  -  Delete all the buffers except the current/named buffer.
" Copyright November 2003 by Christian J. Robinson <heptite@gmail.com>
" Distributed under the terms of the Vim license.  See ":help license".
"
" Usage:
" :Bonly / :BOnly / :Bufonly / :BufOnly [buffer]
" Without any arguments the current buffer is kept.  With an argument the
" buffer name/number supplied is kept.

command! -nargs=? -complete=buffer -bang Bonly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BOnly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang Bufonly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BufOnly
    \ :call BufOnly('<args>', '<bang>')

function! BufOnly(buffer, bang)
    if a:buffer == ''
        " No buffer provided, use the current buffer.
        let buffer = bufnr('%')
    elseif (a:buffer + 0) > 0
        " A buffer number was provided.
        let buffer = bufnr(a:buffer + 0)
    else
        " A buffer name was provided.
        let buffer = bufnr(a:buffer)
    endif

    if buffer == -1
        echohl ErrorMsg
        echomsg "No matching buffer for" a:buffer
        echohl None
        return
    endif

    let last_buffer = bufnr('$')

    let delete_count = 0
    let n = 1
    while n <= last_buffer
        if n != buffer && buflisted(n)
            if a:bang == '' && getbufvar(n, '&modified')
                echohl ErrorMsg
                echomsg 'No write since last change for buffer'
                            \ n '(add ! to override)'
                echohl None
            else
                silent exe 'bdel' . a:bang . ' ' . n
                if ! buflisted(n)
                    let delete_count = delete_count+1
                endif
            endif
        endif
        let n = n+1
    endwhile

    if delete_count == 1
        echomsg delete_count "buffer deleted"
    elseif delete_count > 1
        echomsg delete_count "buffers deleted"
    endif

endfunction

"  }}}


" -- REMOVED BUT REMEMBERED. RIP. {{{1

" This doesn't work with airline plugin and I haven't had time
" to figure it out.
" show a word count for the current buffer
"function! WordCount()
  "let s:old_status = v:statusmsg
  "exe "silent normal g\<c-g>"
  "let s:word_count = str2nr(split(v:statusmsg)[11])
  "let v:statusmsg = s:old_status
  "return s:word_count
"endfunction

" }}}

" -- TESTING, PENDING DELETION, UNCATEGORIZED {{{1

nnoremap <space> zz
nnoremap <CR> :nohlsearch<CR>

set hls is " enable search highlighting while typing
set ic scs inf wic " ignore case, except when uppercase is used

let g:syntastic_html_checkers = ['tidy']
let g:syntastic_html_tidy_ignore_errors = [ '<div> anchor "content" already defined' ]
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore="E501"'

"let g:sneak#streak = 1

"nmap f <Plug>Sneak_s
"nmap F <Plug>Sneak_S
"xmap f <Plug>Sneak_s
"xmap F <Plug>Sneak_S
"omap f <Plug>Sneak_s
"omap F <Plug>Sneak_S


" Manually change to directory of current file
"nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Use [formd](http://drbunsen.github.io/formd/) to convert
" markdown links to and from reference and inline styles
nmap <leader>tor :%! /usr/local/bin/formd/formd -r<CR>
nmap <leader>toi :%! /usr/local/bin/formd/formd -i<CR>

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1

" Default to tree mode
"let g:netrw_liststyle=3

au BufEnter *.md let g:airline#extensions#whitespace#checks = [ 'indent' ]
au BufLeave *.md let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing']
" }}}

" -- OS X SPECIFIC {{{1

if os == "mac"
    "(pre)view current (markdown) file in Brett Terpstra's awesome Marked markdown viewer see
    "http://markedapp.com/
    nnoremap <leader>md :write<CR><bar>:silent !open -a Marked.app '%:p'<CR>

    " View current file as HTML in Safari (because it reuses tabs)
    nnoremap <silent><leader>h :!open -a /Applications/Safari.app/Contents/MacOS/Safari '%:p'<CR>


    " View current (markdown) file (rendered) in Safari (which is smart enough to reuse tabs)
    nnoremap <silent><leader>mv :silent !pandoc -f markdown -t html -s -o /tmp/%:r.html %:r.md && sleep .5 && open -a /Applications/Safari.app/Contents/MacOS/Safari /tmp/%:r.html<CR>

    "Open current (markdown) document as PDF in Preview
    nnoremap <silent><leader>mp :silent !pandoc -f markdown -o /tmp/%:r.pdf %:r.md && open -a /Applications/Adobe\ Acrobat\ X\ Pro/Adobe\ Acrobat\ Pro.app/ /tmp/%:r.pdf<CR>

    "Open current (markdown) document as RTF in Word (blech)
    nnoremap <silent><leader>mr :silent !pandoc -f markdown -t rtf -s -o /tmp/%:r.rtf %:r.md \| open -a /Applications/Microsoft\ Office\ 2011/Microsoft\ Word.app/Contents/MacOS/Microsoft\ Word /tmp/%:r.rtf<CR>
endif

" }}}

" -- LINUX SPECIFIC {{{1

if os == "linux"
    set background=dark
endif

" }}}

" 11/3/13 - 10:29a

