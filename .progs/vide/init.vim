" let g:loaded_clipboard_provider='xsel'
let mapleader="\<space>"

so $VIMRUNTIME/absinit.vim
" se rtp=/usr/share/nvim/
" se rtp^=$VIMRUNTIME
se rtp=$VIMRUNTIME

let g:php_var_selector_is_identifier=1
colo gui-base16-eighties

" {{{1 PLUGINS

" {{{2 vim-easy-align, hlsearch
se rtp+=$VIMRUNTIME/github/junegunn/vim-easy-align
xm ga <plug>(EasyAlign)

" {{{2 fzf
se rtp+=$VIMRUNTIME/github/junegunn/fzf
se rtp+=$VIMRUNTIME/github/junegunn/fzf.vim
nn <unique><silent> t :BTags<cr>
nn <unique><silent> <leader>f :Files<cr>
nn <unique><silent> <leader>b :Buffers<cr>
nn <unique><silent> <leader>F :<c-u>execute 'Rg '.expand('<cword>')<cr>

" {{{2 pope
se rtp+=$VIMRUNTIME/github/tpope/vim-commentary
se rtp+=$VIMRUNTIME/github/tpope/vim-surround
se rtp+=$VIMRUNTIME/github/tpope/vim-abolish
se rtp+=$VIMRUNTIME/github/tpope/vim-repeat

" {{{2 Mundo
" requires python3
se rtp+=$VIMRUNTIME/github/simnalamburt/vim-mundo
se rtp+=$VIMRUNTIME/github/sheerun/vim-polyglot

" {{{2 vDebug
" requires python3
" se rtp+=$VIMRUNTIME/github/vdebug

" {{{2 coc
set rtp+=$VIMRUNTIME/github/neoclide/coc.nvim:release
set rtp+=$VIMRUNTIME/github/neoclide/coc.nvim
let g:coc_global_extensions = [
\'coc-lists', 'coc-yank', 'coc-json', 'coc-highlight', 'coc-css', 'coc-snippets', 'coc-git', 'coc-tsserver',
\'coc-html', 'coc-emmet', 'coc-rls', 'coc-ccls']
nn <unique><silent> <c-space> :call CocAction('doHover')<cr>
nn <unique><silent> gd :call CocAction('jumpDefinition')<cr>
nn <unique><silent><buffer> gh :call CocAction('highlight')<cr>
ino <silent><buffer><expr> <c-space> coc#refresh()
nm [c <Plug>(coc-git-prevchunk)
nm ]c <Plug>(coc-git-nextchunk)
nm <leader>hp <Plug>(coc-git-chunkinfo)
" nm gc <Plug>(coc-git-commit)
call Hi('CocHighlightRead', g:hi01, g:hi0B, 'bold')
call Hi('CocHighlightWrite', g:hi01, g:hi08, 'bold')
call Hi('CocErrorSign', g:hi08, g:hi01, 'bold')
call Hi('CocWarningSign', g:hi0A, g:hi01, 'bold')
call Hi('CocInfoSign', g:hi0C, g:hi01, 'bold')
call Hi('CocHintSign', g:hi05, g:hi01, 'bold')

" {{{2 nerd
se rtp+=$VIMRUNTIME/github/scrooloose/nerdtree " SUCH A BLOAT
nn <unique><silent> <leader>n :NERDTreeToggle<cr>
nn <unique><silent> <leader>N :NERDTreeFind<cr>

" {{{2 filetree
se rtp+=$VIMRUNTIME/wip_plugins/filetree " nerdtree replacement
nm <unique><silent> <a-n> <plug>(filetree-toggle)
nm <unique><silent> <a-N> <plug>(filetree-focus)

" {{{1 ALT-ernating
nn <unique><silent> <a-=> :cnext<cr>
nn <unique><silent> <a--> :cprev<cr>
nn <unique><silent> <a-0> :cclose<cr>

nn <unique><silent> <a-]> :lnext<cr>
nn <unique><silent> <a-[> :lprev<cr>
nn <unique><silent> <a-\> :lclose<cr>

nn <unique><silent> <a-j> :tabprev<cr>
nn <unique><silent> <a-k> :tabnext<cr>

" {{{1 VERY-BAD-habbits
nn <unique><silent> !!q :cq<cr>
nn <unique><silent> <leader>w :silent! w<cr>
nn <unique><silent> <leader>W :silent! wrap!<cr>
nn <unique><silent> <leader>, :nohl<cr>
vn <unique><silent> <c-j> 10j
vn <unique><silent> <c-k> 10k
nn <unique><silent> <c-j> 10j
nn <unique><silent> <c-k> 10k
nn <unique><silent> <cr> @@
nn <unique><silent> Q :silent! nohl<cr>
nn <unique><silent> Y y$
nn <unique><silent> <c-right> 10<c-w>>
nn <unique><silent> <c-left> 10<c-w><
nn <unique><silent> <c-up> 10<c-w>+
nn <unique><silent> <c-down> 10<c-w>-
nn <unique><silent> <leader>* :let @/ = '\<' . expand('<cword>') . '\>' <bar> set hlsearch<cr>
" }}}

se pumblend=7

nn <unique><expr> <f2> util#verbose_buf()
nn <unique> <f1> :vsp $VIMRUNTIME/init.vim<cr>

" Go back to last misspelled word and pick first suggestion while typing.
" TODO: take next and next suggestion by repeated press
ino <c-l> <c-g>u<esc>[s1z=`]a<c-g>u

se tal=%!framework#tabline()
se stl=%!framework#statusline()

cal jobstart('vide-plug '.$VIMRUNTIME.' '.&rtp.' &')

" vim: fdm=marker fdc=3
