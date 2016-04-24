(require 'mu4e)

(setq mu4e-contexts
      `(
{% for box in boxes %}
        ,(make-mu4e-context
          :name "{{ box.name }}"
          :enter-func (lambda () (mu4e-message "Switch to context {{ box.name }}"))
          :leave-func (lambda () (mu4e-clear-caches))
          :match-func (lambda (msg)
                        (when msg
                          (mu4e-message-maildir-matches msg "/mail/{{ box.name }}")))
          :vars '( (user-mail-address . "{{ box.email | default(box.user) }}")
                   (user-full-name . "Stas Rudakou")
                   (mu4e-maildir . "~/mail/{{ box.name }}")))
{% endfor %}
        ))

(setq
 mu4e-sent-folder   "/Sent"
 mu4e-drafts-folder "/Drafts"
 mu4e-trash-folder  "/Trash"
 mu4e-refile-folder "/Archive")

(setq
 mu4e-update-interval 300
 mu4e-view-show-addresses t
 mu4e-headers-visible-lines 15
 mu4e-compose-context-policy 'ask-if-none
 mu4e-context-policy 'pick-first)

(require 'mu4e-contrib)
(setq mu4e-html2text-command 'mu4e-shr2text)
