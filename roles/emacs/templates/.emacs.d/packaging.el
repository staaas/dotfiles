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
(el-get-bundle magit)
(el-get-bundle yasnippet)
(el-get-bundle autopair)
(el-get-bundle projectile)
(el-get-bundle neotree)
(el-get-bundle company-mode)
(el-get-bundle ag)

;; 	;; passwords & encryption
;; 	password-store  ;; missing
;; 	auth-password-store  ;; missing

;; python
(el-get-bundle virtualenvwrapper)
(el-get-bundle jedi-core)
(el-get-bundle company-jedi)

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
