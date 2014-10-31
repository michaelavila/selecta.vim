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

function! SelectaFile()
  call SelectaCommand("find * -type f", "", ":e")
endfunction

function! SelectaBuffer()
  let buffers = []
  for i in range(1, bufnr("$"))
    call add(buffers, bufname(i))
  endfor
  let options = join(buffers, "\n")
  call SelectaCommand('echo "' . options . '"', "", ":e")
endfunction
