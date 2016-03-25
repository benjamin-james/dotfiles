;;; style.el --- Summary
;;;
;;; Commentary:
;;; My coding styles
;;;
;;; Code:

(setq-default indent-tabs-mode t
              tab-width 8
              c-default-style "ben-style")

(req-package dtrt-indent
  :config
  (dtrt-indent-mode 1))

(provide 'style)
;;; style.el ends here
