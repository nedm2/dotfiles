"General vimrc
"Inlude with: source <vimrc>

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'EasyMotion'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
"Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'moll/vim-bbye'
Plugin 'airblade/vim-gitgutter'
Plugin 'osyo-manga/vim-anzu'
"Plugin 'jaxbot/selective-undo.vim'
Plugin 'chrisbra/csv.vim'
Plugin 'kopischke/vim-fetch'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'jonbri/vim-flash'
"Plugin 'lyuts/vim-rtags'
"Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-commentary'
Plugin 'vim-scripts/BufOnly.vim'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'rhysd/vim-clang-format'
"Plugin 'vim-scripts/Conque-GDB'
Plugin 'junegunn/fzf.vim'
" Plugin 'SirVer/ultisnips'
" Plugin 'honza/vim-snippets'
" Bundle 'ervandew/supertab'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'majutsushi/tagbar'
Plugin 'matze/vim-move'
Plugin 'chriskempson/base16-vim'
Plugin 'neoclide/coc.nvim'

" Set path for fzf
if executable('/usr/local/bin/fzf')
    set rtp+=/usr/local/opt/fzf
elseif executable($HOME . '/.fzf/bin/fzf')
    set rtp+=~/.fzf
endif

"colorscheme base16-default-dark

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" airline config
let g:airline#extensions#tabline#enabled = 1

"basic editing stuff
set expandtab
set autoindent
set tabstop=4

"syntax
syntax enable
au BufRead,BufNewFile *.fs set filetype=fs       "f sharp syntax
au BufNewFile,BufRead *.cpy set filetype=python "python c-generators

"wild menu settings
set wildmode=longest,list,full
set wildmenu

"normal backspace operation
set backspace=2

"custom status bar
:set laststatus=2
":set statusline=%F%m%r%h%w\ %{&ff}\ %Y\ [0x\%02.2B]\ %=%l/%L,%v\ %p%%
set ruler
set rulerformat=%100(%t%m%r%h%w\ %Y\ %=0x\%02.2B\ %l/%L,%v\ %p%%%)

"highlight search matches
set hlsearch

"Allow opening of many tabs
set tabpagemax=100

"turn off automatic wrapping
set textwidth=0
set wrapmargin=0

"turn off line wrap
set nowrap

"jk esc and friends
imap jk <Esc>
imap Jk <Esc>
imap JK <Esc>
imap j;k <Esc>
nnoremap ; :

"Smoother scrolling
set scroll=10

" I haven't found how to hide this function (yet)
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

" NB: this supports "rp that replaces the selection by the contents of @r
vnoremap <silent> <expr> p <sid>Repl()

" toggle paste mode with F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" get rid of a few keystrokes for common command line tasks
nnoremap ;;; :AsyncRun<space>
nnoremap ;; :!
nnoremap ;' :<C-F>
nnoremap /' /<C-F>

if executable('rg')
    nnoremap // :AsyncRun rg -n<space>
else
    nnoremap // :AsyncRun grep -rn  * <left><left><left>
endif

" Window navigation
nmap <silent> <C-a> <C-W>w

nmap <silent> <Tab> :bn<CR>
nmap <silent> <S-Tab> :bp<CR>

if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Open quick fix window automatically
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

highlight Search ctermfg=black

set hidden

command Q Bdelete

" Make fold bg a different colour from cursor
hi Folded ctermbg=117

set shiftwidth=4

function! OverLenOn()
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/
endfunction

function! OverLenOff()
    highlight clear OverLength
endfunction

command Overlen call OverLenOn()
command Nooverlen call OverLenOff()

"Always copy/paste to/from system clipboard
set clipboard^=unnamed,unnamedplus

if filereadable(expand("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

" Configure vim-anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

" Configure ycm
highlight SpellBad cterm=underline ctermbg=black
nnoremap Yf :YcmCompleter FixIt<CR>


" Use comma as leader
let mapleader=","

" Nicer shortcut for rtags
nmap + ,rj
nmap - ,rb

set exrc
set secure

let g:ycm_always_populate_location_list = 1

set ttymouse=xterm2
set mouse=a

" Synchronize with system clipboard on exit
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" Nicer J behaviour
set formatoptions+=j

" Highlight trailing whitespace
match ErrorMsg '\s\+$'

let g:ctrlp_prompt_mappings = { 'MarkToOpen()': [';'] }
let g:ctrlp_open_multiple_files = '1i'

let g:ConqueTerm_Color = 2         " 1: strip color after 200 lines, 2: always with color
let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly

set encoding=utf-8

" Reduce updatetime for quicker responsiveness
set updatetime=1000

" Fuzzy line search in ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']

" Use Ctrl-O to open CtrlP in buffer mode
map <C-N> :CtrlPBuffer<CR>

command! -bang Commits call fzf#vim#commits({'options': '--no-preview'}, <bang>0)

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

command! -bang FLines call fzf#vim#grep(
     \ 'rg -vn --glob="!.svn" --glob="!.git" --glob="!tags" --glob="!*\.pyc" --glob="!*\.exe" --glob="!*\.dll" --glob="!*\.zip" --glob="!*\.gz" "^$"',
     \ 0,
     \ {'options': '--reverse --prompt "FLines> "'})

" Search and replace under cursor
nnoremap <Leader><Leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<C-f>
nnoremap <Leader><Leader><Leader>s :!rg -l <C-r><C-w> <Bar> xargs -L1 sed -i 's/<C-r><C-w>/<C-r><C-w>/g'<C-f>

" Use // style comments for vim-commnetary
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
autocmd FileType cmake setlocal commentstring=#\ %s

let g:ycm_autoclose_preview_window_after_insertion = 1

" make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'

let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = '1'

" better key bindings for UltiSnipsExpandTrigger
" let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

nnoremap <Leader>i :YcmCompleter GetDocImprecise<CR>

" unimpaired style open for Tagbar
nmap =ot :TagbarOpenAutoClose<CR>

" Search case-insensitive by default
nnoremap / /\c

" nice left right scrolling
map <C-L> 1zl" Scroll 1 characters to the right
map <C-H> 1zh" Scroll 1 characters to the left

let g:asyncrun_open = 8
let g:asyncrun_trim = 1

" Make alt work correctly
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set ttimeoutlen=0

autocmd FileType c,cpp ClangFormatAutoEnable

" Scroll left right
nnoremap L zl
nnoremap H zh

map <C-P> :Files<CR>

" coc.nvim configuration
" nmap <silent> + <Plug>(coc-definition)

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" " Use `[g` and `]g` to navigate diagnostics
"
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
