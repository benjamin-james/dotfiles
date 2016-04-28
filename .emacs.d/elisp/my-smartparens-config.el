;;; my-smartparens-config.el --- Summary
;;;
;;; Commentary:
;;; Smartparens config file
;;;
;;; Code:


(defvar hyp-s-x-map)
(define-prefix-command 'hyp-s-x-map)

(req-package smartparens
  :require hydra
  :bind (
	 :map smartparens-mode-map
	      ("C-c f" . (lambda ()
			   (interactive)
			   (sp-beginning-of-sexp 2)))
	      ("C-c b" . (lambda ()
			   (interactive)
			   (sp-beginning-of-sexp -2)))
	      ("C-M-f" . sp-forward-sexp)
	      ("C-M-b" . sp-backward-sexp)

	      ("C-M-d" . sp-down-sexp)
	      ("C-M-a" . sp-backward-down-sexp)
	      ("C-S-d" . sp-beginning-of-sexp)
	      ("C-S-a" . sp-end-of-sexp)

	      ("C-M-e" . sp-up-sexp)
	      ("C-M-u" . sp-backward-up-sexp)
	      ("C-M-t" . sp-transpose-sexp)

	      ("C-M-n" . sp-next-sexp)
	      ("C-M-p" . sp-previous-sexp)

	      ("C-M-k" . sp-kill-sexp)
	      ("C-M-w" . sp-copy-sexp)

	      ("M-<delete>" . sp-unwrap-sexp)
	      ("M-<backspace>" . sp-backward-unwrap-sexp)

	      ("C-<right>" . sp-forward-slurp-sexp)
	      ("C-<left>" . sp-forward-barf-sexp)
	      ("C-M-<left>" . sp-backward-slurp-sexp)
	      ("C-M-<right>" . sp-backward-barf-sexp)

	      ("M-D" . sp-splice-sexp)
	      ("C-M-<delete>" . sp-splice-sexp-killing-forward)
	      ("C-M-<backspace>" . sp-splice-killing-backward)
	      ("C-S-<backspace>" . sp-splice-killing-around)

	      ("C-]" . sp-select-next-thing-exchange)
	      ("C-<left_bracket>" . sp-select-previous-thing)
	      ("C-M-]" . sp-select-next-thing)
	      ("M-F" . sp-forward-symbol)
	      ("M-B" . sp-backward-symbol)

	      ("C-x C-t" . sp-transpose-hybrid-sexp)

	      (";" sp-comment))

  :config
  (require 'smartparens-config)
  (add-hook 'minibuffer-setup-hook 'turn-on-smartparens-strict-mode))

(provide 'my-smartparens-config)
;;; my-smartparens-config.el ends here
