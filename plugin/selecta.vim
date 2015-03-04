" Always ignore the following directories
if !exists("g:SelectaIgnore")
  let SelectaIgnore = [".git/"]
endif
" Use this as the root for finding files
if !exists("g:SelectaFindRoot")
  let SelectaFindRoot = "."
endif

function! GetFindExcludes()
  return join(map(copy(g:SelectaIgnore), '"-not -path \"*" . v:val . "*\""'))
endfunction

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  if selection != ''
    exec a:vim_command . " " . selection
  endif
endfunction

function! SelectaFromList(choices, selecta_args, vim_command)
  let non_blank_choices = filter(a:choices, 'v:val !=""')
  call SelectaCommand('echo "' . escape(join(non_blank_choices, "\n"), '"') . '"', a:selecta_args, a:vim_command)
endfunction

function! SelectaFile()
  call SelectaCommand('find ' . g:SelectaFindRoot . ' -type f ' . GetFindExcludes(), '', ':e')
endfunction

function! SelectaVsplit()
  call SelectaCommand('find ' . g:SelectaFindRoot . ' -type f ' . GetFindExcludes(), '', ':vsplit') 
endfunction

function! SelectaSplit()
  call SelectaCommand('find ' . g:SelectaFindRoot . ' -type f ' . GetFindExcludes(), '', ':split') 
endfunction

function! SelectaBuffer()
  let bufnrs = filter(range(1, bufnr("$")), 'buflisted(v:val)')
  let buffers = map(bufnrs, 'bufname(v:val)')
  call SelectaFromList(buffers, "", ":b")
endfunction

function! SelectaHistoryCommand()
  let history = map(range(1, histnr("cmd")), 'histget("cmd", v:val)')
  call SelectaFromList(history, "", ":")
endfunction

command! SelectaFile call SelectaFile()
command! SelectaSplit call SelectaSplit()
command! SelectaVsplit call SelectaVsplit()
command! SelectaBuffer call SelectaBuffer()
command! SelectaHistoryCommand call SelectaHistoryCommand()

