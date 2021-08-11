# memotaker
## installing
もしvim-plugを使っているならば、この行を追加するだけです
```
Plug 'izassan/memotaker'
```

もしvimの標準パッケージ機能を使っているならば、以下のコマンドを実行してください
```
mkdir -p ~/.vim/pack/mypack/start
git clone https://github.com/izassan/memotaker ~/.vim/pack/mypack/start/memotaker
```

## how to use
このコマンドを実行するだけです。今日の文のメモが開きます
(例えば2021年7月1日ならばmemo_2021-7-1.mdが開きます)
```
:TakeMemo
```

もし昨日より以前のメモが見たいときは以下のコマンドを実行します
```
:ViewMemo // vim上のファイラでメモの保存先ディレクトリを開きます
```
vim上のファイラの変わりにfzfを使うことも可能です。以下の設定をvimrcに加えてください
```
g:memotaker_filer="fzf"
```

## configuration
```
let g:memotaker_template_path = "" // メモファイルのテンプレートを設定します
let g:memotaker_memo_save_dir= ~/.vim/memo // メモの保存先を設定します
let g:memotaker_memo_file_name= "memo_%Y-%m-%d.md" // 保存するメモのファイル名
let g:memotaker_filer="" // ViewMemoコマンド実行時のファイラを指定できます。現在はfzfにのみ対応しています
```

# Author
* izassan
* izassan@mail.izassan.net

# License
memotaker is under [MIT license](https://en.wikipedia.org/wiki/MIT_License)
