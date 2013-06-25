call pathogen#infect()
call pathogen#helptags()

syntax on
map ,t :CommandT<CR>
map ,b :CommandTBuffer<CR>

" Saves the current file and runs it through ruby, appending the output
" to the same file. Useful for quick testing of small scripts, and the
" output can be easily removed with a single key ("u" to undo).
map ,r :w<CR>Go<ESC>:.!ruby %<CR>

"narrower window
map _ <C-W>5<
"wider window
map + <C-W>5>
"shorter window
map - <C-W>-
"taller window
map = <C-W>+

" Switch windows by using regular movement keys prefaced by Ctrl
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Settings for CtrlP
let g:ctrlp_clear_cache_on_exit=0

"if (&term == 'xterm' || &term =~? '^screen') && hostname() == 'my-machine'
" set t_Co=256
"endif

" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------

set nocompatible " essential
set history=1000 " lots of command line history
set cf " error files / jumping
set ffs=unix,dos,mac " support these files
filetype plugin indent on " load filetype plugin
set isk+=_,$,@,%,#,- " none word dividers
set viminfo='1000,f1,:100,@100,/20
set modeline " make sure modeline support is enabled
set autoread " reload files (no local changes only)
set tabpagemax=50 " open 50 tabs max

set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"

colorscheme railscasts


" ---------------------------------------------------------------------------
" Highlight
" ---------------------------------------------------------------------------

highlight Comment ctermfg=DarkGrey guifg=#444444
highlight StatusLineNC ctermfg=Black ctermbg=DarkGrey cterm=bold
highlight StatusLine ctermbg=Black ctermfg=LightGrey

" ----------------------------------------------------------------------------
" Highlight Trailing Whitespace
" ----------------------------------------------------------------------------

set list listchars=trail:.,tab:>.
highlight SpecialKey ctermfg=DarkGray ctermbg=Black

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
map \\ :Bclose<CR>

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

" ----------------------------------------------------------------------------
" dbext - connect to any database and do crazy shit
" ----------------------------------------------------------------------------

let g:dbext_default_buffer_lines = 20 " result buffer size
let g:dbext_default_use_result_buffer = 1
let g:dbext_default_use_sep_result_buffer = 1 " multiple result buffers
let g:dbext_default_type = 'pgsql'
let g:dbext_default_replace_title = 1
let g:dbext_default_history_file = '~/.dbext_history'
let g:dbext_default_history_size = 200

" ----------------------------------------------------------------------------
" LookupFile
" ----------------------------------------------------------------------------

let g:LookupFile_TagExpr = '".ftags"'
let g:LookupFile_MinPatLength = 2
let g:LookupFile_ShowFiller = 0 " fix menu flashiness
let g:LookupFile_PreservePatternHistory = 1 " preserve sorted history?
let g:LookupFile_PreserveLastPattern = 0 " start with last pattern?

nmap <unique> <silent> <D-f> <Plug>LookupFile
imap <unique> <silent> <D-f> <C-O><Plug>LookupFile

" ----------------------------------------------------------------------------
" PATH on MacOS X
" ----------------------------------------------------------------------------

if system('uname') =~ 'Darwin'
  let $PATH = $HOME .
    \ '/usr/local/bin:/usr/local/sbin:' .
    \ '/usr/pkg/bin:' .
    \ '/opt/local/bin:/opt/local/sbin:' .
    \ $PATH
endif

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
" Open URL on current line in browser
" ---------------------------------------------------------------------------

function! Browser ()
    let line0 = getline (".")
    let line = matchstr (line0, "http[^ )]*")
    let line = escape (line, "#?&;|%")
    exec ':silent !open ' . "\"" . line . "\""
endfunction
map ,w :call Browser ()<CR>

" ---------------------------------------------------------------------------
" Strip all trailing whitespace in file
" ---------------------------------------------------------------------------

function! StripWhitespace ()
    exec ':%s/ \+$//gc'
endfunction
map ,s :call StripWhitespace ()<CR>

" ---------------------------------------------------------------------------
" File Types
" ---------------------------------------------------------------------------

