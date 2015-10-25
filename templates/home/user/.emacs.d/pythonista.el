;; ;; Python mode settings
(require 'python-mode)
(require 'autopair)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; Insert a colon and indent accordingly.
(setq py-electric-colon-active t)
;; Split window horizontally on C-c C-c (default is vertically)
(setq py-split-windows-on-execute-function 'split-window-horizontally)
;; Opening braces/quotes are autopaired;
;; closing braces/quotes are autoskipped;
(add-hook 'python-mode-hook 'autopair-mode)

(require 'jedi-core)
;; It's also required to run "pip install --user jedi" and "pip
;; install --user epc" to get the Python side of the library work
;; correctly.

(require 'company)
(add-hook 'python-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-.") #'jedi:goto-definition)
	    (local-set-key (kbd "C-,") #'jedi:goto-definition-pop-marker)
	    (local-set-key (kbd "C-c d") #'jedi:show-doc)
	    (add-to-list 'company-backends 'company-jedi)))

;; Python2/Flake8 as a default Python linter
(setq flycheck-python-flake8-executable "/usr/bin/flake8-python2")
