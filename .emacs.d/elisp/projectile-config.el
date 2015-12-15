;;; projectile-config.el --- Summary
;;;
;;; Commentary:
;;; Config for projectile and related modes
;;;
;;; Code:

;;; https://tuhdo.github.io/helm-projectile.html

(req-package projectile
	     :config
	     (setq projectile-enable-caching t)
	     (setq projectile-indexing-method 'alien)
	     :init
	     (projectile-global-mode))

(req-package projectile-speedbar
	     :require projectile)

(provide 'projectile-config)
;;; projectile-config.el ends here
