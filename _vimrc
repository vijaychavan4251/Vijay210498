set nocompatible  " включить улучшенный режим, несовместимый с vi
" автоопределение типа файла и загрузка плагина для некоторых типов:
filetype plugin on
" загрузим плагины
runtime macros/matchit.vim  " переход между парными ключевыми словами
syntax on  " включим подсветку синтаксиса
set omnifunc=syntaxcomplete#Complete  " контекстное автодополнение <C-X><C-O>
set shortmess+=I  " отключаем детей Уганды
set background=dark  " установим фон
if has("gui_running")  " настройки для gvim
    set guicursor+=a:blinkon0  " курсор в vim-стиле для gvim
    set guioptions-=m  " скрыть меню
    set guioptions-=T  " скрыть тулбар
    set guioptions-=r  " скрыть правый скроллбар
    set guioptions-=L  " скрыть левый сроллбар
    colorscheme solarized  " установим цветовую схему
endif
if (has("win32") || has("win64"))  " настройки для windows
    set encoding=utf-8  " кодировка интерфейса
    language messages en_US.UTF-8  " язык и кодировка сообщений
    " language messages ru_RU.UTF-8  " язык и кодировка сообщений
    set colorcolumn=80  " подсветить колонку 80
    if has("gui_running")  " настройки для gvim
        set guifont=Terminus_(TTF)_for_Windows:h14:cRUSSIAN:qDRAFT
        " set guifont=Terminus:h21:cRUSSIAN:qDRAFT
    else  " настройки для консольного vim
        colorscheme default  " установим цветовую схему
        " цвет текста и фона подсвеченной колонки:
        highlight ColorColumn ctermfg=brown ctermbg=black
    endif
else
    if has("unix")
        let s:uname = system("uname")
        if s:uname == "Linux\n"  " настройки для linux
            let cterms=['xterm', 'rxvt', 'rxvt-unicode', 'urxvt',
                        \ 'xterm-256color']
            if (index(cterms, $TERM) >= 0)  " тема для 256-цветного терминала
                set t_Co=256  " использовать в иксах 256 цветов
                colorscheme solarized  " установим цветовую схему
                set colorcolumn=80  " подсветить колонку 80
                highlight ColorColumn ctermfg=red
            else  " настройки для tty
                set t_Co=8  " использовать в tty 8 цветов
                let g:solarized_contrast="high"
                colorscheme solarized  " установим цветовую схему
                " подсветить диапазон колонок:
                let &colorcolumn=join(range(80,999),",")
                " цвет текста и фона подсвеченной колонки:
                highlight ColorColumn ctermfg=red ctermbg=black
            endif
        endif
    endif
endif
set number  " отображать номера строк
set laststatus=2  " всегда показывать строку статуса
set hlsearch is " подсвечивать результаты поиска
set tabstop=4  " количество пробелов в TAB
set shiftwidth=4  " количество пробелов в TAB при добавлении
set expandtab  " заменять TAB на пробелы
set autoindent  " включим автоотступы
set smarttab  " умные отступы (например, удалять по 4 пробела по backspace)
set backspace=2  " фиксим неработающий backspace
" восстановить позицию курсора с последнего сеанса работы
au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") &&
    \ &filetype != "gitcommit" |
        \ execute("normal `\"") |
    \ endif
