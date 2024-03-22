call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdcommenter'

call plug#end()

"languageserver":{
  "clangd": {
    "command": "clangd",
    "rootPatterns": ["compile_flags.txt", "compile_commands.json"],
    "filetypes": ["c", "cc", "cpp", "c++", "objc", "objcpp"]
    "}
"}
"colo torte
set tabstop=4
""inoremap { {}<Esc><CR><Esc>koi<Esc>j<C-S-v><S-%>=j<S-$>xa
set number
set shiftwidth=4
set showmode
set background=dark
colorscheme gruvbox
 noremap r : call Compile()<CR>
 function! Compile()
        execute "w"
        execute "clear"
        execute "!g++ -Wall % -std=c++17 -o %< -g -fsanitize=undefined "
 endfunction
"------------------外掛環境--------------------------
au Filetype FILETYPE
let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}

au FileType php
"let b:AutoPairs = AutoPairsDefine({'<?' : '?>', '<?php': '?>'})

set laststatus=2  "永遠顯示狀態列
let g:airline_powerline_fonts = 1  " 支援 powerline 字型
let g:airline#extensions#tabline#enabled = 1 "顯示視窗tab和bufferlet
let g:airline_theme='murmur'  " murmur配色不錯
if !exists('g:airline_symbols')
        let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1 " Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1 " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left' " Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1 " Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' }} " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1 " Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
"\cc 註釋當前行和選中行\cn 沒有發現和\cc有區別\c<空格> 如果被選區域有部分被註釋，則對被選區域執行取消註釋操作，其它情況 執行反轉註釋操作\cm 對被選區域
"------------------外掛環境--------------------------
" 太長的更新間隔會導致明顯的延遲並降低使用者體驗（預設是 4000 ms = 4s ）
set updatetime=300

" 永遠顯示 signcolumn（行號左邊那個，這我不知道怎麼翻），否則每當有診斷出來時整個程式碼就會被往右移
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " 新的版本可以把 signcolumn 和行號合併（這個我版本不夠沒看過，有人知道會長怎樣可以下面留言嗎？）
  set signcolumn=number
else
  set signcolumn=yes
endif

" 用 tab 鍵觸發自動補全
" 注意：載入設定後記得用命令 `verbose imap <tab>` 確定這沒有被其他外掛覆蓋掉
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" 讓 enter 鍵自動完成第一個建議並讓 coc 進行格式化（不確定個格式化指的是什麼，我看不太出來）
" enter 可以被重複 keymap（看不懂就算了，意思是你亂搞不會出錯）
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" 用 \rn 重新命名變數、函數（原文寫「符號」）
nmap <leader>rn <Plug>(coc-rename)

" 這個讓你可以捲動浮動視窗和跳出式框框（有時候自動補全給你的文件會太長超出螢幕，如果你想要看下面的內容必須設定這個）
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
