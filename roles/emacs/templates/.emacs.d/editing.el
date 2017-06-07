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

;; Snippets
(require 'yasnippet)
(yas-global-mode 1)
(yas/load-directory "~/.emacs.d/snippets")

;; company mode
(global-company-mode)
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 1)

;; flycheck-mode
(add-hook 'after-init-hook #'global-flycheck-mode)

;; use 4 spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(require 'direx)
(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)

;; Resizing frame font
(require 'zoom-frm)
(define-key ctl-x-map [(control ?+)] 'zoom-in/out)
(define-key ctl-x-map [(control ?-)] 'zoom-in/out)
(define-key ctl-x-map [(control ?=)] 'zoom-in/out)
(define-key ctl-x-map [(control ?0)] 'zoom-in/out)
(toggle-zoom-frame)
