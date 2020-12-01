" {{{ Plugins

let s:configdir = '.vim'
if has('nvim')
    let s:configdir = '.config/nvim'
endif

if empty(glob('~/' . s:configdir . '/autoload/plug.vim'))
    silent call system('mkdir -p ~/' . s:configdir . '/{autoload,bundle,cache,undo,backups,swaps}')
    silent call system('curl -fLo ~/' . s:configdir . '/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    execute 'source  ~/' . s:configdir . '/autoload/plug.vim'
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/' . s:configdir . '/Plug')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'Matt-Deacalion/vim-systemd-syntax' " systemd syntax
Plug 'SirVer/ultisnips'                  " Ultimate snippets
Plug 'StanAngeloff/php.vim'              " PHP syntax
Plug 'airblade/vim-gitgutter'            " Live git changes visible
Plug 'andrewstuart/vim-Kubernetes'       " Vim Kubernetes Snippets
Plug 'christianrondeau/vim-base64'       " base64 encode decode
Plug 'christoomey/vim-tmux-navigator'    " Sync tmux and vim keybinds.
Plug 'fatih/vim-go'                      " Go development plugin
Plug 'google/vim-jsonnet'                " jsonnet filetype
Plug 'gregsexton/gitv'                   " gitk for Vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                  " Fuzzy finder
Plug 'junegunn/vim-easy-align'           " Align Text
Plug 'majutsushi/tagbar'                 " CTags Tagbar
Plug 'mattn/emmet-vim'                   " Emmet
Plug 'miyakogi/seiya.vim'                " Seiya
Plug 'monotykamary/vim-diff-fold'        " Diff folding
Plug 'morhetz/gruvbox'                   " Gruvbox theme
Plug 'mxw/vim-jsx'                       " Javascript highlighting and indenting
Plug 'pangloss/vim-javascript'           " Javascript syntax
Plug 'pearofducks/ansible-vim'           " ansible syntax highlighting
Plug 'posva/vim-vue'                     " Vue.js syntax
Plug 'scrooloose/nerdtree'               " Files and Folder Viewer
Plug 'tomasr/molokai'                    " Molokai theme
Plug 'tpope/vim-fugitive'                " Complement git in vim
Plug 'tpope/vim-sensible'                " sensible defaults.
Plug 'tpope/vim-surround'                " surround everything
Plug 'vim-syntastic/syntastic'           " Syntax checker
Plug 'vimwiki/vimwiki'                   " Vim Wiki
Plug 'prettier/vim-prettier'             " vim prettier
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'phanviet/vim-monokai-pro'          " Monokai Pro theme
Plug 'cakebaker/scss-syntax.vim'         " vim scss syntax highlighting

call plug#end()
" }}}
" {{{ Static Settings

" Whitespaces and Tabs
"match ErrorMsg '\s\+$'
set nomodeline
set list
set listchars+=tab:\.\ ,extends:›,precedes:‹,nbsp:·,trail:·
set wrap
set breakindent
set et ts=4 sw=4
set nosmarttab

" Search cases
set ignorecase
set smartcase

" Mouse and cursor
set mouse=a

" FOLDING
set foldenable
set foldmethod=marker

" Numberline
set number

" Colors
set background=dark
hi vertsplit cterm=none ctermfg=none ctermbg=none
hi LineNr ctermfg=241
hi CursorLine cterm=none ctermbg=none ctermbg=none
hi Folded ctermbg=237
hi Whitespace ctermfg=240
hi Statusline ctermbg=250 ctermfg=237
hi StatuslineNC ctermbg=250 ctermfg=237
hi Search cterm=none ctermbg=none ctermfg=none
hi Normal ctermbg=none
hi NonText ctermbg=none
hi Default ctermfg=none
hi clear SignColumn
hi SignColumn ctermbg=none
hi! EndOfBuffer ctermbg=none ctermfg=none

" Buffer settings
set splitbelow
set splitright
set hidden

" Status bar
set statusline=%=%f\ \ %m\ \ %l/%L\ \ %P
set fillchars=vert:\ ,stl:\ ,stlnc:\ ,eob:\ 
set laststatus=2
" }}}
" {{{ Let It Go
let g:NERDTreeMapActivateNode                  = "<F2>"
let g:NERDTreeMapPreview                       = "<F3>"
let g:NERDTreeWinPos                           = "left"
let g:NERDTreeWinSize                          = 35
let g:UltiSnipsExpandTrigger                   = "<A-CR>"
let g:deoplete#enable_at_startup               = 1
let g:deoplete#enable_at_startup               = 1
let g:gitgutter_override_sign_column_highlight = 0
let g:indentLine_concealcursor                 = 0
let g:go_version_warning                       = 0
let g:tagbar_autoshowtag                       = 1
let g:tagbar_foldlevel                         = 99
let g:tagbar_iconchars                         = ['+', '-']
let g:tagbar_sort                              = 0
let g:tmux_navigator_no_mappings               = 1
let g:vimwiki_list                             = [{'syntax': 'markdown', 'ext': '.md'}]
" }}}
" {{{ My Bindings

" Buffer related
noremap <A-:> :Commands<CR>
noremap <A-B> :History<CR>
noremap <A-H> :bp<CR>
noremap <A-L> :bn<CR>
noremap <A-N> :enew<CR>
noremap <A-P> :GFiles<CR>
noremap <A-T> :Tags<CR>
noremap <A-b> :Buffers<CR>
noremap <A-c> :cd %:p:h<CR>
noremap <A-4> :set et ts=4 sw=4<CR>
noremap <A-2> :set et ts=2 sw=2<CR>
noremap <A-m> :Marks<CR>
noremap <A-p> :Files<CR>
noremap <A-t> :BTags<CR>
noremap <A-w> :bp\|bd #<CR>
noremap <A-z> :set wrap!<CR>
noremap <F9>  :TagbarToggle<CR>

" EasyAlign
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" search and replace
noremap  <A-F> :args `ag -l ''`<Left><Left>
noremap  <A-R> :argdo %s!!!gc<Left><Left><Left><Left>
noremap  <A-f> :Ag<CR>
vnoremap *     y?<C-R>"<CR>

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" indenting keybinds and commands
nnoremap <Tab>   >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab>   >gv
vnoremap <S-Tab> <gv

" remap jj to esc 
inoremap jj <Esc>

" NerdTree
silent! map <F2> :NERDTreeFind<CR>

" Remove whitespaces
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

"vim-tmux-navigator
nnoremap <silent> <A-\> :TmuxNavigatePrevious<cr>
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
" }}}
" {{{ Functions

" force set file patch to filetype diff
autocmd BufNewFile,BufRead *.patch set filetype=diff

" add filetype specific commands
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" hide fzf statusline
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" automatically change working directory
"autocmd BufEnter * silent! lcd %:p:h

" pad strings with whitespace
function! Pad(s,amt)
    return a:s . repeat(' ',a:amt - len(a:s))
endfunction

" prepad strings with whitespace
function! PrePad(s,amt,...)
    if a:0 > 0
        let char = a:1
    else
        let char = ' '
    endif
    return repeat(char,a:amt - len(a:s)) . a:s
endfunction

" FoldText
set foldtext=FoldText()
function! FoldText()
    let l:lpadding = &fdc
    redir => l:signs
    execute 'silent sign place buffer='.bufnr('%')
    redir End
    let l:lpadding += l:signs =~ 'id=' ? 2 : 0

    if exists("+relativenumber")
        if (&number)
            let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 1
        elseif (&relativenumber)
            let l:lpadding += max([&numberwidth, strlen(v:foldstart - line('w0')), strlen(line('w$') - v:foldstart), strlen(v:foldstart)]) + 1
        endif
    else
        if (&number)
            let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 1
        endif
    endif

    let l:start = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g')
    let l:info = ' (' . (v:foldend - v:foldstart) . ')'
    let l:infolen = strlen(substitute(l:info, '.', 'x', 'g'))
    let l:width = winwidth(0) - l:lpadding - l:infolen
    let l:separator = ' '
    let l:separatorlen = strlen(substitute(l:separator, '.', 'x', 'g'))
    let l:start = strpart(l:start , 0, l:width - l:separatorlen)
    let l:text = l:start

    if getline(v:foldstart) =~# '^diff '
        let [add, remove] = [-1, -1]
        let l:text = ''
        for lnum in range(v:foldstart, v:foldend)
            if l:text ==# '' && getline(lnum) =~# '^[+-]\{3\} [abciow12]/'
                let l:text = getline(lnum)[6:-1]
            endif
            if getline(lnum) =~# '^+'
                let add += 1
            elseif getline(lnum) =~# '^-'
                let remove += 1
            elseif getline(lnum) =~# '^Binary '
                let binary = 1
            endif
        endfor
        if l:text ==# ''
            let l:text = matchstr(getline(v:foldstart), '^diff .\{-\} [abciow12]/\zs.*\ze [abciow12]/')
        endif
        if l:text ==# ''
            let l:text = getline(v:foldstart)[5:-1]
        endif
        if exists('binary')
            return 'Binary: '.l:text
        else
            let addText = Pad(add . '+', 8)
            let removeText = Pad(remove . '-', 8)
            return '   ' . addText . removeText . l:text
        endif
    endif

    return l:text . repeat(' ', l:width - strlen(substitute(l:text, ".", "x", "g"))) . l:info
endfunction
" }}}
