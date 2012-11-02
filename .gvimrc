macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
  macmenu &Tools.Make key=<nop>
  map <D-b> :CommandTBuffer<CR>

" set initial window size and location, but don't futz around with my terminal
" settings!

color candycode

    " initial window position
  winpos 220 30

  " start vim with this many lines (how tall) normally 45 for screen recording
  " set to 40
  set lines=45

  " and this many columns... I like it wide for my split windows and Voom
  " outlines and NERDTree and and and normally 140 120 for screen recording
  set columns=140

    " show tabs
    set showtabline=2

    " I don't need no stinking scrollbar
  set guioptions-=r
  set guioptions-=T
  
  "use a pretty font (though I'd like to find something better)
  "set guifont=Consolas:h14
  set guifont=Source\ Code\ Pro\ Light:h14
  "set guifont=Source\ Code\ Pro\ for\ Powerline:h14
  set lsp=2
 
  "set up cursor the way I like
  set guicursor=n-v-c:block-Cursor-blinkon0
  set guicursor+=ve:ver35-Cursor
  set guicursor+=o:hor50-Cursor
  set guicursor+=i-ci:ver25-Cursor
  set guicursor+=r-cr:hor20-Cursor
  set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

  "show labels on tabs
  set guitablabel=%{GuiTabLabel()}

  "make those tabs informative
  function! GuiTabLabel()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)
    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
      if getbufvar(bufnr, "&modified")
        let label = '+'
        break
      endif
    endfor
    " Append the tab number
    let label .= v:lnum.': '
    " Append the buffer name
    let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
    if name == ''
      " give a name to no-name documents
      if &buftype=='quickfix'
        let name = '[Quickfix List]'
      else
        let name = '[No Name]'
      endif
    else
      " get only the file name
      let name = fnamemodify(name,":t")
    endif
    let label .= name
    " Append the number of windows in the tab page
    let wincount = tabpagewinnr(v:lnum, '$')
    return label . '  [' . wincount . ']'
  endfunction

" set up tab tooltips with every buffer name
function! GuiTabToolTip()
  let tip = ''
  let bufnrlist = tabpagebuflist(v:lnum)

  for bufnr in bufnrlist
    " separate buffer entries
    if tip!=''
      let tip .= ' | '
    endif

    " Add name of buffer
    let name=bufname(bufnr)
    if name == ''
      " give a name to no name documents
      if getbufvar(bufnr,'&buftype')=='quickfix'
        let name = '[Quickfix List]'
      else
        let name = '[No Name]'
      endif
    endif
    let tip.=name

    " add modified/modifiable flags
    if getbufvar(bufnr, "&modified")
      let tip .= ' [+]'
    endif
    if getbufvar(bufnr, "&modifiable")==0
      let tip .= ' [-]'
    endif
  endfor

  return tip
endfunction
  
  "show tooltips on tabs
  set guitabtooltip=%{GuiTabToolTip()}
  
