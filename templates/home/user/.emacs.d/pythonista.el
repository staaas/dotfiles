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

;; ;; Jedi settings
(require 'jedi)
;; It's also required to run "pip install --user jedi" and "pip
;; install --user epc" to get the Python side of the library work
;; correctly.
;; With the same interpreter you're using.

;; if you need to change your python intepreter, if you want to change it
;; (setq jedi:server-command
;;       '("python2" "/home/andrea/.emacs.d/elpa/jedi-0.1.2/jediepcserver.py"))

(setq jedi:setup-keys t)

(require 'company)
(add-hook 'python-mode-hook
	  (lambda ()
	    (jedi:setup)
	    (jedi:ac-setup)
	    (add-to-list 'company-backends 'company-jedi)))

;; Python2/Flake8 as a default Python linter
(setq flycheck-python-flake8-executable "/usr/bin/flake8-python2")
