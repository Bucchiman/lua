"
" FileName:     floating_window_move
" Author:       8ucchiman
" Email:        8ucchiman@gmail.com
" CreatedDate:  2023-07-08 21:26:15
" LastModified: 2023-01-26 17:46:51 +0900
" Reference:    8ucchiman.jp
" Description:  ---
"


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

" 2つで1つのウィンドウとしてみせる
function! s:new_window(config, field) abort
  let border_window_id = s:create_border_window(a:config)
  let contents_window_id = s:create_contents_window(a:config, a:field)
  " コンテンツ用ウィンドウと枠線用ウィンドウを紐付ける
  let s:window_ids[contents_window_id] = border_window_id
  " ウィンドウ削除処理を、コンテンツ用ウィンドウに登録
  nnoremap <buffer><nowait><silent> :q<CR> :call <SID>close_window()<CR>
  " 移動操作を登録
  nnoremap <buffer><nowait><silent> l :call <SID>move('x', 1)<CR>
  nnoremap <buffer><nowait><silent> h :call <SID>move('x', -1)<CR>
  nnoremap <buffer><nowait><silent> j :call <SID>move('y', 1)<CR>
  nnoremap <buffer><nowait><silent> k :call <SID>move('y', -1)<CR>
  return contents_window_id
endfunction

