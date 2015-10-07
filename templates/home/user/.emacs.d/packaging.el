;; make more packages available with the package installer
(setq to-install
      '(
	ace-window  ;; switching between windows
	flycheck
	ein
	magit
	yasnippet
	autopair
	find-file-in-repository
	projectile
	neotree
	company
	;; python
	python-mode
	jedi
	company-jedi
	;; lisp
	slime
	;; rust
	rust-mode
	company-racer
	racer
	flycheck-rust
	rust-mode
	))

(require 'package)
(package-initialize)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(defun install-if-needed (package)
  (unless (package-installed-p package)
    (package-install package)))

(defun my-filter (condp lst)
  (delq nil
	(mapcar (lambda (x) (and (funcall condp x) x)) lst)))

(message "%s" "Refreshing package index")
(if (my-filter (lambda (package) (not (package-installed-p package))) to-install)
    (package-refresh-contents))

(message "%s" "Installing packages...")
(mapc 'install-if-needed to-install)
(message "%s" " done\n")
