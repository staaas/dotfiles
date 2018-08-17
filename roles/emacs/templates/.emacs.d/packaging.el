(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

(el-get-bundle ace-window  ;; Switching between windows
  (global-set-key (kbd "M-p") 'ace-window))
(el-get-bundle flycheck
  (add-hook 'after-init-hook #'global-flycheck-mode))
(el-get-bundle magit
  (progn (require 'magit)
         (global-set-key (kbd "C-c g") 'magit-status)))
(el-get-bundle yasnippet
  (progn (require 'yasnippet)
         (yas-global-mode 1)
         (yas-load-directory "~/.emacs.d/snippets")))
(el-get-bundle projectile
  (progn (require 'projectile)
         (projectile-mode)
         (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)))
(el-get-bundle company-mode
  (global-company-mode))
(el-get-bundle ag)
(el-get-bundle editorconfig
  (progn (require 'editorconfig)
         (editorconfig-mode 1)))

;; markups
(el-get-bundle markdown-mode)
(el-get-bundle web-mode
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)))

;; language server
(el-get-bundle lsp-mode)
(el-get-bundle company-lsp
  (push 'company-lsp company-backends))
(el-get-bundle lsp-ui
  (progn (add-hook 'lsp-mode-hook 'lsp-ui-mode)
         (require 'lsp-ui)
         (setq lsp-ui-sideline-enable nil)))

;; python
(el-get-bundle lsp-python
  (progn (require 'lsp-mode)
         (require 'lsp-python)
         (add-hook 'python-mode-hook #'lsp-python-enable)))

;; rust
(el-get-bundle rust-mode
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode)))
(el-get-bundle lsp-rust
  (progn (with-eval-after-load 'lsp-mode
           (setq lsp-rust-rls-command nil)
           (require 'lsp-rust)
           (add-hook 'rust-mode-hook #'lsp-rust-enable))))
(el-get-bundle cargo
  (add-hook 'rust-mode-hook 'cargo-minor-mode))
