" Author: Sven-Hendrik Haase <svenstaro@gmail.com>
" Description: glslang-based linter for glsl files
"
" TODO: Once https://github.com/KhronosGroup/glslang/pull/1047 is accepted,
" we can use stdin.

call ale#Set('glsl_glslang_executable', 'glslangValidator')
call ale#Set('glsl_glslang_options', '')

function! ale_linters#glsl#glslang#GetCommand(buffer) abort
    return '%e'
    \   . ale#Pad(ale#Var(a:buffer, 'glsl_glslang_options'))
    \   . ' -C %t'
endfunction

function! ale_linters#glsl#glslang#Handle(buffer, lines) abort
    " Matches patterns like the following:
    "
    " ERROR: 0:5: 'foo' : undeclared identifier
    " or when using options like -V or -G or --target-env
    " ERROR: filename:5: 'foo' : undeclared identifier
    let l:pattern = '^\(.\+\): \(.\+\):\(\d\+\): \(.\+\)'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \   'lnum': str2nr(l:match[3]),
        \   'col' : 0,
        \   'text': l:match[4],
        \   'type': l:match[1] is# 'ERROR' ? 'E' : 'W',
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('glsl', {
\   'name': 'glslang',
\   'executable': {b -> ale#Var(b, 'glsl_glslang_executable')},
\   'command': function('ale_linters#glsl#glslang#GetCommand'),
\   'callback': 'ale_linters#glsl#glslang#Handle',
\})
