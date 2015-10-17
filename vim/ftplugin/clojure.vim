" This came from Greg V's dotfiles:
"      https://github.com/myfreeweb/dotfiles
" Feel free to steal it, but attribution is nice
" 
" Thanks:
" see vimrc +
" https://gist.github.com/519858

setlocal expandtab

function! GetClojureFold()
	if getline(v:lnum) =~ '^\s*(defn.*\s'
		return ">1"
	elseif getline(v:lnum) =~ '^\s*(def.*\s'
		return ">1"
	elseif getline(v:lnum) =~ '^\s*(deftest.*\s'
		return ">1"
	elseif getline(v:lnum) =~ '^\s*(it.*\s'
		return ">1"
	elseif getline(v:lnum) =~ '^\s*(fact.*\s'
		return ">1"
	elseif getline(v:lnum) =~ '^\s*(defapp.*\s'
		return ">1"
	elseif getline(v:lnum) =~ '^\s*(defresource.*\s'
		return ">1"
	elseif getline(v:lnum) =~ '^\s*(defmacro.*\s'
		return ">1"
	elseif getline(v:lnum) =~ '^\s*(defmethod.*\s'
		return ">1"
	elseif getline(v:lnum) =~ '^\s*$'
		let my_cljnum = v:lnum
		let my_cljmax = line("$")

		while (1)
			let my_cljnum = my_cljnum + 1
			if my_cljnum > my_cljmax
				return "<1"
			endif

			let my_cljdata = getline(my_cljnum)

			" If we match an empty line, stop folding
			if my_cljdata =~ '^$'
				return "<1"
			else
				return "="
			endif
		endwhile
	else
		return "="
	endif
endfunction

setlocal foldexpr=GetClojureFold()
setlocal foldmethod=expr
