" -- PRELIMINARIES {{{1

" This isn't Vi, sucka! So no need to pretend.
set nocompatible

"share the system clipboard aka the system register aka * (you know: yank and
"paste from and to other apps)
set clipboard=unnamed

" various functions are stored in a separate file. too much hassle to do the
" same with guifunctions
source ~/.vim/vimrc/myfuncs.vim

"" Pathogen is a great way to manage plugins, but sometimes I need 
"" temporarily disable a plugin, which I do below.
" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []
"example syntax:
"call add(g:pathogen_disabled, 'supertab')
call add(g:pathogen_disabled, 'nerdtree')
call add(g:pathogen_disabled, 'vimwiki')
call add(g:pathogen_disabled, 'delimitmate')

"using pathogen to manage plugins... waaay easier than doing it manually
"[http://www.vim.org/scripts/script.php?script_id=23321] these functions read
"all plugins and update tags (help) files. The latter can be a tiny bit slow, so I 
"usually just run it from the command line with :Helptags
call pathogen#infect() 
"call pathogen#helptags()

"" Vim will have the memory of an *elephant* I tell you!

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

"highlight those search terms. why not?
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
set undodir=$HOME/tmp/vimtmp/undofiles

"make backup files in this directory (so they're not all over)
set backupdir=$HOME/tmp/vimtmp/backupfiles

"save swap files to a specific directory (less mess!)
set directory=$HOME/tmp/vimtmp/swapfiles

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
set shiftwidth=4
set expandtab

" when in front of a line, insert based on shiftwidth
set smarttab

" }}}

" -- APPEARANCE {{{1

" look at all the pretty colors
syntax enable

"set statusline=%<%f%m\ \[%{&ff}:%Y]\ %{getcwd()}\ \ \[%{strftime('%Y/%b/%d\ %a\ %I:%M\ %p')}\]\ \ [%{'t:'.tabpagenr()}\/%{tabpagenr('$')}]\ %=\ Line:%l\/%L\ Column:%c%V\ %P

"I don't care what "they" say, dark backgrounds are easier on the screen eyes
set background=dark
colorscheme badwolf

"a subtle highlight for current line
":hi CursorLine   cterm=NONE ctermbg=NONE ctermfg=white Guibg=gray13 guifg=NONE
":hi CursorLine   cterm=NONE ctermbg=NONE ctermfg=white Guibg=gray13 guifg=NONE

" turn that cursor up to 11!
":set cursorline


" -- EDITING {{{1

"re-read files that have changed by forces outside of Vim
set autoread

"allow cursor to move one character beyond end of line
set virtualedit=onemore

"keep cursor eight lines from top and bottom as it scrolls
set scrolloff=8

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
au BufNewFile,BufRead *.md,*.mtxt setlocal filetype=pandoc 
au BufNewFile,BufRead *.md,*.mtxt setlocal equalprg=pandoc\ -t\ markdown\ --no-wrap
"au BufNewFile,BufRead *.md :Voom markdown

" http://vim.wikia.com/wiki/Vim_as_XML_Editor
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
au FileType xml normal zR

"  }}}

" -- GENERAL KEYBOARD SHORTCUTS, REMAPS & ABBREVS {{{1

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

"arrow keys move between windows
"nnoremap <C-J> <C-W>j
"nnoremap <C-K> <C-W>k
"nnoremap <C-H> <C-W>h
"nnoremap <C-L> <C-W>l

"disable use of the mouse...I don't need no steenkin mouse
set mouse=
 
"use a better key for leader commands (the ones that play 'Follow the Leader')
let mapleader = ","
let maplocalleader = ","

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

" toggle between paste and normal mode
nmap <leader>P <ESC>:call TogglePaste()<CR>
imap <leader>P <ESC>:call TogglePaste()<CR>

" show word count of current buffer 
noremap <leader>wc :echo WordCount()<CR>

" turn the annoying search highlighting off when I'm done
nnoremap <leader><space> :noh<cr>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Add an empty line above or below current position
nmap <leader>O m`O<ESC>``
nmap <leader>o m`o<ESC>``

