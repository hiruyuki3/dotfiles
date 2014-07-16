" NeoBundle Settings
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

" NeoBundleで管理するプラグイン
NeoBundleFetch  'Shougo/neobundle.vim'
NeoBundle       'Shougo/unite.vim.git'

" 辞書を呼び出す
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

" vimrcを開く
nnoremap ,vim :vsplit<cr><C-l>:e! $HOME/.vimrc<cr>

filetype plugin indent on
NeoBundleCheck
