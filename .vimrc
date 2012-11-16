" ----- PRELIMINARIES ----- {{{

" This isn't Vi, sucka! So no need to pretend.
set nocompatible

"share the system clipboard aka the system register aka * (you know: yank and
"paste from and to other apps)
set clipboard=unnamed

"" Pathogen is a great way to manage plugins, but sometimes I need 
"" temporarily disable a plugin, which I do below.
" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []
"example syntax:
"call add(g:pathogen_disabled, 'supertab')

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
set undodir=$HOME/.vim/.undofiles

"make backup files in this directory (so they're not all over)
set backupdir=$HOME/.vim/.backups

"save swap files to a specific directory (less mess!)
set directory=$HOME/.vim/.backups/swp

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

" ----- APPEARANCE ----- {{{

" look at all the pretty colors
syntax enable

set statusline=%<%f%m\ \[%{&ff}:%Y]\ %{getcwd()}\ \ \[%{strftime('%Y/%b/%d\ %a\ %I:%M\ %p')}\]\ \ [%{'t:'.tabpagenr()}\/%{tabpagenr('$')}]\ %=\ Line:%l\/%L\ Column:%c%V\ %P

"I don't care what "they" say, dark backgrounds are easier on the screen eyes
set background=dark

"a subtle highlight for current line
:hi CursorLine   cterm=NONE ctermbg=NONE ctermfg=white Guibg=gray13 guifg=NONE

"a nice bright green cursor. Just like the olden days.
:highlight Cursor cterm=NONE ctermbg=NONE guifg=black guibg=LawnGreen

"turn that cursor up to 11!
:set cursorline

" I want candy!
color candycode

"}}}

" ----- EDITING -----{{{

"allow cursor to move one character beyond end of line
set virtualedit=onemore

"keep cursor eight lines from top and bottom as it scrolls
set scrolloff=8

"show line numbers... this is useful even with prose. Seriously. Would I lie?
set nu

"shorten messages so I don't get the whole yes/no/esc/etc business so often
"and hide or shorten various vim messages
set shortmess=atTI

"make C-e and C-y scroll by 5 lines at a time rather than 1
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

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

"keep 10 lines above and below cursor when possiblde
set scrolloff=10

"open folds when I need them for searching, etc
set foldopen = "block,hor,mark,percent,quickfix,search,tag,undo"
set foldopen&

" }}}

" ----- FILETYPE STUFF {{{

"load appropriate filetype plugins and their associated indenting

filetype plugin indent on

augroup filetype_vim 
    au! 
    au FileType vim setlocal foldmethod=marker 
augroup END

au BufNewFile,BufRead *.md setlocal filetype=pandoc 
au BufNewFile,BufRead *.md setlocal spell 
au BufNewFile,BufRead *.md setlocal equalprg=pandoc\ -t\ markdown\ --no-wrap

" Use par for (re)formatting email messages
au BufNewFile,BufRead *.mail setlocal equalprg="/usr/local/bin/par -q+"

" http://vim.wikia.com/wiki/Vim_as_XML_Editor
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
au FileType xml normal zR

"  }}}

" ----- GENERAL KEYBOARD SHORTCUTS, REMAPS & ABBREVS ----- {{{   

" arrow keys do nothing in insert mode (no bad habits for me except beer,
" donuts and bacon
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

"disable use of the mouse... I'm trying to get the kbd under my fingertips
set mouse=
 
"use a better key for leader commands (the ones that play 'Follow the Leader')
let mapleader = ","
let maplocalleader = ","


"use jk to exit insert mode...no more reaching up for ESC key
"thanks Steve Losh http://learnvimscriptthehardway.stevelosh.com/chapters/10.html
inoremap jk <ESC>

"disable the ESC key to force my self to get the above "under my fingers"

"make top and bottom commands go to actual beginning and end of file
noremap gg gg^
noremap G G$

"" Trying to decide if it's good or bad to not get the real shortcuts 
"" under my fingers
"use Arrow keys to move between windows
nmap <Up> <C-W>k
nmap <Down> <C-W>j
nmap <Left> <C-W>h
nmap <Right> <C-W>l

