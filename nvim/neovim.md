<!-- FileName: neovim
 Author: 8ucchiman
 CreatedDate: 2023-03-31 00:07:06 +0900
 LastModified: 2023-04-01 19:12:30 +0900
 Reference: 8ucchiman.jp
-->


# neovim

## Ex


### autocmd
[ref](https://vim-jp.org/vimdoc-ja/autocmd.html)
- :autocmd BufEnter *.txt lua print("Hello World from 8ucchiman")

テキストファイルを編集するときluaコマンドが実行される

```
    :autocmd [Event] [file pattern] [command]
```

#### Event

- BufNewFile



# [nvim_open_win(buf, enter, config)](https://neovim.io/doc/user/api.html#nvim_open_win())
 - buf(フローティングウィンドウに表示するバッファ番号,一時バッファが便利なので"false, true")
 - enter(ウィンドウに移動するかどうか)
 - config
    - row:       縦位置の指定, float)
    - col:       横位置の指定, float)
    - width:     ウィンドウの幅)
    - height:    ウィンドウの幅)
    - relative:  row/col
    - anchor:    隅(NW, NE, SW, SE)の位置を指定
    - focusable: :wincmdなどでウィンドウにフォーカスできるか
    - style:     minimalなどでnumber, cursorlineオフにする
