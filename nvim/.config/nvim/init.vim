" -*- mode: vimrc -*-
"vim: ft=vim

" function! CopyX()
"   :'<,'>w !xclip
" endfunction
" command CopyX :call CopyX()

function! Layers()
  " Configuration Layers declaration.
  " Add layers with `Layer '+layername'` and add individual packages
  " with `ExtraPlugin 'githubUser/Repo'`.
  ExtraPlugin 'ryanoasis/vim-devicons'

  Layer '+core/behavior'
  Layer '+core/sensible'
  " Layer '+completion/asynccomplete'
  " Layer '+completion/nvim-completion-manager' " Or '+completion/deoplete'
  " Layer '+completion/snippets'
  Layer '+checkers/ale' " Or '+checkers/neomake'
  Layer '+checkers/quickfix'
  Layer '+docs/zeal'
  Layer '+gui/ide'
  Layer '+nav/buffers'
  Layer '+nav/comments'
  Layer '+nav/files'
  Layer '+nav/fzf' " Or '+nav/fuzzy'
  Layer '+nav/jump'
  Layer '+nav/quit'
  Layer '+nav/start-screen'
  Layer '+nav/text'
  Layer '+nav/tmux'
  Layer '+nav/windows'
  Layer '+scm/git'
  Layer '+specs/testing'
  Layer '+tools/format'
  Layer '+tools/language-server'
  Layer '+tools/multicursor'
  Layer '+tools/terminal'
  Layer '+ui/airline'
  Layer '+ui/toggles'

  " Language layers.
  "Layer '+lang/elm'
  "Layer '+lang/haskell' " Set backend with e.g. let g:spHaskellBackend = 'intero', in UserInit
  " Layer '+lang/javascript'
  Layer '+lang/python'
  "Layer '+lang/ruby'
  Layer '+lang/vim'

  PrivateLayer '+zen/goyo'
  PrivateLayer '+fun/emoji'
  PrivateLayer '+scm/github'

  " Additional plugins.
  " Color schemes
  ExtraPlugin 'marciomazza/vim-brogrammer-theme'
  ExtraPlugin 'nathanaelkane/vim-indent-guides'

  " This plugin alternates between relative numbering (relativenumber) and absolute numbering (number) for the active window depending on the mode you are in. In a GUI, it also functions based on whether or not the app has focus.
  ExtraPlugin 'myusuf3/numbers.vim'

  ExtraPlugin 'chrisbra/Colorizer'
  ExtraPlugin 'digitaltoad/vim-pug'
  ExtraPlugin 'dylanaraps/wal.vim'
  ExtraPlugin 'edkolev/tmuxline.vim'
  ExtraPlugin 'amadeus/vim-jsx'
  ExtraPlugin 'rhysd/vim-grammarous'
  ExtraPlugin 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
  " Syntax highlighting and support for styled components
  ExtraPlugin 'styled-components/vim-styled-components', { 'branch': 'develop' }
  ExtraPlugin 'szw/vim-g'
  ExtraPlugin 'terryma/vim-smooth-scroll' " Smooth scroll in Vim - easier to use C-b, C-f, C-u, C-d
  ExtraPlugin 'zoubin/vim-gotofile'
  ExtraPlugin 'vimwiki/vimwiki'

  ExtraPlugin 'plasticboy/vim-markdown'
  ExtraPlugin 'JamshedVesuna/vim-markdown-preview'

  ExtraPlugin 'vim-scripts/ScreenShot'
  ExtraPlugin 'chemzqm/vim-jsx-improve'
  ExtraPlugin 'heavenshell/vim-jsdoc'
  ExtraPlugin 'christoomey/vim-conflicted'
endfunction

function! UserInit()
  " This block is called at the very startup of Spaceneovim initialization
  " before layers configuration.
  let g:polyglot_disabled = ['css', 'js', 'jsx']
endfunction