" press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" toggle between paste and normal mode
nmap <C-\\> <ESC>:call TogglePaste()<CR>
imap <C-\\> <ESC>:call TogglePaste()<CR>

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

"" Trying to decide if I am really this lazy or not
" open new tab
"map <C-t><C-t> :tabnew<CR>

" close current tab
"map <C-t><C-w> :tabclose<CR>

" Add an empty line above or below current position
"nmap <leader>O m`O<ESC>``
"nmap <leader>o m`o<ESC>``

" re-select whatever I just pasted
nnoremap <leader>v V`]

 " }}}

" ----- MARKDOWN / PANDOC WORK ----- {{{

"(pre)view current file in Brett Terpstra's awesome Marked markdown viewer see
"http://markedapp.com/
nnoremap <leader>m :silent !open -a Marked.app '%:p'<CR>

" View current Pandoc file in Safari (which is smart enough to reuse tabs)
nnoremap <silent><leader>mv :silent !pandoc -f markdown -t html -s -o %:r.html %:r.md && sleep .5 && open -a /Applications/Safari.app/Contents/MacOS/Safari %:r.html<CR>

"Open current markdown document as PDF in Preview
nnoremap <silent><leader>mp :silent !pandoc -f markdown -o %:r.pdf %:r.md && open -a /Applications/Adobe\ Acrobat\ X\ Pro/Adobe\ Acrobat\ Pro.app/ %:r.pdf<CR>

"Open current markdown document as RTF in Word (blech)
nnoremap <silent><leader>mr :silent !pandoc -f markdown -t rtf -s -o %:r.rtf %:r.md \| open -a /Applications/Microsoft\ Office\ 2011/Microsoft\ Word.app/Contents/MacOS/Microsoft\ Word %:r.rtf<CR>

" vim-pandoc (https://github.com/vim-pandoc/vim-pandoc) kills. Not literally.
" But it is unbearably slow unless I turn off the conditional link highlighting
let g:pandoc_no_empty_implicits = 1

" add ability to complete citations from matches in all fields, not just key
let g:pandoc_use_bibtool = 1

" just use Tab key for completion. Thank you Supertab [https://github.com/ervandew/supertab]
let g:SuperTabDefaultCompletionType = "context"

" }}}

" ----- FILE OPERATIONS ----- {{{

" Always change to the directory of the current file
au BufEnter * lcd %:p:h

"write the current file, no questions asked
nnoremap <leader>w :w!<cr>

"write and quit the current file, no questions asked
nnoremap <leader>Q :silent! wallq<cr>

"write current file and quit, no questions asked
nnoremap <leader>q :wq!<cr>

"shortcuts to some common files'
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>esm :tabe ~/scratch.md<cr>

"And source it, baby, source it!
nnoremap <leader>sv :so $MYVIMRC<CR>

" :TOhtml configuration
let use_xhtml = 1
let html_use_css = 1
let html_ignore_folding = 1

" }}}

" ----- VIM-LATEX {{{
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

" ----- USER FUNCTIONS ----- {{{

" show a word count fo the current buffer
function! WordCount()
  let s:old_status = v:statusmsg
  exe "silent normal g\<c-g>"
  let s:word_count = str2nr(split(v:statusmsg)[11])
  let v:statusmsg = s:old_status
  return s:word_count
endfunction

" when pasting from the OS into the terminal, you should use 'paste mode' to
" prevent any mappings (such as 'jj' and the like from being run. This makes a
" simple toggle to turn it on and off
function! TogglePaste()
    if  &paste == 0
        set paste
        echo "Paste is ON!"
    else
        set nopaste
        echo "Paste is OFF!"
    endif
endfunction

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


" }}}

" ----- PLUGINS AND PLUGIN SETTINGS {{{

" EasyMotion will let you get around faster than the prom queen did the
" football team []
let g:EasyMotion_mapping_f = 'ff'
let g:EasyMotion_mapping_F = 'fF'
let g:EasyMotion_mapping_w = 'fw'
let g:EasyMotion_mapping_b = 'fb'
let g:EasyMotion_mapping_e = 'fe'
let g:EasyMotion_mapping_ge = 'fge'
let g:EasyMotion_mapping_j = 'fj'
let g:EasyMotion_mapping_k = 'fk'
let g:EasyMotion_mapping_n = 'fn'
let g:EasyMotion_mapping_N = 'fp'

" Sometimes you just need a scratch buffer you don't have to worry about to
" futz around in: [http://www.vim.org/scripts/script.php?script_id=664]
map <leader><tab> :Scratch<CR>

" CtrlP [https://github.com/kien/ctrlp.vim] seems to be the best buffer
" switching, file finding, most-recently used selecting utility around.
"nnoremap <leader>pf :CtrlP<CR>
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

" Va-va-Voom, the tree outliner folder with panache [http://vim-voom.github.com/]
let g:voom_tree_width=35

" NERDTree filesystem explorer for browsing directories...you feel me?
" [https://github.com/scrooloose/nerdtree]
"let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeShowBookmarks=1
let NERDChristmasTree=1
let NERDTreeHighlightCursorline=1
" Gundo: visualize your undo tree. It's like back to the future!
" [http://sjl.bitbucket.org/gundo.vim/]
let g:gundo_width=22
let g:gundo_preview_bottom=1
nnoremap <leader>u :GundoToggle<CR>

" Scratch provides an Emacs like scratch buffer
" https://github.com/kana/vim-scratch
map <Leader>so :ScratchOpen<cr>
map <Leader>sc :ScratchClose<cr>
 
" }}}

" ----- TESTING, PENDING DELETION, UNCATEGORIZED {{{

"set maplocalleader = ","

if exists('+relativenumber')
 nnoremap <expr> <F9> CycleLNum()
 xnoremap <expr> <F9> CycleLNum()
 onoremap <expr> <F9> CycleLNum()

 " function to cycle between normal, relative, and no line numbering
 func! CycleLNum()
   if &l:rnu
     setlocal nu
   elseif &l:nu
     setlocal nonu
   else
     setlocal rnu
   endif
   " sometimes (like in op-pending mode) the redraw doesn't happen
   " automatically
   redraw
   " do nothing, even in op-pending mode
   return ""
 endfunc
endif


let g:languagetool_jar='/Users/chrislott/Dropbox/apps/unix/languagetool/LanguageTool.jar'

"autocmd BufNewFile,BufRead */mutt-* set filetype=mail
"au FileType mail set tw=64 autoindent expandtab formatoptions=tcqn
"au FileType mail set list listchars=tab:»·,trail:·
"au FileType mail set comments=nb:>
"au FileType mail vmap D dO[...]^[
"au FileType mail silent normal /--\s*$^MO^[gg/^$^Mj

let g:Powerline_symbols = 'fancy'

" insert trailing whitespace marker segment
"call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')

" Add Tab Warning Segment
call Pl#Theme#InsertSegment(['raw', '%{TabWarning()}'], 'after', 'fileinfo')

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! TabWarning()
  if !exists("b:tab_warning")
    let tabs = search('^\t', 'nw') != 0
    let spaces = search('^ ', 'nw') != 0

    if tabs && spaces
      let b:tab_warning = '[mixed-indenting]'
    elseif (spaces && !&et) || (tabs && &et)
      let b:tab_warning = '[&et]'
    else
      let b:tab_warning = ''
    endif
  endif
  return b:tab_warning
endfunction

" }}}

"tell Vim where the dictionary is
"set dictionary+=/usr/share/dict/words

"also use dictionary for completion
"set complete+=k

"re-read files that have changed by forces outside of Vim
set autoread

source ~/.vim/vimrc/myfuncs.vim

if has('gui_running')
  source ~/.vim/vimrc/mygfuncs.vim
endif


"au BufNewFile,BufRead *.md setlocal dictionary+=/usr/share/dict/words
"au BufNewFile,BufRead *.md setlocal complete+=k


