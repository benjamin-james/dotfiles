

(add-to-list 'auto-mode-alist '("\\.\\(pl\\|pm\\)$" . cperl-mode))

(fset 'perl-mode 'cperl-mode)
(setq cperl-indent-parens-as-block t
      cperl-indent-level 8
      cperl-close-paren-offset (- cperl-indent-level)
      cperl-continued-statement-offset cperl-indent-level)



