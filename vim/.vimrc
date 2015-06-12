call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-rails', { 'on': 'NERDTreeToggle' }
call plug#end()

if has("gui_running")
  " GUI is running or is about to start.
  " Set the x,y position of the gVim Window when gVim starts
  winpos 860 40

  " Set the width and height of the window
  set columns=99 lines=49
endif

" Automatically re-read open files that have changed on disk
:set autoread

" Automatically re-read .vimrc when changed
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }


" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

colorscheme sexy-railscasts
syntax on

set nolazyredraw
" Saves the current file and runs it through ruby, appending the output
" to the same file. Useful for quick testing of small scripts, and the
" output can be easily removed with a single key ("u" to undo).
map ,r :w<CR>Go<ESC>:.!ruby %<CR>

" Switch windows by using regular movement keys prefaced by Ctrl
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Settings for CtrlP
let g:ctrlp_clear_cache_on_exit=0

set nocompatible " essential
set history=1000 " lots of command line history
set cf " error files / jumping
set ffs=unix,dos,mac " support these files
filetype plugin indent on " load filetype plugin
set isk+=_,$,@,%,#,- " none word dividers
set viminfo='1000,f1,:100,@100,/20
set modeline " make sure modeline support is enabled
set autoread " reload files (no local changes only)

" ---------------------------------------------------------------------------
" Highlight
" ---------------------------------------------------------------------------

" highlight Comment ctermfg=DarkGrey guifg=#444444
" highlight StatusLineNC ctermfg=Black ctermbg=DarkGrey cterm=bold
" highlight StatusLine ctermbg=Black ctermfg=LightGrey

" ----------------------------------------------------------------------------
" Highlight Trailing Whitespace
" ----------------------------------------------------------------------------

set list listchars=trail:.,tab:>.
" highlight SpecialKey ctermfg=DarkGray ctermbg=Black

" ----------------------------------------------------------------------------
" Backups
" ----------------------------------------------------------------------------

set nobackup " do not keep backups after close
set writebackup " do keep a backup while working
set backupdir=$HOME/.vim/backup " store backups under ~/.vim/backup
set backupcopy=yes " keep attributes of original file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=~/.vim/swap//,.,~/tmp,/tmp " keep swp files under ~/.vim/swap

" ----------------------------------------------------------------------------
" UI
" ----------------------------------------------------------------------------

set ruler " show the cursor position all the time
set noshowcmd " don't display incomplete commands
set nolazyredraw " turn off lazy redraw
set number " line numbers
set wildmenu " turn on wild menu
set wildmode=list:longest,full
set ch=2 " command line height
set backspace=2 " allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l,[,] " backspace and cursor keys wrap to
set shortmess=filtIoOA " shorten messages
set report=0 " tell us about changes
set nostartofline " don't jump to the start of line when scrolling

" ----------------------------------------------------------------------------
" Visual Cues
" ----------------------------------------------------------------------------

set showmatch " brackets/braces that is
set mat=5 " duration to show matching brace (1/10 sec)
set incsearch " do incremental searching
set laststatus=2 " always show the status line
set ignorecase " ignore case when searching
set hlsearch " don't highlight searches
set visualbell " shut the fuck up

" ----------------------------------------------------------------------------
" Text Formatting
" ----------------------------------------------------------------------------

set autoindent " automatic indent new lines
set smartindent " be smart about it
set nowrap " do not wrap lines
set softtabstop=2 " yep, two
set shiftwidth=2 " ..
set tabstop=4
set expandtab " expand tabs to spaces
set nosmarttab " fuck tabs
set formatoptions+=n " support for numbered/bullet lists
set textwidth=76 " wrap at 76 chars by default
set virtualedit=block " allow virtual edit in visual block ..

" ----------------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------------

" Shortcut to move to the next buffer
map ;; :bn<CR>

" :Bclose requires the Bclose plugin. Deletes current buffer
" without closing the window. Very handy :D
map \\ :bd<CR>

" Toggle NERDTree plugin on or off. Requires NERDTree plugin.
map <F12> :execute 'NERDTreeToggle'<CR>

" quickfix mappings
map <F7> :cn<CR>
map <S-F7> :cp<CR>
map <A-F7> :copen<CR>
map <F4> :bw<CR>
map <F9> :cd ~/projects/tfti-api<CR>
inoremap <S-CR> <ESC>o

