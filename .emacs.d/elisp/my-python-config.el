;;; my-python-config.el --- Summary
;;;
;;; Commentary:
;;; Python config
;;;
;;; Code:

(defvar python-indent-offset tab-width)

(req-package company-jedi
  :config
  (add-to-list 'company-backends '(company-jedi company-files)))

(defun my-python-replize ()
  "Buffer contents are sent to Python REPL."
  (interactive)
  (python-shell-send-buffer)
  (python-shell-switch-to-shell))

(eval-after-load "python"
  '(progn
     (define-key python-mode-map (kbd "<f6>") 'my-python-replize)
     (define-key python-mode-map (kbd "C-h m") 'python-eldoc-at-point)))

(provide 'my-python-config)
;;; my-python-config.el ends here
