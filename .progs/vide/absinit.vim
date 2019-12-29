" -- System wide config --
" Whole system is stripped down to guicolors only.
se tgc
" Because how syntax now works cannot unload abandoned buffer. This should be fixed.
se hid
" There are commands bound to mouse keys too.
se mouse=a
" Across OS restarts file can undo :h undo-persistance
se udf udir=~/.cache/vim-undo
" Never needed
se nowrap noswf nosmd
" Shiftwidth is equal to tabstop when it is zero.
se sw=0
" At any time do the toggle :setl list!
se lcs=space:⋅,trail:•,tab:˖\ ,nbsp:⦸,extends:»,precedes:«
" The best vim-startify right here
se shm+=IWcFqT
" noswap anyways, needed for snappy CursorHold evt
se ut=0
" will not hurt anyone
se so=2
" Do I not know what I just pressed? That's not a short term mermory anymore..
se nosc
" Unfold all on file load
se fdl=99
" there is a decent plugin for this thing - matchparen
se nosm
" smart indentation
se si
" Use silent! to avoid potential E11 if the command-line window is open.
au FocusGained * sil! checkt
" common
se et ts=4
" winblend
se winbl=20
" Inccommand preview works for :substitute, :smagic, :snomagic.
se icm=nosplit
