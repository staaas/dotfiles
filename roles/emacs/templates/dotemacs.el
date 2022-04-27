;;; .emacs --- Initialization file for Emacs

;;; Commentary:

;; Emacs Startup File --- initialization for Emacs

;;; Code:

;; Early start configuration
;; -------------------------

;; Ignoring warning "Unnecessary call to ‘package-initialize’ in init file"
;; until https://github.com/cask/cask/issues/463 is resolved
;; TODO: revert
(setq warning-minimum-level :emergency)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq
 inhibit-startup-screen t
 inhibit-splash-screen t)

(require 'use-package)
(require 'package)
(add-to-list 'package-archives
             '("MELPA" . "https://stable.melpa.org/packages/") t)

;; Configuration of builtin emacs features
;; ---------------------------------------

(setq
 indent-tabs-mode nil
 tab-width 4
 column-number-mode t
 select-enable-clipboard t)
(setq-default
 show-trailing-whitespace t)

;; enable C-x C-u and C-x C-l
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; save backup versions of modified buffers in a single directory
;; (the default configuration puts them next to the edited files)
(make-directory "~/.emacs.d/saves/" t)
(setq
   backup-by-copying t
   backup-directory-alist
    '(("." . "~/.emacs.d/saves/"))
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)

;; Highlight matching pairs of parentheses
(setq show-paren-delay 0)
(show-paren-mode)

;; Pretty buffer names for duplicate filenames
(use-package ido
  :config
  (ido-mode 1)
  (ido-everywhere)
  (setq ido-enable-flex-matching t))

;; Display duplicate buffer names properly
(use-package uniquify
  :config
  (setq
   uniquify-buffer-name-style 'post-forward
   uniquify-separator ":"))

;; Enable line numbers
(use-package linum
  :config (global-linum-mode))

(use-package python
  :init
  ;; we need setq-default instead of setq because this is a buffer local variable
  ;; TODO: make it work (it used to!)
  (setq-default py-split-windows-on-execute-function 'split-window-horizontally))

;; Org mode settings
(use-package org
  :hook (org-mode . org-indent-mode)
  :init
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (setq
    org-log-done t
    org-agenda-files '("~/org")
    org-export-with-section-numbers nil)
  ;; eval plantuml diagrams without asking for confirmations
  (defun stas/org-confirm-babel-evaluate (lang body)
    (not (string= lang "plantuml")))
  (setq org-confirm-babel-evaluate 'stas/org-confirm-babel-evaluate))

;; Configuration of external packages
;; ----------------------------------

(use-package org-download
  :ensure t
  :config
  (add-hook 'dired-mode-hook 'org-download-enable))

(use-package org-roam
      :ensure t
      :init
      (setq org-roam-v2-ack t)
      (setq org-roam-capture-templates
	    '(("d" "default" plain "%?" :target
	       (file+head "${slug}-%<%Y%m%d%H%M%S>.org"
			  "#+title: ${title}\n#+TODO: TODO(t) | DONE(d) SCHEDULED(s) RESCHEDULED(r)\n\n")
	       :unnarrowed t)))
      (setq org-roam-dailies-capture-templates
	    '(("d" "default" plain "%?" :target
	       (file+head "%<%Y-%m-%d>.org"
			  "#+title: %<%Y-%m-%d>\n#+TODO: TODO(t) | DONE(d) SCHEDULED(s) RESCHEDULED(r)\n\n* Tasks\n* Meeting Notes\n")
	       :unnarrowed t)))
      :hook
      (after-init . org-roam-db-autosync-mode)
      :custom
      (org-roam-directory "~/org")
      (org-roam-db-location "~/.emacs.d/.org-roam.db")
       :bind (("C-c n l" . org-roam-buffer-toggle)
              ("C-c n f" . org-roam-node-find)
              ("C-c n d" . org-roam-dailies-goto-date)
              ("C-c n r" . org-roam-dailies-goto-tomorrow)
              ("C-c n t" . org-roam-dailies-goto-today)
              ("C-c n y" . org-roam-dailies-goto-yesterday)
              :map org-mode-map
              ("C-c n i" . org-roam-node-insert)))

(use-package ob-http
  :ensure t)

(use-package ox-gfm
  :ensure t)

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package editorconfig
  :ensure t
  :config (editorconfig-mode 1))

(use-package projectile
  :ensure t
  :init
  (setq projectile-keymap-prefix (kbd "C-c p")
	projectile-switch-project-action 'projectile-dired)
  :hook (after-init . projectile-global-mode))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (yas-load-directory "~/.emacs.d/snippets"))

(use-package company
  :ensure t
  :hook (after-init . global-company-mode))

(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode))

(use-package ace-window
  :ensure t
  :bind ("M-p" . ace-window))

(use-package ripgrep
  :ensure t)

(use-package web-mode
  :ensure t
  :mode ("\\.html$" . web-mode))

(use-package plantuml-mode
  :ensure t
  :init
  (setq plantuml-default-exec-mode 'jar)
  (setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
  (setq org-plantuml-jar-path plantuml-jar-path)
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t))))

(use-package markdown-mode
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook ((rust-mode . lsp))
  :config
  (setq lsp-headerline-breadcrumb-enable nil)
  :commands lsp)

(use-package lsp-pyright
  :ensure t
  :config
  (setq
   lsp-pyright-disable-organize-imports nil
   lsp-pyright-auto-import-completions nil
   lsp-pyright-diagnostic-mode "openFilesOnly"
   lsp-pyright-auto-search-paths nil
   lsp-pyright-typechecking-mode "off")
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-enable nil))

(use-package rust-mode
  :ensure t
  :mode ("\\.rs\\$" . rust-mode)
  :init
  (setq lsp-rust-server 'rust-analyzer))

(provide '.emacs)
;;; .emacs ends here
