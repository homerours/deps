" ===============================================================
" OceanicNext
" Language: XML
" Description: Overrides for XML
" Author: Mike Hartington
" Last Change: 2016/12/11 17:28
" ===============================================================

syn region xmlEndTag
      \ start=+</+
      \ end=+>+
      \ contains=xmlTagName
syn match xmlTagName
      \ contained +</\s*[-a-zA-Z0-9]\++hs=s+2
