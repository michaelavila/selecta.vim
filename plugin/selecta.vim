" Always ignore the following directories
let ignore = [".git/"]
let excludes=join(map(ignore, '"-not -path \"*" . v:val . "*\""'))

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
  exec a:vim_command . " " . selection
endfunction

function! SelectaFromList(choices, selecta_args, vim_command)
  let non_blank_choices = filter(a:choices, 'v:val !=""')
  call SelectaCommand('echo "' . join(non_blank_choices, "\n") . '"', a:selecta_args, a:vim_command)
endfunction

function! SelectaFile()
  call SelectaCommand('find . -type f ' . g:excludes, '', ':e')
endfunction

function! SelectaBuffer()
  let buffers = map(range(1, bufnr("$")), 'bufname(bufnr(v:val))')
  call SelectaFromList(buffers, "", ":b")
endfunction

function! SelectaHistoryCommand()
  let history = map(range(1, histnr("cmd")), 'histget("cmd", v:val)')
  call SelectaFromList(history, "", ":")
endfunction
