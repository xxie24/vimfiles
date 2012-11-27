" set color scheme
" color candycode

" initial window position
winpos 30 30

" start vim with this many lines (how tall) normally 45 for screen recording
" set to 40
set lines=45

" and this many columns... I like it wide for my split windows and Voom
" outlines and NERDTree and and and normally 140 120 for screen recording
set columns=140

" show tabs always
set showtabline=2

" I don't need no stinking scrollbar
set guioptions-=r
set guioptions-=T

set lsp=2
"set up cursor the way I like
set guicursor=n-v-c:block-Cursor-blinkon0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor
set guicursor+=r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

"show labels on tabs

"I learned the hard way that including files with functions like these
"in a separate file won't apply to the newly launched window unless
"they are sent at the time of entering a GUI window

"use a pretty font (though I'd like to find something better)
au GUIEnter * set guifont=Source\ Code\ Pro\ for\ Powerline:h16

au GUIEnter * set gtl=%{GuiTabLabel()} gtt=%{GuiTabToolTip()}
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

"show tooltips on tabs
"  let &guitabtooltip=%{GuiTabToolTip()}
  
" set up tab tooltips with every buffer name
function! GuiTabToolTip()
  let tip = ''
  "use this to limit to buffers open in current window - not sure why one
  "would do that
  "let bufnrlist = tabpagebuflist(v:lnum)
  let bufnrlist = filter(range(1, bufnr('$')), 'buflisted(v:val)')    

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
