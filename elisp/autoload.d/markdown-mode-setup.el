(defconst mt-syntaxhighlighter-regex
  "\\[code:[^]]+][^[]*\\(\\[+\\(/code[^]]\\|/cod[^e]\\|/co[^d]\\|/c[^o]\\|/[^c]\\|[^/]\\)[^[]*\\)*\\[/code]"
  "Regular expression for matching MTSyntaxHighlighter plugin stuff.")

(setq markdown-mode-font-lock-keywords
         (cons (cons mt-syntaxhighlighter-regex 'markdown-pre-face) markdown-mode-font-lock-keywords))
