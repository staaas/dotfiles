b
;;; .emacs --- Initialization file for Emacs

;;; Commentary:

;; Emacs Startup File --- initialization for Emacs

;;; Code:

;; Early start configuration
;; -------------------------

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq
 inhibit-startup-screen t
 inhibit-splash-screen t)

(add-to-list 'default-frame-alist '(font . "Source Code Pro-12" ))

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
;; changes how C-x b works with dedicated windows
(setq switch-to-buffer-obey-display-actions t)
(defun stas/toggle-window-dedication ()
  "Toggle window dedication in the selected window."
  (interactive)
  (set-window-dedicated-p (selected-window)
     (not (window-dedicated-p (selected-window)))))

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
  ;; add ditaa support
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ditaa . t)))
  (setq org-ditaa-jar-path "/usr/share/java/ditaa/ditaa-0.11.jar")
  ;; eval plantuml diagrams without asking for confirmations
  (defun stas/org-confirm-babel-evaluate (lang body)
    (not (string-match "\\(plantuml\\|ditaa\\)"  lang)))
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

(use-package org-transclusion
  :ensure t
  :after (org)
  :init (setq org-transclusion-extensions
	      '(org-transclusion-src-lines
		org-transclusion-font-lock
		org-transclusion-indent-mode)))

(use-package ob-http
  :ensure t)

(use-package ox-gfm
  :ensure t)

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map))
  :config
  (setq projectile-switch-project-action 'projectile-commander)
  (def-projectile-commander-method ?s
    "Search in project."
    (call-interactively #'projectile-ripgrep))
  (define-key projectile-command-map (kbd "s") #'projectile-ripgrep))

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

(use-package eglot
  :ensure t
  :config
  (add-to-list 'eglot-server-programs '(rust-mode . ("rust-analyzer"))))

(use-package rust-mode
  :ensure t
  :mode ("\\.rs\\$" . rust-mode)
  :hook (rust-mode . eglot-ensure))

(use-package python
  :hook (python-mode . eglot-ensure))

(use-package protobuf-mode
  :ensure t
  :mode (("\\.proto\\'" . protobuf-mode)
	 ("\\.proto3\\'" . protobuf-mode)))

(use-package languagetool
  :ensure t
  :commands (languagetool-check
             languagetool-clear-suggestions
             languagetool-correct-at-point
             languagetool-correct-buffer
             languagetool-set-language
             languagetool-server-mode)
  :config
  (setq languagetool-java-arguments '("-Dfile.encoding=UTF-8"
				      "-cp"
				      "/usr/share/languagetool:/usr/share/java/languagetool/*")
        languagetool-console-command "org.languagetool.commandline.Main"))

(provide '.emacs)
;;; .emacs ends here
