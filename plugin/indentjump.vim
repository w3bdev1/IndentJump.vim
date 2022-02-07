if exists("g:loaded_indentjump")
  finish
endif
let g:loaded_indentjump = 1

function! s:IndentJumpLine(linechange) abort
" Get indentation level of current line
	let l:CurrentLine = getcurpos()[1]
	let l:IndentLevel = indent(l:CurrentLine)

" Find last continuous indentation
	let l:NewIndentLevel = l:IndentLevel
	let l:LineToCheck = l:CurrentLine

	while l:NewIndentLevel == l:IndentLevel
		let l:LineToCheck = l:LineToCheck + a:linechange
		if (s:IsLineEmpty(l:LineToCheck))
			break
		endif
		let l:NewIndentLevel = indent(l:LineToCheck)
	endwhile

	return l:LineToCheck - a:linechange
endfunction

function! s:IsLineEmpty(line) abort
	return trim(getline(a:line)) == ''
endfunction

nmap <silent> <Plug>(Indent-Jump-Forward) :exec(":" .. <SID>IndentJumpLine(1))<CR>
nmap <silent> <Plug>(Indent-Jump-Backward) :exec(":" .. <SID>IndentJumpLine(-1))<CR>
