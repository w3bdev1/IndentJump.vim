" Get indentation level of current line
" Find last continuous indentation

function! IndentJumpLine() abort
" Get indentation level of current line
	let l:CurrentLine = getcurpos()[1]
	let l:IndentLevel = indent(l:CurrentLine)

" Find last continuous indentation
	let l:NewIndentLevel = l:IndentLevel
	let l:LineToCheck = l:CurrentLine

	while l:NewIndentLevel == l:IndentLevel
		let l:LineToCheck = l:LineToCheck + 1
		if (IsLineEmpty(l:LineToCheck))
			break
		endif
		let l:NewIndentLevel = indent(l:LineToCheck)
	endwhile

	return l:LineToCheck - 1
endfunction

function IsLineEmpty(line) abort
	return trim(getline(a:line)) == ''
endfunction

nmap <Plug>(Indent-Jump-Forward) :exec(":".IndentJumpLine())<CR>
