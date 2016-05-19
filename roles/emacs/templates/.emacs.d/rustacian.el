(setq racer-cmd "~/.cargo/bin/racer")
(setq racer-rust-src-path "~/repos/rust/src/")
(setq exec-path (append exec-path '("~/.cargo/bin")))

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'rust-mode-hook
     '(lambda ()
     ;; Use flycheck-rust in rust-mode
     (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

     ;; Use company-racer in rust mode
     (set (make-local-variable 'company-backends) '(company-racer))

     ;; Key binding to jump to method definition
     (local-set-key (kbd "C-.") #'racer-find-definition)

     ;; Key binding to auto complete and indent
     (local-set-key (kbd "TAB") #'racer-complete-or-indent)

     (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))
(add-hook 'rust-mode-hook 'cargo-minor-mode)