au BufRead,BufNewFile *.rpdf set ft=ruby
au BufRead,BufNewFile *.rxls set ft=ruby
au BufRead,BufNewFile *.ru set ft=ruby
au BufRead,BufNewFile *.god set ft=ruby
au BufRead,BufNewFile *.rtxt set ft=html spell
au BufRead,BufNewFile *.sql set ft=pgsql
au BufRead,BufNewFile *.rl set ft=ragel
au BufRead,BufNewFile *.svg set ft=svg
au BufRead,BufNewFile *.haml set ft=haml
au BufRead,BufNewFile *.md set ft=mkd tw=72 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.markdown set ft=mkd tw=72 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.ron set ft=mkd tw=65 ts=2 sw=2 expandtab

au Filetype gitcommit set tw=68 spell
au Filetype ruby set textwidth=80 ts=2
au Filetype haml set ts=2 sw=2 sts=0 expandtab tw=120
au Filetype html,xml,xsl,rhtml source $HOME/.vim/scripts/closetag.vim

" --------------------------------------------------------------------------
" ManPageView
" --------------------------------------------------------------------------

let g:manpageview_pgm= 'man -P "/usr/bin/less -is"'
let $MANPAGER = '/usr/bin/less -is'

" --------------------------------------------------------------------------
" rails.vim
" --------------------------------------------------------------------------

let g:rails_subversion=1
let g:rails_menu=2

" make file executable
command -nargs=* Xe !chmod +x <args>
command! -nargs=0 Xe !chmod +x %


autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala setfiletype vala
au BufRead,BufNewFile *.vapi setfiletype vala

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


"here is a more exotic version of my original Kwbd script
"delete the buffer; keep windows; create a scratch buffer if no buffers left
function s:Kwbd(kwbdStage)
  if(a:kwbdStage == 1)
    if(!buflisted(winbufnr(0)))
      bd!
      return
    endif
    let s:kwbdBufNum = bufnr("%")
    let s:kwbdWinNum = winnr()
    windo call s:Kwbd(2)
    execute s:kwbdWinNum . 'wincmd w'
    let s:buflistedLeft = 0
    let s:bufFinalJump = 0
    let l:nBufs = bufnr("$")
    let l:i = 1
    while(l:i <= l:nBufs)
      if(l:i != s:kwbdBufNum)
        if(buflisted(l:i))
          let s:buflistedLeft = s:buflistedLeft + 1
        else
          if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
            let s:bufFinalJump = l:i
          endif
        endif
      endif
      let l:i = l:i + 1
    endwhile
    if(!s:buflistedLeft)
      if(s:bufFinalJump)
        windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
      else
        enew
        let l:newBuf = bufnr("%")
        windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
      endif
      execute s:kwbdWinNum . 'wincmd w'
    endif
    if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
      execute "bd! " . s:kwbdBufNum
    endif
    if(!s:buflistedLeft)
      set buflisted
      set bufhidden=delete
      set buftype=nofile
      setlocal noswapfile
    endif
  else
    if(bufnr("%") == s:kwbdBufNum)
      let prevbufvar = bufnr("#")
      if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
        b #
      else
        bn
      endif
    endif
  endif
endfunction

command! Kwbd call <SID>Kwbd(1)
nnoremap <silent> <Plug>Kwbd :<C-u>Kwbd<CR>

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
" set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vimcall pathogen#runtime_append_all_bundles()
" call pathogen#helptags()
syntax on
map ,t :CommandT<CR>
map ,b :CommandTBuffer<CR>

" Saves the current file and runs it through ruby, appending the output
" to the same file. Useful for quick testing of small scripts, and the
" output can be easily removed with a single key ("u" to undo).
map ,r :w<CR>Go<ESC>:.!ruby %<CR>

"narrower window
map _ <C-W>5<
"wider window
map + <C-W>5>
"shorter window
map - <C-W>-
"taller window
map = <C-W>+

" Switch windows by using regular movement keys prefaced by Ctrl
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Settings for CtrlP
let g:ctrlp_clear_cache_on_exit=0

"if (&term == 'xterm' || &term =~? '^screen') && hostname() == 'my-machine'
" set t_Co=256
"endif

" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------

set nocompatible " essential
set history=1000 " lots of command line history
set cf " error files / jumping
set ffs=unix,dos,mac " support these files
filetype plugin indent on " load filetype plugin
set isk+=_,$,@,%,#,- " none word dividers
set viminfo='1000,f1,:100,@100,/20
set modeline " make sure modeline support is enabled
set autoread " reload files (no local changes only)
set tabpagemax=50 " open 50 tabs max

set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"

colorscheme railscasts


