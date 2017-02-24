if executable('clang-format40')
	setlocal formatprg=clang-format40
elseif executable('clang-format39')
	setlocal formatprg=clang-format39
elseif executable('clang-format38')
	setlocal formatprg=clang-format38
elseif executable('clang-format37')
	setlocal formatprg=clang-format37
elseif executable('clang-format')
	setlocal formatprg=clang-format
endif
