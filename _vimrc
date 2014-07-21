" vimrc.localがあれば読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
    execute 'source ' . s:local_vimrc
endif

" mac辞書を呼び出す
function! s:dict(...)
  let is_macunix = has('mac') || has('macunix') || has('gui_macvim') || (!executable('xdg-open') && system('uname') =~? '^darwin')
  if(!is_macunix)
    echohl WarningMsg
    echomsg 'Your platform is not supported!'
    echohl None
    finish
  endif
  let word = len(a:000) == 0 ? input('Dictionary search: ', expand('<cword>')) : join(a:000, ' ')
  call system(printf("open dict://'%s'", word))
endfunction
command! -nargs=* Dict call <SID>dict(<f-args>)
nnoremap ,rr :Dict

" Dashを呼び出す
function! s:dash(...)
  let word = len(a:000) == 0 ? input('Dash search: ') : a:1
  call system(printf("open dash://'%s'", word))
endfunction
command! -nargs=? Dash call <SID>dash(<f-args>)

" vi互換オフ
set nocompatible
" シンタックスオン
syntax on
" オートインデントを有効
set autoindent
" 行番号を表示
set number
" タブをスペースに変換
set expandtab
" タブをスペース2つにする
set tabstop=2
" 表示する時の文字コード
set encoding=utf-8
" 保存する時の文字コード
set fenc=utf-8
" バックアップファイルを作成しない
set nobackup
" スワップファイルを作成しない
set noswapfile
" ペースト時のオートインデント停止
:set paste
" c-jにescを割り当てる
inoremap <C-j> <ESC>
" ビープ音を消す
set visualbell

" 行末のスペースをハイライト
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" vimrcを開く
nnoremap ,vim :vsplit<cr><C-l>:e! $HOME/.vimrc<cr>
" vimrc保存時に再読み込みさせる
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }


" NeoBundle
if has('vim_starting')
   set nocompatible
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif
call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle      'Shougo/unite.vim'
NeoBundle      'Shougo/neomru.vim'
NeoBundle      'mattn/emmet-vim'
NeoBundle      'tell-k/vim-browsereload-mac'
NeoBundle      'kana/vim-submode'
NeoBundle      'kannokanno/previm'
NeoBundle      'tyru/open-browser.vim'
NeoBundle      'Markdown'
NeoBundle      'koron/codic-vim'

" Previm
" <Space>p + bでプレビュー <Space>p + rでリロード
" let g:previm_open_cmd = 'open -a Google\ Chrome'
nnoremap [previm] <Nop>
nmap <Space>p [previm]
nnoremap <silent> [previm]b :<C-u>PrevimOpen<CR>
nnoremap <silent> [previm]r :call previm#refresh()<CR>
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

" OpenBrowser
 let g:openbrowser_open_filepath_in_vim = 0
" 現在編集中のファイルをブラウザで開く
command! OpenBrowserCurrent execute "OpenBrowser" expand("%:p")
nnoremap <Space>ob :OpenBrowserCurrent<CR>



" Unite
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

" Emmet
let g:user_emmet_leader_key='<c-e>'
let g:user_emmet_settings = {
\   'lang' : 'ja'
\ }

" vim-browsereload-mac
let g:returnApp = "iTerm"
" ブラウザをアクティブにする場合は0をセット
let g:returnAppFlag = 1
command! -bar Cr silent ChromeReload
command! -bar CrStart silent ChromeReloadStart
command! -bar CrStop silent ChromeReloadStop

" vim-submode
" http://d.hatena.ne.jp/thinca/20130131/1359567419
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>-')
call submode#map('winsize', 'n', '', '-', '<C-w>+')

" カーソル上のURLをブラウザで開く
function! HandleURI()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
    exec "!open \"" . s:uri . "\""
  else
    echo "No URI found in line."
  endif
endfunction
" \w
map <Leader>w :call HandleURI()<CR>

filetype plugin indent on
NeoBundleCheck
