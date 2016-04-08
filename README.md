# selecta

A pathogen friendly script for [selecta](https://github.com/garybernhardt/selecta)

Add the following to your vimrc to use selecta:

    " Find all files in all non-dot directories starting in the working directory.
    " Fuzzy select one of those. Open the selected file with :e.
    nnoremap <leader>e :SelectaFile<cr>

    " As above, but will open in a :split
    nnoremap <leader>s :SelectaSplit<cr>

    " As above, but will open in a :vsplit
    nnoremap <leader>v :SelectaVsplit<cr>

    " As above, but will open in a :tabedit
    nnoremap <leader>t :SelectaTabedit<cr>

    " Find all buffers that have been opened.
    " Fuzzy select one of those. Open the selected file with :b.
    nnoremap <leader>b :SelectaBuffer<cr>

    " Find previously run commands.
    " Fuzzy select one of those. Run that command with :
    nnoremap <leader>h :SelectaHistoryCommand<cr>

If you need information about selecta.vim you can run `:help selecta` from within vim.

All credit goes to @garybernhardt
