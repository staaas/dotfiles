;; ;; Python mode settings
(require 'python)
(require 'autopair)

;; Split window horizontally on C-c C-c (default is vertically)
(setq py-split-windows-on-execute-function 'split-window-horizontally)

;; Opening braces/quotes are autopaired;
;; closing braces/quotes are autoskipped;
(add-hook 'python-mode-hook 'autopair-mode)

(require 'company)
(add-hook 'python-mode-hook
          '(lambda ()
             (add-to-list 'company-backends 'company-jedi)

             (local-set-key (kbd "C-c ?") 'jedi:show-doc)
             (local-set-key (kbd "C-c .") 'jedi:goto-definition)
             (local-set-key (kbd "C-c ,") 'jedi:goto-definition-pop-marker)))

;; Python2/Flake8 as a default Python linter
(setq flycheck-python-flake8-executable "/usr/bin/flake8-python2")
