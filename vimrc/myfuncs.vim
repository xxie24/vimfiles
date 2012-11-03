if has("gui_running")
  function Xall()
        for t in range(1, tabpagenr('$')
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
command Xall call Xall()
else

endif
