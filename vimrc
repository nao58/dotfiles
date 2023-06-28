if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" ================================================================================
"
" ================================================================================

" --------------------------------------------------------------------------------
" Editor Display Settings
" --------------------------------------------------------------------------------
set t_Co=256
set encoding=utf8
set nocompatible
syntax on
filetype on
filetype indent plugin on
set background=light
set autoindent
set copyindent
set autoread
set autowrite
set splitright
set splitbelow
"set lazyredraw
set ttyfast
set ttimeout
set notimeout
set nottimeout
set number
set norelativenumber
set ruler
set cursorline
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set backspace=indent,eol,start
set shiftround
set laststatus=2
set showcmd
set showmode
set title
set wildmenu
set wildmode=list:longest
set cmdheight=2
set scrolloff=2

" Status line ------------------------------------------------------------- {{{
"set statusline=%<%f\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v\ %l/%L
set statusline=%f    " Path.
set statusline+=%m   " Modified flag.
set statusline+=%r   " Readonly flag.
set statusline+=%w   " Preview window flag.

set statusline+=\    " Space.

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()} " Syntastic errors.
set statusline+=%*

set statusline+=%=   " Right align.

" File format, encoding and type.  Ex: "(unix/utf-8/python)"
set statusline+=(
set statusline+=%{&ff}                        " Format (unix/DOS).
set statusline+=/
set statusline+=%{strlen(&fenc)?&fenc:&enc}   " Encoding (utf-8).
set statusline+=/
set statusline+=%{&ft}                        " Type (python).
set statusline+=)

" Line and column position and counts.
set statusline+=\ (line\ %l\/%L,\ col\ %03c)

" File format, encoding and type.  Ex: "
" set statusline+=(
" set statusline+=%{&ff)
" set statusline+=/
" set statusline+=%{strlen()
" set statusline+=/
" set statusline+=%{&ft)
" set statusline+=)
"
" " Line and column position and counts.
" set statusline+=\ (line\ %l\/%L,\ col\ %03c)
" }}}


set hidden
set modelines=0
set list
set listchars=tab:>-

" esc key binding
inoremap <silent> jj <ESC>

" ---------------------------------------------------------------------- {{{
" Backup Settings
set nobackup
set noswapfile
" }}}


" ---------------------------------------------------------------------- {{{
" Search Settings
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch

set history=1000
let undolevels=1000
" }}}


" ---------------------------------------------------------------------- {{{
" Bell Settings
set visualbell
set noerrorbells
" }}}

set wrap
set textwidth=100
set formatoptions=qrn1

let mapleader = ","
nnoremap / /\v
vnoremap / /\v
nnoremap ; :
nmap <silent> ,/ :nohlsearch<CR>

" ---------------------------------------------------------------------- {{{
" disable allow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" }}}

vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" ---------------------------------------------------------------------- {{{
" Folding
set foldlevelstart=0
nnoremap <Space> za
vnoremap <Space> za
" }}}

" ---------------------------------------------------------------------- {{{
" Internal grep
au QuickfixCmdPost vimgrep cw
set grepprg=internal
" }}}

augroup filetypedetect
  au! BufRead,BufNewFile *.app.src   setfiletype erlang
  au! BufRead,BufNewFile *.config   setfiletype erlang
augroup END

" ---------------------------------------------------------------------- {{{
" Japanese Encoding Auto Detection
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif

"if has('iconv')
"  let s:enc_euc = 'euc-jp'
"  let s:enc_jis = 'iso-2022-jp'
"  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
"    let s:enc_euc = 'eucjp-ms'
"    let s:enc_jis = 'iso-2022-jp-3'
"  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
"    let s:enc_euc = 'euc-jisx0213'
"    let s:enc_jis = 'iso-2022-jp-3'
"  endif
"  if &encoding ==# 'utf-8'
"    let s:fileencodings_default = &fileencodings
"    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
"    let &fileencodings = &fileencodings .','. s:fileencodings_default
"    unlet s:fileencodings_default
"  else
"    let &fileencodings = &fileencodings .','. s:enc_jis
"    set fileencodings+=utf-8,ucs-2le,ucs-2
"    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
"      set fileencodings+=cp932
"      set fileencodings-=euc-jp
"      set fileencodings-=euc-jisx0213
"      set fileencodings-=eucjp-ms
"      let &encoding = s:enc_euc
"      let &fileencoding = s:enc_euc
"    else
"      let &fileencodings = &fileencodings .','. s:enc_euc
"    endif
"  endif
"  unlet s:enc_euc
"  unlet s:enc_jis
"endif
" }}}
