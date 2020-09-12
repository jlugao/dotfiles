" To install Plugins :PlugInstall
" To update Plugins :PlugUpdate
" Remove plugins :PlugClean
" check plugin status :PlugStatus
" update vim-plug :PlugUpgrade

let g:ale_sign_column_always = 1
call plug#begin('~/.local/share/nvim/plugged')

" Completion and analysis
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

" python specific plugins
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'Vimjas/vim-python-pep8-indent'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'

"Tags
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'

" Assortment
Plug 'tpope/vim-commentary'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdtree'
Plug 'machakann/vim-highlightedyank'
Plug 'habamax/vim-asciidoctor'

" Fuzzy Finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim'

call plug#end()
colorscheme gruvbox
set background=dark

" ALE (linters)
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'javascript': ['eslint'],
      \}

let g:ale_fixers = {
      \    'python': ['black'],
      \}
nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 1

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
        \   '😞 %dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

" set statusline=
" set statusline+=%m
" set statusline+=\ %f
" set statusline+=%=
" set statusline+=\ %{LinterStatus()}

" ======= NeoFormat
" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

" =========== vim configs
let mapleader = " "

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set autoindent
set encoding=utf-8
set nowrap
set noerrorbells " Disable error bells
set tabstop=4 softtabstop=4 " tab = 4 spaces
set shiftwidth=4
set showmatch
set expandtab " Transformm tab in spaces
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch " Search as you type
set relativenumber " Relative line numbers
set number " Also show current absolute line
set colorcolumn=80

inoremap jj <esc>
command! Config execute ":e $MYVIMRC"
command! Reload execute "source ~/.config/nvim/init.vim"
noremap <C-h> :tabp<CR>
noremap <C-l> :tabn<CR>
noremap <C-J> :tabc<CR>
nmap <leader>l :bn<CR>
nmap <leader>h :bp<CR>
if has('mouse')
  set mouse=a
endif


"""
" FZF
"""

" https://github.com/junegunn/fzf.vim

" Let The :Files command show all files in the repo (including dotfiles)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'

" Bind "//" to a fzf-powered buffer search
nmap // :BLines!<CR>

" Bind "??" to a fzf-powered project search
nmap ?? :Rg!<CR>

" Bind "<leader>p" to a fzf-powered filename search
nmap <leader>p :Files!<CR>

" Bind "cc" to a fzf-powered command search
nmap cc :Commands!<CR>

"""
" NERDTree
"""

let NERDTreeShowHidden=1

function! ToggleNERDTree()
  NERDTreeToggle
  " Set NERDTree instances to be mirrored
  silent NERDTreeMirror
endfunction

" Bind "<leader>n" to toggle NERDTree
nmap <leader>n :call ToggleNERDTree()<CR>


"""
" CtrlSF
"""

" https://github.com/dyng/ctrlsf.vim

" Set "<leader>s" to substitute the word under the cursor. Works great with
" CtrlSF!
nmap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Set up some handy CtrlSF bindings
nmap <leader>a :CtrlSF -R ""<Left>
nmap <leader>A <Plug>CtrlSFCwordPath -W<CR>
nmap <leader>c :CtrlSFFocus<CR>
nmap <leader>C :CtrlSFToggle<CR>

" Use Ripgrep with CtrlSF for performance
let g:ctrlsf_ackprg = '/usr/bin/rg'

" term variants of the tab navigation bindings from above to make the
" interactive command line tools easier to work with
tmap <C-h> <C-w>:tabp<CR>
tmap <C-l> <C-w>:tabn<CR>

" Open the current buffer in a new tab
noremap <leader>z :tab split<CR>



""""""""""
" COC
""""""""""

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

command! -nargs=0 Prettier :CocCommand prettier.formatFile

  " Git Gutter
  highlight GitGutterAdd guifg=#009900 ctermfg=Green
  highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
  highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
  nmap ) <Plug>(GitGutterNextHunk)
  nmap ( <Plug>(GitGutterPrevHunk)
  let g:gitgutter_enabled = 1
  let g:gitgutter_map_keys = 0
  let g:gitgutter_highlight_linenrs = 1

  " Vim-airline
  let g:airline#extensions#wordcount#enabled = 1
  let g:airline#extensions#hunks#non_zero_only = 1
  let g:airline_theme = 'codedark'