" re-select whatever I just pasted
nnoremap gp V`]

" If Vim is compiled with relative numbering, use F9
" to switch between relative, none, and standard numbering
if exists('+relativenumber')
 nnoremap <expr> <F9> CycleLNum()
 xnoremap <expr> <F9> CycleLNum()
 onoremap <expr> <F9> CycleLNum()
endif

nmap <silent> <leader>sp :set spell!<CR>
" }}}

" -- MARKDOWN / PANDOC WORK {{{1

"(pre)view current file in Brett Terpstra's awesome Marked markdown viewer see
"http://markedapp.com/
nnoremap <leader>m :silent !open -a Marked.app '%:p'<CR>

" View current Pandoc file in Safari (which is smart enough to reuse tabs)
nnoremap <silent><leader>mv :silent !pandoc -f markdown -t html -s -o /tmp/%:r.html %:r.md && sleep .5 && open -a /Applications/Safari.app/Contents/MacOS/Safari /tmp/%:r.html<CR>

"Open current markdown document as PDF in Preview
nnoremap <silent><leader>mp :silent !pandoc -f markdown -o /tmp/%:r.pdf %:r.md && open -a /Applications/Adobe\ Acrobat\ X\ Pro/Adobe\ Acrobat\ Pro.app/ /tmp/%:r.pdf<CR>

"Open current markdown document as RTF in Word (blech)
nnoremap <silent><leader>mr :silent !pandoc -f markdown -t rtf -s -o /tmp/%:r.rtf %:r.md \| open -a /Applications/Microsoft\ Office\ 2011/Microsoft\ Word.app/Contents/MacOS/Microsoft\ Word /tmp/%:r.rtf<CR>

" vim-pandoc (https://github.com/vim-pandoc/vim-pandoc) kills. Not literally.
" But it is unbearably slow unless I turn off the conditional link highlighting
let g:pandoc_no_empty_implicits = 1

" add ability to complete citations from matches in all fields, not just key
let g:pandoc_use_bibtool = 1

" just use Tab key for completion. Thank you Supertab [https://github.com/ervandew/supertab]
let g:SuperTabDefaultCompletionType = "context"

" }}}

" -- FILE OPERATIONS {{{1

" Always change to the directory of the current file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

au BufEnter * lcd %:p:h

"write the current file, no questions asked
nnoremap <leader>w :w!<cr>

"write and quit the current file, no questions asked
nnoremap <leader>Q :silent! wallq<cr>

"write current file and quit, no questions asked
nnoremap <leader>q :wq!<cr>

"shortcuts to some common files'
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>es :tabe ~/scratch.md<cr>
nnoremap <leader>eb :tabe ~/.bashrc<cr>

"And source it, baby, source it!
nnoremap <leader>sv :so $MYVIMRC<CR>



" :TOhtml configuration
let html_use_css = 1
let use_xhtml = 1
let html_ignore_folding = 1

" }}}

" -- VIM-LATEX {{{1
" grep will always generate a file-name otherwise bad grep confuses vim-latex
set grepprg=grep\ -nH\ $*

" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" LaTeX looks good with some indentation. Or so "they" say
set sw=2

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:
let Tlist_Ctags_Cmd="/usr/local/bin/ctags"
let tlist_tex_settings   = 'latex;s:sections;g:graphics;l:labels'
let tlist_make_settings  = 'make;m:makros;t:targets'

"}}}

" -- USER FUNCTIONS ----- {{{1
" moved to myfuncs.vim
" }}}

" -- PLUGINS AND PLUGIN SETTINGS {{{1

"" -- SnipMate {{{2
let g:snips_author='Chris Lott'
" }}}

"" -- EasyMotion {{{2
" EasyMotion will let you get around faster than the prom queen did the
" football team 
"let g:EasyMotion_mapping_f = 'f'
"let g:EasyMotion_mapping_F = 'F'
let g:EasyMotion_mapping_f = '<Leader><Leader>f'
let g:EasyMotion_mapping_F = '<Leader><Leader>F'
let g:EasyMotion_mapping_w = '<Leader><Leader>fw'
let g:EasyMotion_mapping_b = '<Leader><Leader>Fb'
let g:EasyMotion_mapping_e = '<Leader><Leader>fe'
let g:EasyMotion_mapping_ge = '<Leader><Leader>Fe'
let g:EasyMotion_mapping_j = '<Leader><Leader>fj'
let g:EasyMotion_mapping_k = '<Leader><Leader>fk'
let g:EasyMotion_mapping_n = '<Leader><Leader>fn'
let g:EasyMotion_mapping_N = '<Leader><Leader>fp'
" }}}

"" -- CtrlP {{{2
" CtrlP [https://github.com/kien/ctrlp.vim] seems to be the best buffer
" switching, file finding, most-recently used selecting utility around.
nnoremap <leader>pf :CtrlP<CR>
nnoremap <leader>pb :CtrlPBuffer<CR>
nnoremap <leader>pr :CtrlPMRUFiles<CR>
nnoremap <leader>pm :CtrlPBookmarkDir<CR>

let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.vim/.ctrlpcache/ctrlp'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_open_new_file = 't'
let g:ctrlp_arg_map = 1
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_show_hidden = 1
" }}}

"" -- Voom {{{2
" Va-va-Voom, the tree outliner folder with panache [http://vim-voom.github.com/]
let g:voom_tree_width=35
" make sure voomclose kills the outline
com! Voomclose call Voom_DeleteOutline('')
nnoremap <leader>vo :Voom<CR>
nnoremap <leader>vd :Voom markdown<CR>
nnoremap <leader>vt :VoomToggle<CR>
"nnoremap <leader>vdt :VoomToggle markdown<CR>
"}}}

"" -- NERDTree {{{2
" NERDTree filesystem explorer for browsing directories...you feel me?
" [https://github.com/scrooloose/nerdtree]
let NERDTreeBookmarksFile=$HOME.'/.vim/.NERDTreeBookmarks'
let NERDTreeDirArrows=1
let NERDTreeShowBookmarks=1
let NERDChristmasTree=1
let NERDTreeHighlightCursorline=1
let NERDTreeWinSize=31
map <leader>no :NERDTree<space>
map <leader>nd :NERDTreeCWD<cr>
map <leader>nb :NERDTreeFromBookmark<space>
map <leader>nt :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>nf :NERDTreeFind<CR>
" }}}

"" -- Gundo {{{2
" Gundo: visualize your undo tree. It's like back to the future!
" [http://sjl.bitbucket.org/gundo.vim/]
let g:gundo_width=22
let g:gundo_preview_bottom=1
nnoremap <leader>u :GundoToggle<CR>
" }}}

"" -- Scratch {{{2
" Scratch provides an Emacs like scratch buffer
" https://github.com/kana/vim-scratch
map <Leader>so :ScratchOpen<cr>
map <Leader>sc :ScratchClose<cr>
" }}}

"" -- Powerline {{{2
" Powerline makes your modeline magical
" https://github.com/Lokaltog/vim-powerline
"
" Fancy it up (need a Powerline patched font)
" https://github.com/Lokaltog/vim-powerline/wiki/Patched-fonts
let g:Powerline_symbols = 'fancy'

" Add Tab Warning Segment
call Pl#Theme#InsertSegment(['raw', '%{TabWarning()}'], 'after', 'fileinfo')

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:tab_warning
" }}}

" }}}

" -- VIMWIKI EVAL {{{1

" let g:vimwiki_list = [{'path': '~/db/prod/vimwiki/'}]

"  }}}
" -- TESTING, PENDING DELETION, UNCATEGORIZED {{{1

let g:smartput = 0

" Convert curly quotes to straight.
" Any argument causes substitute to confirm changes.
function! ToStraight(line1, line2, args)
  let flags = 'eg'
  let range = a:line1 . ',' . a:line2
  if empty(a:args)
    let range = 'silent ' . range
  else
    let flags .= 'c'
  endif
  let search = @/
  exe range . "s/[‘’]/'/" . flags

  exe range . 's/[“”]/"/' . flags
  nohl
  let @/ = search
endfunction
command! -nargs=? -range ToStraight call ToStraight(<line1>, <line2>, '<args>') 

"Usage
  ":%ToStraight    " convert all
  ":ToStraight     " convert current line only
  ":%ToStraight c  " convert all and confirm each 

" I want candy!
"if has('gui_running')
"else
  "color candycode-term
"endif
" a nice bright green cursor. Just like the olden days.
":highlight Cursor ctermfg=NONE ctermbg=NONE guifg=black guibg=LawnGreen
":highlight Cursor ctermfg=NONE ctermbg=NONE guifg=black guibg=LawnGreen

au BufReadCmd   *.epub      call zip#Browse(expand("<amatch>"))

let dnfile = strftime("%Y") . ".md"
let dncm = 'edit '.dnfile
" nmap <leader>dn :execute 'edit!' fnameescape(dnfile)
"nnoremap <leader>dn execute dncm
nnoremap <leader>dn :execute 'e '.fnameescape(dnfile)<cr>

function! WW()
  :set showtabline=0
  :set noshowmode
  :set laststatus=0
  :set noruler
  :set noshowcmd
  :call VimWriteRoom()
endfunction

nnoremap WW :call WW()<CR>

set showtabline=2
au BufNewFile,BufEnter,BufRead pentadactyl.txt setlocal filetype=pandoc 
au BufNewFile,BufEnter,BufRead pentadactyl.txt setlocal equalprg=pandoc\ -t\ markdown\ --no-wrap

nmap <leader>tor :%! formd -r<CR>
nmap <leader>toi :%! formd -i<CR>

nnoremap <CR> :noh<CR>
" }}}
