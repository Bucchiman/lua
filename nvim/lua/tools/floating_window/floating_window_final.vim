"
" FileName:     floating_window_final
" Author:       8ucchiman
" Email:        8ucchiman@gmail.com
" CreatedDate:  2023-07-08 21:31:41
" LastModified: 2023-01-26 17:46:51 +0900
" Reference:    8ucchiman.jp
" Description:  ---
"


" 枠線用ウィンドウとコンテンツウィンドウを紐付ける連想配列
let s:window_ids = {}

" コンテンツ用ウィンドウの作成
function! s:create_contents_window(config, field) abort
  let config = {'relative': 'editor', 'row': a:config.row + 1, 'col': a:config.col + 2, 'width': a:config.width - 4, 'height': a:config.height - 2, 'style': 'minimal'}
  let buffer = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(buffer, 0, -1, v:true, a:field)
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

function! s:move(direction, value)
  let contents_window_id = nvim_get_current_win()
  let border_window_id = get(s:window_ids, contents_window_id, -1)
  for id in [contents_window_id, border_window_id]
    let config = nvim_win_get_config(id)
    if a:direction == 'x'
      let config.col += a:value
    else
      let config.row += a:value
    endif
    call nvim_win_set_config(id, config)
  endfor
endfunction

" コンテンツ・枠線のウィンドウを削除
" コンテンツウィンドウIDを引数で指定できるようにしておくと便利
function! s:close_window(...)
  let contents_window_id = a:0 == 0 ? nvim_get_current_win() : a:1
  let border_window_id = get(s:window_ids, contents_window_id, -1)
  if border_window_id != -1
    call nvim_win_close(contents_window_id, v:true)
    call nvim_win_close(border_window_id, v:true)
    call remove(s:window_ids, contents_window_id)
  endif
endfunction

" 2つで1つのウィンドウとしてみせる
function! s:new_window(config, field) abort
  let border_window_id = s:create_border_window(a:config)
  let contents_window_id = s:create_contents_window(a:config, a:field)
  " コンテンツ用ウィンドウと枠線用ウィンドウを紐付ける
  let s:window_ids[contents_window_id] = border_window_id
  " ウィンドウ削除処理を、コンテンツ用ウィンドウに登録
  nnoremap <buffer><nowait><silent> :q<CR> :call <SID>close_window()<CR>
  nnoremap <buffer><nowait><silent> j :call <SID>move('y', 1)<CR>
  nnoremap <buffer><nowait><silent> k :call <SID>move('y', -1)<CR>
  nnoremap <buffer><nowait><silent> l :call <SID>move('x', 1)<CR>
  nnoremap <buffer><nowait><silent> h :call <SID>move('x', -1)<CR>
  return contents_window_id
endfunction


let config = { 'relative': 'editor', 'row': 30, 'col': 30, 'width': 50, 'height': 20, 'anchor': 'NW', 'style': 'minimal'}
let field =
  \ ['今日の日付']
  \ + ['']
  \ + ['2021/01/31']

let contents_window_id = s:new_window(config, field)
nnoremap T :call <SID>close_window(contents_window_id)<CR>

