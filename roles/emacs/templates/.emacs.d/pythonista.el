;; ;; Python mode settings
(require 'python)
(require 'autopair)

;; Split window horizontally on C-c C-c (default is vertically)
(setq py-split-windows-on-execute-function 'split-window-horizontally)

(require 'company)
(add-hook 'python-mode-hook
          '(lambda ()

             (add-to-list 'company-backends 'company-jedi)

             (local-set-key (kbd "C-c ?") 'jedi:show-doc)
             (local-set-key (kbd "C-c .") 'jedi:goto-definition)
             (local-set-key (kbd "C-c ,") 'jedi:goto-definition-pop-marker)

             (local-set-key (kbd "C-c x") 'jedi-direx:pop-to-buffer)))

(add-hook 'jedi-mode-hook 'jedi-direx:setup)

;; Python2/Flake8 as a default Python linter
(setq flycheck-python-flake8-executable "/usr/bin/flake8-python2")