" не подсвечивать ключ при переходе к определению переменной/функции
nnoremap gd gd :noh<CR>
" следующие 3 строки - доступ к буферам по F12
set wildmenu  " автодополнение в командной строке в форме меню
set wildcharm=<C-Z>  " комба для вызова автодополнения
" меню переключения между активными буферами
nnoremap <F12> :b! <C-Z>
" сохранить всё и выйти
nnoremap <silent> <F10> :wqa<CR>
" k и g перемещают курсор на одну экранную строку, а gk и gj - на 1 фактическую
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
" назначим горячие клавиши для обхода списков:
" переход по буферам:
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" переход по списку аргументов:
nnoremap <silent> [a :previous<CR>
nnoremap <silent> ]a :next<CR>
nnoremap <silent> [A :first<CR>
nnoremap <silent> ]A :last<CR>
" переход по списку результатов:
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>
" переход по списку адресов:
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>
" переход по тегам:
nnoremap <silent> [t :tprevious<CR>
nnoremap <silent> ]t :tnext<CR>
nnoremap <silent> [T :tfirst<CR>
nnoremap <silent> ]T :tlast<CR>
" поменяем местами команды перехода на строку метки и на её точную позицию
nnoremap ' `
nnoremap ` '
" скрыть результаты поиска
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
" автопоказ окон со списками, если они не пусты (конфликтует с ф-циями Toggle):
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost l* nested lwindow
" показать/скрыть окно со списком результатов
nnoremap <silent> <F7> :call <SID>QFixToggle()<CR>
function! s:QFixToggle()
    if exists("g:qfix_win")
        cclose
        unlet g:qfix_win
    else
        copen 10
        let g:qfix_win=1
    endif
endfunction
" показать/скрыть окно со списком адресов
nnoremap <silent> <F6> :call <SID>LFixToggle()<CR>
function! s:LFixToggle()
    if exists("g:qwindow")
        lclose
        unlet g:qwindow
    else
        lopen 10
        let g:qwindow=1
    endif
endfunction
" автообновление тегов при сохранении файлов C
:autocmd FileType c autocmd BufWritePost *
    \ call system("ctags  -R --fields=+iaS --extra=+q")
" автоскрытие справки по текущему тегу после выбора:
autocmd CompleteDone * pclose
" PELLES C
if (has("win32") || has("win64"))
    " назначим на <F5> компиляцию и запуск
    autocmd FileType c nnoremap <buffer> <F5> :execute 'w'<CR>
        \ :execute '!cls'<CR>:execute 'lmake'<CR>:execute '!%:r.exe'<CR>
    " определим программу, вызываемую командой make для файлов c (PellesC)
    " сгенерируем команду для сборки, должно получиться что-то типа:
    " cc -Tx86-coff -Ot -W1 -Ze -std:C11 %
    "   /I"C:\Program Files\PellesC\Include\"
    "   /I"C:\Program Files\PellesC\Include\Win"
    "   /libpath:"C:\Program Files\PellesC\Lib\"
    "   /libpath:"C:\Program Files\PellesC\Lib\Win\"
    "   kernel32.lib user32.lib gdi32.lib comctl32.lib comdlg32.lib
    "   advapi32.lib delayimp.lib
    " префикс s сделает переменную локальной для скрипта :h internal-variables
    let s:PellesCDir='C:\Program Files\PellesC'
    let s:PellesCOptions=' -Ot -W1 -Ze -std:C11 '
    let s:PellesCInclude=' /I"'.s:PellesCDir.'\Include\" '
                         \.'/I"'.s:PellesCDir.'\Include\Win" '
    let s:PellesCxLibPath=' /libpath:"'.s:PellesCDir.'\Lib\"'
    let s:PellesCx86LibPath=s:PellesCxLibPath.' /libpath:"'.s:PellesCDir
                            \.'\Lib\Win\"'
    let s:PellesCx64LibPath=s:PellesCxLibPath
                            \.' /libpath:"'.s:PellesCDir.'\Lib\Win64\"'
    let s:PellesCLibraries=' kernel32.lib user32.lib gdi32.lib comctl32.lib
                           \ comdlg32.lib advapi32.lib '
    let s:PellesCx86Libraries=s:PellesCLibraries.'delayimp.lib'
    let s:PellesCx64Libraries=s:PellesCLibraries.'delayimp64.lib'
    let s:PellesCCompileX86='cc -Tx86-coff'.s:PellesCOptions.'%'
                            \.s:PellesCInclude.s:PellesCx86LibPath
                            \.s:PellesCx86Libraries
    let s:PellesCCompileX64='cc -Tx64-coff'.s:PellesCOptions.'%'
                            \.s:PellesCInclude.s:PellesCx64LibPath
                            \.s:PellesCx64Libraries
    " префикс l установит опцию только для текущего буфера - аналог setlocal
    autocmd FileType c let &l:makeprg=s:PellesCCompileX86
    " добавим хоткей для генерации меток по включаемых файлов:
    let s:UpdateIncludeTags=
        \'!ctags -f include_tags -R --fields=+iaS --extra=+q '
    let PellesCUpdateTags=s:UpdateIncludeTags
                          \.'"'.s:PellesCDir.'\Include\Win\fci.h" '
                          \.'"'.s:PellesCDir.'\Include\Win\windef.h" '
                          \.'"'.s:PellesCDir.'\Include\Win\windows.h" '
                          \.'"'.s:PellesCDir.'\Include\Win\winuser.h" '
    nnoremap <F2> :execute PellesCUpdateTags<CR><CR>
    " для контекстного автодополнения подключим теги для включаемых файлов:
    set tags+=include_tags
    " научим vim распознавать вывод, генерируемый компилятором PellesC
    " формат сообщений компилятора
    " test.c
    " test.c(3): error #2168: Operands of '=' have incompatible types 'int'
    " and 'char *'.
    " test.c(3): warning #2115: Local 'b' is initialized but never used.
    autocmd FileType c setlocal errorformat=
        \%f(%l):\ %trror\ #%n:\ %m,
        \%f(%l):\ %tarning\ #%n:\ %m,
        \%-G%f
endif
set hidden  " разрешим переключение между изменёнными буферами
" для работы хоткеев в русской раскладке:
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
nnoremap <silent> <C-^> :let &iminsert = ($iminsert == 0 ? 1 : 0)<CR>
" поиск по выделенному фрагменту с помщью * и #
xnoremap * :<C-u> call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u> call <SID>VSetSearch('?')<CR>/<C-R>=@/<CR><CR>
function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
endfunction
" использовать последине флаги в команде замены &
nnoremap & :&&<CR>
xnoremap & :&&<CR>
" СТРОКА СТАТУСА
set statusline=%<\ %{StatuslineModeToString()}\ %f\ %{(&readonly)?'\ ':''}
    \%{(&modified)?'\ [+]':''}%=%y\ %k\ %p%%\ %l/%L\ \ :\ \ %c\ 
" другие символы: 
" Создадим цветовую схему для строки статуса
if (has("win32") || has("win64"))  " настройки для windows
    let s:statusline_normal_color_ctermbg='Blue'
    let s:statusline_normal_color_ctermfg='Black'
    let s:statusline_normal_color_guibg='Black'
    let s:statusline_normal_color_guifg='DodgerBlue'
    let s:statusline_insert_color_ctermbg='Green'
    let s:statusline_insert_color_ctermfg='Black'
    let s:statusline_insert_color_guibg='Black'
    let s:statusline_insert_color_guifg='OliveDrab4'
    let s:statusline_replace_color_ctermbg='Magenta'
    let s:statusline_replace_color_ctermfg='Black'
    let s:statusline_replace_color_guibg='Black'
    let s:statusline_replace_color_guifg='DeepPink'
    let s:statusline_visual_color_ctermbg='Cyan'
    let s:statusline_visual_color_ctermfg='Black'
    let s:statusline_visual_color_guibg='Black'
    let s:statusline_visual_color_guifg='Turquoise'
    let s:statusline_vreplace_color_ctermbg='Brown'
    let s:statusline_vreplace_color_ctermfg='Black'
    let s:statusline_vreplace_color_guibg='Black'
    let s:statusline_vreplace_color_guifg='Brown'
else
    if has("unix")
        let s:uname = system("uname")
        if s:uname == "Linux\n"  " настройки для linux
    let s:statusline_normal_color_ctermbg='Black'
    let s:statusline_normal_color_ctermfg='DarkBlue'
    let s:statusline_normal_color_guibg='Black'
    let s:statusline_normal_color_guifg='DodgerBlue'
    let s:statusline_insert_color_ctermbg='Black'
    let s:statusline_insert_color_ctermfg='DarkGreen'
    let s:statusline_insert_color_guibg='Black'
    let s:statusline_insert_color_guifg='OliveDrab4'
    let s:statusline_replace_color_ctermbg='Black'
    let s:statusline_replace_color_ctermfg='DarkMagenta'
    let s:statusline_replace_color_guibg='Black'
    let s:statusline_replace_color_guifg='DeepPink'
    let s:statusline_visual_color_ctermbg='Black'
    let s:statusline_visual_color_ctermfg='DarkCyan'
    let s:statusline_visual_color_guibg='Black'
    let s:statusline_visual_color_guifg='Turquoise'
    let s:statusline_vreplace_color_ctermbg='Black'
    let s:statusline_vreplace_color_ctermfg='Brown'
    let s:statusline_vreplace_color_guibg='Black'
    let s:statusline_vreplace_color_guifg='Brown'
        endif
    endif
endif
" назначим ex-команду для установки дефолтного цвета строки статуса
command SetDefaultStatusLineColor :execute 'highlight statusline'
    \.' ctermfg='.s:statusline_normal_color_ctermfg
    \.' ctermbg='.s:statusline_normal_color_ctermbg
    \.' guibg='.s:statusline_normal_color_guibg
    \.' guifg='.s:statusline_normal_color_guifg
" и сразу её вызовем:
SetDefaultStatusLineColor
function! StatuslineModeToString()
    " возвращает текущий режим для строки статуса
    " попытка менять здесь цвет ведёт к жутким тормозам при перемещении курсора
    let l:mode=mode()
    return get({
        \ '__' : '------',
        \ 'n'  : 'NORMAL',
        \ 'i'  : 'INSERT',
        \ 'R'  : 'REPLACE',
        \ 'v'  : 'VISUAL',
        \ 'V'  : 'V-LINE',
        \ '' : 'V-BLOCK',
        \ 'c'  : 'COMMAND',
        \ 's'  : 'SELECT',
        \ 'S'  : 'S-LINE',
        \ '' : 'S-BLOCK',
        \ 't'  : 'TERMINAL',
        \ }, l:mode, l:mode)
endfunc
" забиндим на клавиши входа в визуальный режим смену цвета строки статуса
" <right><left> нужны, чтобы цвет менялся сразу при входе в визуальный режим
vnoremap <silent> <expr> <SID>SetStatuslineColorVisual
    \ <SID>SetStatuslineColorVisual()
nnoremap <silent> <script> v v<SID>SetStatuslineColorVisual<right><left>
nnoremap <silent> <script> V V<SID>SetStatuslineColorVisual<right><left>
nnoremap <silent> <script> <C-v> <C-v>
    \<SID>SetStatuslineColorVisual<right><left>
function! s:SetStatuslineColorVisual()
    " изменим интервал обновления для функции CursorHold
    set updatetime=0
    execute 'highlight statusline'
        \.' ctermbg='.s:statusline_visual_color_ctermbg
        \.' ctermfg='.s:statusline_visual_color_ctermfg
        \.' guibg='.s:statusline_visual_color_guibg
        \.' guifg='.s:statusline_visual_color_guifg
    return ''  " чтобы курсор не прыгал в начало строки при входе в visual mode
endfunction
" смена цвета строки статуса при входе в режим вставки/замены:
autocmd InsertEnter * call <SID>InsertStatuslineColor(v:insertmode)
" смена цвета строки статуса при переключении режима вставки/замены:
autocmd InsertChange * call <SID>InsertStatuslineColor(v:insertmode)
function! s:InsertStatuslineColor(mode)
    if a:mode == 'i'
        execute 'highlight statusline'
            \.' ctermbg='.s:statusline_insert_color_ctermbg
            \.' ctermfg='.s:statusline_insert_color_ctermfg
            \.' guibg='.s:statusline_insert_color_guibg
            \.' guifg='.s:statusline_insert_color_guifg
    elseif a:mode == 'r'
        execute 'highlight statusline'
            \.' ctermbg='.s:statusline_replace_color_ctermbg
            \.' ctermfg='.s:statusline_replace_color_ctermfg
            \.' guibg='.s:statusline_replace_color_guibg
            \.' guifg='.s:statusline_replace_color_guifg
    else
        execute 'highlight statusline'
            \.' ctermbg='.s:statusline_vreplace_color_ctermbg
            \.' ctermfg='.s:statusline_vreplace_color_ctermfg
            \.' guibg='.s:statusline_vreplace_color_guibg
            \.' guifg='.s:statusline_vreplace_color_guifg
    endif
endfunction
" чтобы цвет строки статуса менялся сразу после выхода из Insert/Replace mode
autocmd InsertLeave * call <SID>ResetStatuslineColor()
" чтобы цвет строки статуса менялся сразу после выхода из визуального режима,
" повесим функцию на отсутствие нажатий (интервал был ранее выставлен в 0)
autocmd CursorHold * call <SID>ResetStatuslineColor()
function! s:ResetStatuslineColor()
    set updatetime=4000
    SetDefaultStatusLineColor
endfunction
" МЕНЮ ПРОВЕРКИ ОРФОГРАФИИ
menu SpellLang.RU_EN :setlocal spell spelllang=ru_yo,en<CR>
menu SpellLang.off :setlocal nospell<CR>
menu SpellLang.RU :setlocal spell spelllang=ru_yo<CR>
menu SpellLang.EN :setlocal spell spelllang=en<CR>
map <F4> :emenu SpellLang.<C-Z>
