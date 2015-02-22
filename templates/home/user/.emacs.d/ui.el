;; default font size
(set-face-attribute 'default nil :height 100)

;; Pretty buffer names for duplicate filenames
(require 'uniquify) 
(setq 
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;; Column and line numbers
(column-number-mode 1)
(global-linum-mode)
