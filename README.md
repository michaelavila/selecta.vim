# selecta

A pathogen friendly script for [selecta](https://github.com/garybernhardt/selecta)

Add the following to your vimrc to use selecta:

    " Find all files in all non-dot directories starting in the working directory.
    " Fuzzy select one of those. Open the selected file with :e.
    nnoremap <leader>e :call SelectaFile()<cr>

    " Find all buffers that have been opened.
    " Fuzzy select one of those. Open the selected file with :b.
    nnoremap <leader>b :call SelectaBuffer()<cr>

    " Find previously run commands.
    " Fuzzy select one of those. Run that command with :
    nnoremap <leader>h :call SelectaHistoryCommand()<cr>

All credit goes to @garybernhardt
