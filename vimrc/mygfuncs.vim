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

"show tooltips on tabs
  set guitabtooltip=%{GuiTabToolTip()}
  
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
