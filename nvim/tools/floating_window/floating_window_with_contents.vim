"
" FileName:     floating_window_with_contents
" Author:       8ucchiman
" Email:        8ucchiman@gmail.com
" CreatedDate:  2023-07-08 21:00:31
" LastModified: 2023-01-26 17:46:51 +0900
" Reference:    8ucchiman.jp
" Description:  ---
"


" コンテンツ用ウィンドウの作成
 function! s:create_contents_window(config, field) abort
  let config = {'relative': 'editor', 'row': a:config.row + 1, 'col': a:config.col + 2, 'width': a:config.width - 4, 'height': a:config.height - 2, 'style': 'minimal'}
  let buffer = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(buffer, 0, -1, v:true, a:field)
  return nvim_open_win(buffer, v:true, config)
endfunction

" 2つで1つのウィンドウとしてみせる
 function! s:new_window(config, field) abort
  call s:create_border_window(a:config)
  call s:create_contents_window(a:config, a:field)
endfunction

let config = { 'relative': 'editor', 'row': 30, 'col': 30, 'width': 50, 'height': 20, 'anchor': 'NW', 'style': 'minimal'}
let field =
  \ ['今日の日付']
  \ + ['']
  \ + ['2021/01/31']

call s:new_window(config, field)

