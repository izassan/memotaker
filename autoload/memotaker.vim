" Take a Memo
" Last Change:	2022/01/16
" Maintainer:	Izassan
" License:	This file is placed in the public domain.

if exists("g:loaded_memotaker")
    finish
endif
let g:loaded_memotaker = 1

" settings variable
if !exists("g:memotaker_template_path")
    let g:memotaker_template_path = ""
endif
if !exists("g:memotaker_memo_save_dir")
    let g:memotaker_memo_save_dir= expand("$HOME/.vim/memo")
endif
if !exists("g:memotaker_memo_file_name")
    let g:memotaker_memo_file_name= "memo_%Y-%m-%d.md"
endif
if !exists("g:memotaker_filer")
    let g:memotaker_filer=""
endif

function! memotaker#generate_save_dir() abort
    " 1. 保存先ディレクトリの存在を確認
    if !isdirectory(g:memotaker_memo_save_dir)
    " 1.1 存在しなければ作成する
        call mkdir(g:memotaker_memo_save_dir, "p")
    " 1.1 存在するならば何もしない
    endif
endfunction

function! memotaker#take() abort
    " 1. 保存先ディレクトリを作成する
    call memotaker#generate_save_dir()

    " 2. 作成先パスを生成する
    let l:memofile_path =
    \ g:memotaker_memo_save_dir . "/" .
    \ strftime(g:memotaker_memo_file_name)

    " 3. 作成ファイルの存在を確認
    " 3.1 存在する場合にはファイルを開く
    " 3.2 存在しない場合には新しくファイルを作成する
    execute (&l:modified ? "split" : "edit") l:memofile_path
    " 4. テンプレートファイルの設定有無確認
    if !empty(g:memotaker_template_path) &&
        \ filereadable(g:memotaker_template_path) &&
        \ !filereadable(l:memofile_path)
        " テンプレートファイルのインポートを行う
        let l:template_buffer = readfile(g:memotaker_template_path)
        call append(0, l:template_buffer)
    endif
    call cursor(1,1)
endfunction


function! memotaker#view_all_memos() abort
    if &l:modified
        new
    endif
    if g:memotaker_filer == "fzf"
        execute "FZF" g:memotaker_memo_save_dir
    else
        execute "edit" g:memotaker_memo_save_dir
    endif
endfunction

function! memotaker#new_memo() abort
    " 1. 保存先ディレクトリを作成する
    call memotaker#generate_save_dir()

    " 2. 保存するファイル名を入力する
    let l:memofile_name = input("Memo Name?: ")

    " 3. 作成先パスを生成する
    let l:memofile_path =
    \ g:memotaker_memo_save_dir . "/" .
    \ l:memofile_name . ".md"

    " 3. 作成ファイルの存在を確認
    " 3.1 存在する場合にはファイルを開く
    " 3.2 存在しない場合には新しくファイルを作成する
    execute (&l:modified ? "split" : "edit") l:memofile_path
endfunction
