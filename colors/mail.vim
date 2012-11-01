" Vim after syntax file
" Language:	Mail file
" Maintainer:	Gary Johnson <garyjohn AT spocom DOT com>
" Last Change:	2011-06-30 22:49:28

" Override the settings in syntax/mail.vim to color the quoted sections as
" they were colored by 'tin' or by 'mutt's pager, not as the e-mail being
" composed will appear when read later.  I found this less confusing, even
" though both the reply text and the material being replied to have normal
" coloring.

" The default coloring of quote levels by syntax/mail.vim has a period of
" 2--colors alternate between Comment (blue) and Identifier (cyan).  The
" coloring used by 'mutt' and 'tin' have a higher period--3, I think--which I
" like better and is used here.

if !exists("g:mail_syntax_type")
    let g:mail_syntax_type = 2
endif

if g:mail_syntax_type == 0
    " Use the default.

    finish

elseif g:mail_syntax_type ==1
    " Use my original modifications.

    hi! link mailHeaderKey	Statement
    hi! link mailHeader		Type
    hi! link mailSubject	Statement
    hi! link mailEmail		Statement
    hi! link mailQuoted1	NONE
    hi! link mailQuoted2	Type
    hi! link mailQuoted3	Statement
    hi! link mailQuoted4	Comment
    hi! link mailQuoted5	mailQuoted2
    hi! link mailQuoted6	mailQuoted3
    hi! link mailSignature	Comment

else
    " Use the 'mutt' colors, but as the recipient will see my reply, not as I
    " see the original.  This is a compromise that keeps the color pallet of
    " my original scheme but colors the text of the message to which I'm
    " replying instead of keeping it normal.

    hi! link mailHeaderKey	Statement
    hi! link mailHeader		Type
    hi! link mailSubject	Statement
    hi! link mailEmail		Statement
    hi! link mailQuoted1	Type
    hi! link mailQuoted2	Statement
    hi! link mailQuoted3	Comment
    hi! link mailQuoted4	mailQuoted1
    hi! link mailQuoted5	mailQuoted2
    hi! link mailQuoted6	mailQuoted3
    hi! link mailSignature	Comment

endif
