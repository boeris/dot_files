" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.
 
"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.
 
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible
 
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on
 
" Enable syntax highlighting
syntax on
 
 
"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.
 
" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden
 
" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall
 
" Better command-line completion
"set wildmode=longest,list,full
set wildmode=longest,list
"set wildmenu

" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
" Removed !!!
"set hlsearch

" Toggle matching pattern highlighting when searching
" with <C-L>
let hlstate=1
function ToggleSearchHighlight()
    if (g:hlstate == 0)
        set nohlsearch
        echo "Disabling search highlight"
    else
        set hlsearch
        echo "Enabling search highlight"
    endif
    let g:hlstate=1-g:hlstate
endfunction
nmap <C-L> mz:execute ToggleSearchHighlight()<CR>`z

" Set search hightligh color
highlight Search cterm=NONE ctermfg=white ctermbg=NONE


" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline
 
" Display a few lines around cursor
:set scrolloff=5
 
"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.
 
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
 
" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
set visualbell
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
 
" Enable use of the mouse for all modes
set mouse=a
 
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
 
" Display line numbers on the left
set number
 
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
 
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
 
"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
 
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
" nnoremap <C-L> :nohl<CR><C-L>

 
"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.
 
" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
"set shiftwidth=4
"set softtabstop=4
"set expandtab
 
" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4


" THE FOLLOWING LINES ALLOW TO SWITCH BETWEEN A MODE WITH SPACES
" AND A MODE WITH REAL TABS

" virtual tabstops using spaces
set shiftwidth=8
set softtabstop=0
set noexpandtab
" allow toggling between local and default mode
function TabToggle()
	if &expandtab
		set shiftwidth=8
		set softtabstop=0
		set noexpandtab
		echo "Switching to tab mode"
	else
		set shiftwidth=4
		set softtabstop=4
		set expandtab
		echo "Switching to space mode"
	endif
endfunction
nmap <F9> mz:execute TabToggle()<CR>'z

 
 

"------------------------------------------------------------
" Display the 120 column limit with a shaded background
"------------------------------------------------------------

set colorcolumn=121
if $INVERTED_COLORS == "true"
    highlight ColorColumn ctermbg=LightGray
else
    highlight ColorColumn ctermbg=DarkGray
endif
"let &colorcolumn=join(range(121,999),",")
"highlight ColorColumn ctermbg=235 guibg=#2c2d27

"------------------------------------------------------------
" Switch to paste mode with <F10> to avoid annoying indent when pasting 
" code with the mouse
"------------------------------------------------------------

let isPaste = 0
function PasteToggle()
    if g:isPaste == 1
        set nopaste
        let g:isPaste = 0
        echo "Switching to NO paste mode"
    else
        set paste
        let g:isPaste = 1
        echo "Switching to paste mode"
    endif
endfunction
nmap <F10> mz:execute PasteToggle()<CR>`z

"------------------------------------------------------------
" show tab number in tabline
"------------------------------------------------------------

set tabline=%!MyTabLine()  " custom tab pages line
function MyTabLine()
        let s = '' " complete tabline goes here
        " loop through each tab page
        for t in range(tabpagenr('$'))
                " set highlight
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " set the tab page number (for mouse clicks)
                let s .= '%' . (t + 1) . 'T'
                let s .= ' '
                " set page number string
                let s .= t + 1 . ' '
                " get buffer names and statuses
                let n = ''      "temp string for buffer names while we loop and check buftype
                let m = 0       " &modified counter
                let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '
                " loop through each buffer in a tab
                for b in tabpagebuflist(t + 1)
                        " buffer types: quickfix gets a [Q], help gets [H]{base fname}
                        " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
                        if getbufvar( b, "&buftype" ) == 'help'
                                let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
                        elseif getbufvar( b, "&buftype" ) == 'quickfix'
                                let n .= '[Q]'
                        else
                                let n .= pathshorten(bufname(b))
                        endif
                        " check and ++ tab's &modified count
                        if getbufvar( b, "&modified" )
                                let m += 1
                        endif
                        " no final ' ' added...formatting looks better done later
                        if bc > 1
                                let n .= ' '
                        endif
                        let bc -= 1
                endfor
                " add modified label [n+] where n pages in tab are modified
                if m > 0
                        let s .= '[' . m . '+]'
                endif
                " select the highlighting for the buffer names
                " my default highlighting only underlines the active tab
                " buffer names.
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " add buffer names
                if n == ''
                        let s.= '[New]'
                else
                        let s .= n
                endif
                " switch to no underlining and add final space to buffer list
                let s .= ' '
        endfor
        " after the last tab fill with TabLineFill and reset tab page nr
        let s .= '%#TabLineFill#%T'
        " right-align the label to close the current tab page
        if tabpagenr('$') > 1
                let s .= '%=%#TabLineFill#%999Xclose'
        endif
        return s
endfunction

"------------------------------------------------------------
" Show white spaces
"------------------------------------------------------------

function ToggleWhitespaceHighlighting()
    if &syntax != "whitespace"
        set syntax=whitespace
    else
        syntax on
    endif
endfunction
nmap <F7> mz:execute ToggleWhitespaceHighlighting()<CR>`z 

"------------------------------------------------------------
" Use relative line numbers
"------------------------------------------------------------

set relativenumber
function ToggleRelativeLineNumbers()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <F8> :call ToggleRelativeLineNumbers()<CR>`z
"
" Use absolute line numbers in insert mode
autocmd InsertEnter * :set norelativenumber | set number
autocmd InsertLeave * :set relativenumber

"------------------------------------------------------------
" Configure ctags
"------------------------------------------------------------

" Search for tags file in ancestor directory
set tags=tags;