function! UserConfig()
  " This block is called after Spaceneovim layers are configured.
  " set termguicolors

  " Disable swap files
  set noswapfile

  " No backup (use Git instead)
  set nobackup

  " Prevents automatic write backup
  set nowritebackup

  SetThemeWithBg 'dark', 'brogrammer'
  " set t_Co=256
  " set nu

  let g:indent_guides_guide_size = 1
  let g:indent_guides_color_change_percent = 3
  let g:indent_guides_enable_on_vim_startup = 1

  " loading the plugin
  let g:webdevicons_enable = 1

  " adding the flags to NERDTree
  "
  " ctrlp glyphs
  let g:webdevicons_enable_ctrlp = 1
  let g:webdevicons_enable_nerdtree = 1

  syntax match spaces /    / conceal cchar=  "Don't forget the space after cchar!
  set concealcursor=nvi
  set conceallevel=1

  if executable('ag')
    " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
    set grepprg=ag\ --nogroup\ --nocolor
    " Use ag in CtrlP for listing files. Lightning fast, respects .gitignore
    " and .agignore. Ignores hidden files by default.
    let g:ctrlp_user_command = 'ag %s -l --nocolor -f -g ""'
  else
    "ctrl+p ignore files in .gitignore
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  endif
  " set shell=/bin/bash

  " Put this in vimrc or a plugin file of your own.
  " After this is configured, :ALEFix will try and fix your JS code with ESLint.
  let g:syntastic_javascript_checkers = ['prettier-eslint', 'prettier', 'eslint']

  " FastFold settings
  let vim_markdown_preview_browser='Firefox'
  " let vim_markdown_preview_github=1
  " let g:markdown_folding = 1
  " let g:tex_fold_enabled = 1
  " let g:vimsyn_folding = 'af'
  " let g:xml_syntax_folding = 1
  " let g:javaScript_fold = 1
  " let g:sh_fold_enabled= 7
  " let g:ruby_fold = 1
  " let g:perl_fold = 1
  " let g:perl_fold_blocks = 1
  " let g:r_syntax_folding = 1
  " let g:rust_fold = 1
  " let g:php_folding = 1

  let g:markdown_fenced_languages = ['css', 'js=javascript']

  " let g:ale_linters_explicit = 1
  " let g:ale_javascript_eslint_executable = 'eslint'
  " let g:ale_fix_on_save = 1
  " let g:ale_set_loclist = 0
  " let g:ale_set_quickfix = 1
  " let g:ale_list_window_size = 5
  " let g:ale_statusline_format = ['E•%d', 'W•%d', 'OK']
  " let g:ale_echo_msg_format = '[%linter%] %code% %s'
  " let g:ale_javascript_prettier_use_local_config = 1
  " let g:ale_javascript_prettier_options = '--config-precedence prefer-file --single-quote --no-bracket-spacing --no-editorconfig --print-width ' . &textwidth . ' --prose-wrap always --trailing-comma all --no-semi'
  " Auto update the option when textwidth is dynamically set or changed in a ftplugin file
  " au! OptionSet textwidth let g:ale_javascript_prettier_options = '--config-precedence prefer-file --single-quote --no-bracket-spacing --no-editorconfig --print-width ' . &textwidth . ' --prose-wrap always --trailing-comma all --no-semi'

  " Don't auto fix (format) files inside `node_modules`, `forks` directory or minified files, or jquery files :shrug:
  let g:ale_linter_aliases = {
        \ 'mail': 'markdown',
        \ 'html': ['html', 'css'],
        \ 'jsx': 'css',
        \ 'txt': 'txt'
        \}

  "  AVAILABLE LINTERS
  "  'eslint'
  "  'importjs'
  "  'prettier'
  "  'prettier_eslint', 'prettier-eslint'
  "  'prettier_standard', 'prettier-standard'
  "  'remove_trailing_lines'
  "  'standard'
  "  'trim_whitespace'
  "  'xo'

  " let g:ale_linters = {
  "       \ 'javascript': ['eslint', 'flow', 'importjs', 'prettier_eslint', 'remove_trailing_lines', 'trim_whitespace'],
  "       \ 'markdown': ['write-good'],
  "       \}

  " let g:ale_fixers = {
  "       \   'txt': [
  "       \       'write-good',
  "       \   ],
  "       \   'markdown': [
  "       \       'prettier',
  "       \   ],
  "       \   'javascript': [
  "       \       'prettier',
  "       \        'prettier-eslint',
  "       \        'eslint'
  "       \   ],
  "       \   'css': [
  "       \       'prettier',
  "       \   ],
  "       \   'json': [
  "       \       'prettier',
  "       \   ],
  "       \   'scss': [
  "       \       'prettier',
  "       \   ],
  "       \   'reason': [
  "       \       'refmt',
  "       \   ],
  "       \}

  " Don't auto fix (format) files inside `node_modules`, `forks` directory, minified files and jquery (for legacy codebases)
  " let g:ale_pattern_options_enabled = 1
  " let g:ale_pattern_options = {
  "       \   '\.min\.(js\|css)$': {
  "       \       'ale_linters': [],
  "       \       'ale_fixers': []
  "       \   },
  "       \   'jquery.*': {
  "       \       'ale_linters': [],
  "       \       'ale_fixers': []
  "       \   },
  "       \   'node_modules/.*': {
  "       \       'ale_linters': [],
  "       \       'ale_fixers': []
  "       \   },
  "       \   'package.json': {
  "       \       'ale_fixers': []
  "       \   },
  "       \   'Sites/forks/.*': {
  "       \       'ale_fixers': []
  "       \   },
  "       \}

  " *.js treated as *.jsx
  let g:jsx_ext_required = 1

  "This unsets the "last search pattern" register by hitting return
  nnoremap <CR> :noh<CR><CR>

  let g:gotofile_extensions = ['js', 'jsx', 'es6', 'css', 'scss', 'sass']
  " lookup the `style` field first instead of the `main` field in the package.json
  au BufNewFile,BufRead *.css,*.scss,*.sass call gotofile#SetOptions({
        \ 'alwaysTryRelative': 1,
        \ 'main': 'style',
        \ 'extensions': ['.css', '.scss', '.sass'],
        \ 'moduleDirectory': ['node_modules', 'web_modules']
        \ })

  " Airline settings
  let g:airline_theme                       = 'atomic'
  " let g:airline_powerline_fonts             = 1
  " let g:airline#extensions#tabline#enabled  = 1
  " let g:airline#extensions#tabline#fnamemod = ':t'
  " call airline#parts#define_accent('mode', 'black')

  " Rename title of tmux tab with current filename
  if exists('$TMUX')
    autocmd BufEnter * call system("tmux rename-window '" . expand("%:t") . "'")
    autocmd VimLeave * call system("tmux setw automatic-rename")
  endif

  " Last, previous and next window; and only one window
  nnoremap <silent> <C-w>l :wincmd p<CR>:echo "Last window."<CR>
  nnoremap <silent> <C-w>p :wincmd w<CR>:echo "Previous window."<CR>
  nnoremap <silent> <C-w>n :wincmd W<CR>:echo "Next window."<CR>
  nnoremap <silent> <C-w>o :wincmd o<CR>:echo "Only one window."<CR>

  " Move between Vim windows and Tmux panes
  " - It requires the corresponding configuration into Tmux.
  " - Check it at my .tmux.conf from my dotfiles repository.
  " - URL: https://github.com/gerardbm/dotfiles/blob/master/tmux/.tmux.conf
  " - Plugin required: https://github.com/christoomey/vim-tmux-navigator
  nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
  nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
  nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
  nnoremap <silent> <M-l> :TmuxNavigateRight<CR>
  nnoremap <silent> <M-p> :TmuxNavigatePrevious<CR>


  noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
  noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
  noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
  noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

  autocmd CursorHold * silent call CocActionAsync('highlight')
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  nmap <silent> gr <Plug>(coc-references)
  let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
  let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
  inoremap <silent><expr> <c-space> coc#refresh()

  nnoremap FF :ALEFix eslint<Enter>
endfunction

" Do NOT remove these calls!
call spaceneovim#init()
call Layers()
call UserInit()
call spaceneovim#bootstrap()
call UserConfig()

augroup AutoCommands
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END


