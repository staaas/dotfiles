(load-theme 'tango-dark t)

(set-default-font "-*-terminus-medium-r-*-*-*-140-75-75-*-*-iso10646-1")

;; Pretty buffer names for duplicate filenames
(require 'uniquify) 
(setq 
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;; Column and line numbers
(column-number-mode 1)
(global-linum-mode)