" emacs movement keybindings in insert mode
imap <C-a> <C-o>0
imap <C-e> <C-o>$
map <C-e> $
map <C-a> 0

" indent entire file and return to starting line
map <silent> <F5> mmgg=G'm
imap <silent> <F5> <Esc> mmgg=G'm

" reflow paragraph with Q in normal and visual mode
nnoremap Q gqap
vnoremap Q gq

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" do not menu with left / right in command line
cnoremap <Left> <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>

" ----------------------------------------------------------------------------
" Auto Commands
" ----------------------------------------------------------------------------

" jump to last position of buffer when opening
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                         \ exe "normal g'\"" | endif

" don't use cindent for javascript
autocmd FileType javascript setlocal nocindent

" ---------------------------------------------------------------------------
" sh config
" ---------------------------------------------------------------------------

au Filetype sh,bash set ts=4 sts=4 shiftwidth=4 expandtab
let g:is_bash = 1

" ---------------------------------------------------------------------------
" Misc mappings
" ---------------------------------------------------------------------------

imap jj <ESC>
imap kk <ESC>
map ,f :tabnew <cfile><CR>
map ,d :e %:h/<CR>
"map ,t :tabnew %<CR>
map ,dt :tabnew %:h/<CR>

" I use these commands in my TODO file
map ,a o<ESC>:r!date +'\%A, \%B \%d, \%Y'<CR>:r!date +'\%A, \%B \%d, \%Y' \| sed 's/./-/g'<CR>A<CR><ESC>
map ,o o[ ]
map ,O O[ ]
map ,x :s/^\[ \]/[x]/<CR>
map ,X :s/^\[x\]/[ ]/<CR>

" ---------------------------------------------------------------------------
" Strip all trailing whitespace in file
" ---------------------------------------------------------------------------

function! StripWhitespace ()
    exec ':%s/ \+$//gc'
endfunction
map ,s :call StripWhitespace ()<CR>

map fc :q<CR>
"map fc <Esc>:call CleanClose(1)<CR>
"map fq <Esc>:call CleanClose(0)<CR>

function! CleanClose(tosave)
  if (a:tosave == 1)
    w!
  endif
  let todelbufNr = bufnr("%")
  let newbufNr = bufnr("#")
  if ((newbufNr != -1) && (newbufNr != todelbufNr) && buflisted(newbufNr))
    exe "b".newbufNr
  else
    bnext
  endif

  if (bufnr("%") == todelbufNr)
    new
  endif
  exe "bd".todelbufNr
endfunction


" Create a mapping (e.g. in your .vimrc) like this:
nmap <C-W>! <Plug>Kwbd
nmap ,1 <Plug>Kwbd<CR>
let g:CommandTMatchWindowReverse=1



" Vim filetype detection file
" Language: AsciiDoc
" Author: Stuart Rackham <srackham@gmail.com>
" Last Change: AsciiDoc 8.2.0
" URL: http://www.methods.co.nz/asciidoc/
" Licence: GPL (http://www.gnu.org)
" Remarks: Vim 6 or greater

" COMMENT OUT ONE OF THE TWO FOLLOWING COMMANDS
" The first sets asciidoc syntax highlighting on all .txt files, the second
" only existing files *.txt that appear to be AsciiDoc files.

"au BufNewFile,BufRead *.txt,README,TODO,CHANGELOG,NOTES setfiletype asciidoc
au BufRead *.txt,README,TODO,CHANGELOG,NOTES call s:FTasciidoc()

" This function checks for a valid AsciiDoc document title after first
" skipping any leading comments.
function! s:FTasciidoc()
  let in_comment_block = 0
  let n = 1
  while n < 50
    let line = getline(n)
    let n = n + 1
    if line =~ '^/\{4,}$'
      if ! in_comment_block
        let in_comment_block = 1
      else
        let in_comment_block = 0
      endif
      continue
    endif
    if in_comment_block
      continue
    endif
    if line !~ '\(^//\)\|\(^\s*$\)'
      break
    endif
  endwhile
  if line !~ '.\{3,}'
    return
  endif
  let len = len(line)
  let line = getline(n)
  if line !~ '[-=]\{3,}'
    return
  endif
  if len < len(line) - 3 || len > len(line) + 3
    return
  endif
  setfiletype asciidoc
endfunction


au BufRead,BufNewFile *.go set filetype=go
