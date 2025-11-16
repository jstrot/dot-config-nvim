" From https://raw.githubusercontent.com/Futarimiti/nvim/nightly/after/ftplugin/markdown/toc.vim
" adapted from $VIMRUNTIME/ftplugin/help.vim

" collect #+ headers for an outline.
" each header may be indented with 0-3 spaces,
" starts with at least one #, followed by at least one space, then text as title.

" turn a header into TOC format; every # turns into 2 spaces
" "# Title" -> "Title"
" "## Introduction" -> "  Introduction"
" "###  Acknowledgement" -> "    Acknowledgement"
function s:fmt_line(line) abort
  let captures = matchlist(a:line, '\v^\s*(#+)\s+(.*)')
  let hashes = len(captures[1])
  let indent = repeat('  ', hashes - 1)
  let title = captures[2]
  return indent .. title
endfunction

" NOTE: For a TOC window, use the LSP-based `gO` mapping

" Personally, I prefer to have wrapping and spell checking in markdown files:
"setl wrap
"setl spell
