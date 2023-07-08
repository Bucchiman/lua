"
" FileName:     floating_window
" Author:       8ucchiman
" Email:        8ucchiman@gmail.com
" CreatedDate:  2023-07-08 19:40:30
" LastModified: 2023-01-26 17:46:51 +0900
" Reference:    https://www.rasukarusan.com/entry/2021/01/31/132414
" Description:  ---
"


" コンテンツ用ウィンドウの作成
function! s:create_contents_window(config) abort
  let config = {'relative': 'editor', 'row': a:config.row + 1, 'col': a:config.col + 2, 'width': a:config.width - 4, 'height': a:config.height - 2, 'style': 'minimal'}
  let buffer = nvim_create_buf(v:false, v:true)
  return nvim_open_win(buffer, v:true, config)
endfunction

" 枠線用ウィンドウの作成
function! s:create_border_window(config) abort
  let width = a:config.width
  let height = a:config.height
  let top = "╭" . repeat("─", width - 2) . "╮"
  let mid = "│" . repeat(" ", width - 2) . "│"
  let bot = "╰" . repeat("─", width - 2) . "╯"
  let lines = [top] + repeat([mid], height - 2) + [bot]
  let buffer = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(buffer, 0, -1, v:true, lines)
  return nvim_open_win(buffer, v:true, a:config)
endfunction

" 2つで1つのウィンドウとしてみせる
function! s:new_window(config) abort
  call s:create_border_window(a:config)
  call s:create_contents_window(a:config)
endfunction

" ex.) 使い方
let config = { 'relative': 'editor', 'row': 30, 'col': 30, 'width': 50, 'height': 20, 'anchor': 'NW', 'style': 'minimal'}
call s:new_window(config)

