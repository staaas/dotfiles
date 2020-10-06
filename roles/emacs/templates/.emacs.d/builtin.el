;; Pretty buffer names for duplicate filenames
(require 'uniquify) 
(setq 
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;; Column and line numbers
(column-number-mode 1)
(global-linum-mode)

;; Fast file access
(ido-mode t)

;; makes killing/yanking interact with clipboard X11 selection
(setq x-select-enable-clipboard t)

;; Saving temporary backup files to a separate dir
(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))

;; use 4 spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; enable C-x C-u and C-x C-l
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; isearch settings
(setq search-highlight t)
(setq search-whitespace-regexp ".*?")
(setq isearch-lax-whitespace t)
(setq isearch-regexp-lax-whitespace nil)
(setq isearch-lazy-highlight t)

;; Python mode settings
(require 'python)
;; Split window horizontally on C-c C-c (default is vertically)
(setq py-split-windows-on-execute-function 'split-window-horizontally)

;; Org mode settings
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files '("~/org"))
;; Add a way to open links in Chrome (which is non-default browser)
;; by prefixing URLs with chrome:, e.g. chrome:https://mozilla.org
(org-link-set-parameters "chrome" :follow (lambda (path) (browse-url-chrome path)))
;; Better experience when working with images
(setq org-display-inline-images t)
(setq org-redisplay-inline-images t)
(setq org-startup-with-inline-images "inlineimages")
