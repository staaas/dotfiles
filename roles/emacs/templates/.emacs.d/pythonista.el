;; ;; Python mode settings
(require 'python-mode)
(require 'autopair)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; Split window horizontally on C-c C-c (default is vertically)
(setq py-split-windows-on-execute-function 'split-window-horizontally)
;; Opening braces/quotes are autopaired;
;; closing braces/quotes are autoskipped;
(add-hook 'python-mode-hook 'autopair-mode)

(require 'company)
(add-hook 'python-mode-hook
	  (lambda ()
	    (anaconda-mode)
	    (eldoc-mode)
	    (add-to-list 'company-backends 'company-jedi)))

;; Python2/Flake8 as a default Python linter
(setq flycheck-python-flake8-executable "/usr/bin/flake8-python2")
