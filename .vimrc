"-------------------------------------------------------------------------------
"general setting
"-------------------------------------------------------------------------------
set nocompatible
set hls                         "high light search
set showcmd                     "show command
set nu                          "show line number
set ru
set cindent shiftwidth=4        "auto align
set shiftwidth=4                "unknown
set backspace=indent,eol,start  "unknown
set expandtab                   "expand tab enable
set tabstop=4                   "expand tab width
set textwidth=78                "auto wrap width
set nowrap                      
set scrolloff=7                 "vertical scroll offset
set sidescroll=2                "horizontal scroll step
set ignorecase                  "ignore-case when search
set autoindent                  
set fo +=2nmM                   "suitable for chinese edit
set path+=.\**\                 "include-search path
set completeopt=longest,menu    "auto-complete option
set linespace=0                 "Space between lines
"set columns=110
set guioptions-=T
"set guioptions-=m
set fileformats=unix,dos
set ut=700
set incsearch
set guioptions-=T               "隐藏工具栏 
set guioptions-=m               "隐藏菜单栏
set laststatus=2
set fileencodings=utf-8,cp936,gbk,gb2312,gb18030,cs-bom,latin1,big5
set fileencoding=utf-8
set guifont=Monospace\ 12
winpos 5 5
syn on
set t_Co=256
colorscheme sunolokai           "自己写的配色方案，配合TagHighlight口味更佳
"-------------------------------------------------------------------------------
"plugin setting
"-------------------------------------------------------------------------------
"vim-powerline
set laststatus=2
let g:Powline_symbols='fancy'

"ctags updating
set tags=tags
func Uptags()
    let l:tags_exist = filereadable("tags")
    if l:tags_exist
        silent exec "!~/.vim/bin/uptags.sh tags " . expand("%") . " &"
    endif
endfunc
au BufWritePost *.c     :call Uptags()
au BufWritePost *.cpp   :call Uptags()
" org-mode
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org            call org#SetOrgFileType()

"Markdown
let g:vim_markdown_folding_disabled=1
let g:voom_tree_placement = "right"

"the NERD Tree
let NERDTreeWinSize = 40
let NERDTreeShowHidden = 1

"OmniCppComplete 暂时不用
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
let OmniCpp_MayCompleteDot = 1   " 输入 .  后自动补全
let OmniCpp_MayCompleteArrow = 1 " 输入 -> 后自动补全
let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif "自动关闭补全窗口
set completeopt=menuone,menu,longest

"Indent guide
let g:indent_guides_auto_colors           = 1
let g:indent_guides_guide_size            = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level           = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#080818   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#180808   ctermbg=4
hi IndentGuidesOdd  guibg=red   ctermbg=3
hi IndentGuidesEven guibg=green ctermbg=4

"CtrlP
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.rvm$'
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

"Tlist
let Tlist_Use_Right_Window        = 1
let Tlist_Auto_Update             = 1
let Tlist_File_Fold_Auto_Close    = 1
let Tlist_Show_One_File           = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select         = 1
let Tlist_Process_File_Always     = 1

"win manager
let g:winManagerWindowLayout = "FileExplorer,BufExplorer"

"calendar
let g:calendar_diary = "/mnt/d/Downloads/vim_diary"

"markdown make
func! WikiMake()
    if filereadable("makefile")
        exec "silent !make"
    endif
endfunc

au BufWritePost *.mkd call WikiMake()
"-------------------------------------------------------------------------------
"nmap
"-------------------------------------------------------------------------------

"bufferExplorer
nmap ff  \be
nmap fv  \bv
nmap fs  \bs

map <F2> :gvim ~/work/resource/work.gtd<cr>:NERDTree ~/work/resource<cr>:NERDTreeToggle<cr>:cd /home/user/work/resource<cr>
map <F3> <ESC>o<ESC>:call setline(".", strftime("[p: %Y.%m.%d]"))<cr>kJ :call Tca('\[p: \d\+.\d\+.\d\+\]', 81)<cr>$h    | "gtd plan date
map <F4> <ESC>o<ESC>:call setline(".", strftime("[c: %Y.%m.%d]"))<cr>kJ :call Tca('\[c: \d\+.\d\+.\d\+\]', 101)<cr>$h   | "gtd finish task(Add finish date)

nmap <F7> :NERDTreeToggle<cr><c-w>hh    | "Toggle file-manager window "nmap <F7> :WMToggle<cr><c-w>j<cr>
nmap <F8> :Tlist<cr><c-w>j              | "Toggle tag-list window

" project
nmap <F9> :cs kill -1<cr>:!cscope -Rb<cr>:cs a cscope.out<cr>
nmap <F10> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q<cr>:UpdateTypesFile<cr>

"Move left/right
nmap <C-L> <C-W>l
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k

nmap j gj
nmap k gk

nmap <leader>ww :cd ~/work/myWiki/<cr>:vi index.mkd<cr>cd $OLDPWD<cr>

" For conque terminal 暂时没用
nmap <leader>tt :ConqueTermTab bash<cr>
nmap <leader>tv :ConqueTermVSplit bash<cr>
nmap <leader>th :ConqueTermSplit bash<cr>

"-------------------------------------------------------------------------------
"imap
"-------------------------------------------------------------------------------
imap <C-T> <cr><cr><ESC>k:call setline(".", strftime("%H:%M"))<cr>kJJ           | " insert time
imap <C-D> <cr><cr><ESC>k:call setline(".", strftime("%Y.%m.%d"))<cr>kJJ        | " insert date
imap {} {}<ESC>i
imap () ()<ESC>i
imap [] []<ESC>i
imap <> <><ESC>i
imap "" ""<ESC>i
imap '' ''<ESC>i
imap `` ``<ESC>i

"-------------------------------------------------------------------------------
"plugin list
"-------------------------------------------------------------------------------
"*****************************************************************************
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"*****************************************************************************
"vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"插件管理器
Bundle 'gmarik/vundle'
"状态栏增强
Bundle 'Lokaltog/vim-powerline'
"函数名列表
Bundle 'taglist.vim'
"窗口管理器
Bundle 'winmanager'
"markdown语法高亮
Bundle 'Markdown'
"文件浏览器
Bundle 'The-NERD-tree'
"缓冲区管理器
Bundle 'bufexplorer.zip'
"分割线
Bundle 'Indent-Guides'
"文件搜索神器 
Bundle 'ctrlp.vim'
"语法结构补全 
Bundle 'snipMate'
"字符串自动补全
Bundle 'AutoComplPop'
"配色主题, 注意需要手动放~/.vim/colors/molokai.vim
Bundle 'c.vim'
"高亮
Bundle 'TagHighlight'

filetype plugin indent on
