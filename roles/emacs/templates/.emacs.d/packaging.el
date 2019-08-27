(require 'cask)
(cask-initialize)

(global-set-key (kbd "M-p") 'ace-window)
(add-hook 'after-init-hook #'global-flycheck-mode)

(require 'magit)
(global-set-key (kbd "C-c g") 'magit-status)

(require 'yasnippet)
(yas-global-mode 1)
(yas-load-directory "~/.emacs.d/snippets")

(require 'projectile)
(projectile-mode)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(global-company-mode)

(require 'editorconfig)
(editorconfig-mode 1)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.plantuml?\\'" . plantuml-mode))
(setq plantuml-default-exec-mode 'jar)
(setq plantuml-jar-path "/opt/plantuml/plantuml.jar")

(push 'company-lsp company-backends)

(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(require 'lsp-ui)
(require 'lsp-mode)
(setq lsp-ui-sideline-enable nil)
(add-hook 'python-mode-hook #'lsp)
(add-hook 'rust-mode-hook #'lsp)
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
