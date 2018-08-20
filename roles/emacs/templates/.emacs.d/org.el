(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files '("~/org"))

;; Add a way to open links in Chrome (which is non-default browser)
;; by prefixing URLs with chrome:, e.g. chrome:https://mozilla.org
(org-link-set-parameters "chrome" :follow (lambda (path) (browse-url-chrome path)))
