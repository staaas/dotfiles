;; Ignoring warning "Unnecessary call to ‘package-initialize’ in init file"
;; until https://github.com/cask/cask/issues/463 is resolved
;; TODO: revert
(setq warning-minimum-level :emergency)

(load-file "~/.emacs.d/startup.el")
(load-file "~/.emacs.d/builtin.el")
(load-file "~/.emacs.d/external.el")
