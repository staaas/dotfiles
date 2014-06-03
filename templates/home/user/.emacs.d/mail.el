(require 'mu4e)

;; these are actually the defaults
(setq
 mu4e-maildir       "~/mail/nottcc"   ;; top-level Maildir
 mu4e-sent-folder   "/Sent"       ;; folder for sent messages
 mu4e-drafts-folder "/Drafts"     ;; unfinished messages
 mu4e-trash-folder  "/Trash"      ;; trashed messages
 mu4e-refile-folder "/Archive")   ;; saved messages

(setq mu4e-view-show-addresses t)  ;; show email addresses along with names