" ---------------------------------------------------------------------------
" Highlight
" ---------------------------------------------------------------------------

highlight Comment ctermfg=DarkGrey guifg=#444444
highlight StatusLineNC ctermfg=Black ctermbg=DarkGrey cterm=bold
highlight StatusLine ctermbg=Black ctermfg=LightGrey

" ----------------------------------------------------------------------------
" Highlight Trailing Whitespace
" ----------------------------------------------------------------------------

set list listchars=trail:.,tab:>.
highlight SpecialKey ctermfg=DarkGray ctermbg=Black

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
map \\ :Bclose<CR>

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

" ----------------------------------------------------------------------------
" dbext - connect to any database and do crazy shit
" ----------------------------------------------------------------------------

let g:dbext_default_buffer_lines = 20 " result buffer size
let g:dbext_default_use_result_buffer = 1
let g:dbext_default_use_sep_result_buffer = 1 " multiple result buffers
let g:dbext_default_type = 'pgsql'
let g:dbext_default_replace_title = 1
let g:dbext_default_history_file = '~/.dbext_history'
let g:dbext_default_history_size = 200

" ----------------------------------------------------------------------------
" LookupFile
" ----------------------------------------------------------------------------

" let g:LookupFile_TagExpr = '".ftags"'
" let g:LookupFile_MinPatLength = 2
" let g:LookupFile_ShowFiller = 0 " fix menu flashiness
" let g:LookupFile_PreservePatternHistory = 1 " preserve sorted history?
" let g:LookupFile_PreserveLastPattern = 0 " start with last pattern?

" nmap <unique> <silent> <D-f> <Plug>LookupFile
" imap <unique> <silent> <D-f> <C-O><Plug>LookupFile

" ----------------------------------------------------------------------------
" PATH on MacOS X
" ----------------------------------------------------------------------------

if system('uname') =~ 'Darwin'
  let $PATH = $HOME .
    \ '/usr/local/bin:/usr/local/sbin:' .
    \ '/usr/pkg/bin:' .
    \ '/opt/local/bin:/opt/local/sbin:' .
    \ $PATH
endif

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
" Open URL on current line in browser
" ---------------------------------------------------------------------------

function! Browser ()
    let line0 = getline (".")
    let line = matchstr (line0, "http[^ )]*")
    let line = escape (line, "#?&;|%")
    exec ':silent !open ' . "\"" . line . "\""
endfunction
map ,w :call Browser ()<CR>

" ---------------------------------------------------------------------------
" Strip all trailing whitespace in file
" ---------------------------------------------------------------------------

function! StripWhitespace ()
    exec ':%s/ \+$//gc'
endfunction
map ,s :call StripWhitespace ()<CR>

" ---------------------------------------------------------------------------
" File Types
" ---------------------------------------------------------------------------

au BufRead,BufNewFile *.rpdf set ft=ruby
au BufRead,BufNewFile *.rxls set ft=ruby
au BufRead,BufNewFile *.ru set ft=ruby
au BufRead,BufNewFile *.god set ft=ruby
au BufRead,BufNewFile *.rtxt set ft=html spell
au BufRead,BufNewFile *.sql set ft=pgsql
au BufRead,BufNewFile *.rl set ft=ragel
au BufRead,BufNewFile *.svg set ft=svg
au BufRead,BufNewFile *.haml set ft=haml
au BufRead,BufNewFile *.md set ft=mkd tw=72 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.markdown set ft=mkd tw=72 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.ron set ft=mkd tw=65 ts=2 sw=2 expandtab

au Filetype gitcommit set tw=68 spell
au Filetype ruby set textwidth=80 ts=2
au Filetype haml set ts=2 sw=2 sts=0 expandtab tw=120
au Filetype html,xml,xsl,rhtml source $HOME/.vim/scripts/closetag.vim

" --------------------------------------------------------------------------
" ManPageView
" --------------------------------------------------------------------------

let g:manpageview_pgm= 'man -P "/usr/bin/less -is"'
let $MANPAGER = '/usr/bin/less -is'

" --------------------------------------------------------------------------
" rails.vim
" --------------------------------------------------------------------------

let g:rails_subversion=1
let g:rails_menu=2

" make file executable
" command -nargs=* Xe !chmod +x <args>
" command! -nargs=0 Xe !chmod +x %


autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala setfiletype vala
au BufRead,BufNewFile *.vapi setfiletype vala

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
set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim
