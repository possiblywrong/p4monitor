syn match P4Head /^.\{-}'/ contains=P4ChangeStr,P4on,P4by,P4Year,P4Workspace,P4ChangeNum,P4User,P4Mday,P4Pending
syn match P4ChangeStr /^Change/ contained conceal
syn match P4on /on / contained conceal
syn match P4by / by/ contained conceal
syn match P4Year /\d\{4}\// contained conceal
syn match P4Workspace /@\S*/ contained conceal
syn match P4ChangeNum / \d\{-} / contained
syn match P4User / [a-z]\{3,}/ contained
syn match P4Mday /\d\{2}\/\d\{2}/ contained
syn match P4Pending /\*pending\*/ contained
hi! link P4ChangeNum Identifier
hi! link P4User Comment
hi! link P4Mday Delimiter
hi! link P4Pending Title
let b:buffer_syntax = "p4mon"
