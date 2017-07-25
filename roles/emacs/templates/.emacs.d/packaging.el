(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

(el-get-bundle ace-window)
(el-get-bundle flycheck)
(el-get-bundle ein)
(el-get-bundle magit
  (progn (require 'magit)
         (global-set-key (kbd "C-c g") 'magit-status)))
(el-get-bundle yasnippet)
(el-get-bundle projectile
  (progn (require 'projectile)
         (projectile-global-mode)))
(el-get-bundle neotree
  (progn (require 'projectile)
         (global-set-key [f8] 'neotree-toggle)))
(el-get-bundle company-mode)
(el-get-bundle ag)
(el-get-bundle popwin
  (progn (require 'popwin)
         (popwin-mode 1)
         (global-set-key (kbd "C-z") popwin:keymap)))
(el-get-bundle direx)
(el-get-bundle editorconfig
  (progn (require 'editorconfig)
         (editorconfig-mode 1)))
(el-get-bundle frame-cmds)
(el-get-bundle zoom-frm)

;; passwords & encryption
(el-get-bundle password-store)
(el-get-bundle auth-password-store)

;; markups
(el-get-bundle markdown-mode)
(el-get-bundle web-mode
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)))

;; python
(el-get-bundle virtualenvwrapper)
(el-get-bundle jedi-core)
(el-get-bundle company-jedi)
(el-get-bundle jedi-direx)

;; lisp
(el-get-bundle slime)

;; rust
(el-get-bundle rust-mode)
(el-get-bundle emacs-racer)
(el-get-bundle flycheck-rust)
(el-get-bundle rust-mode)
(el-get-bundle cargo)
;; company-racer
;; rustfmt
