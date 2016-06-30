;;; my-php-config.el --- Summary
;;;
;;; Commentary:
;;; This holds php stuff
;;;
;;; Code:

(req-package php-mode)

(req-package company-php
  :require company
  :config
  (add-hook 'php-mode-hook
         '(lambda ()
            (require 'company-php)
            (company-mode t)
            (add-to-list 'company-backends 'company-ac-php-backend ))))

(req-package php-eldoc)

(provide 'my-php-config)
;;; my-php-config.el ends here
