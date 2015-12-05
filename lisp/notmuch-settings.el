
(require 'gnus-art)

;; (defun notmuch-show-filter-thread (thread)
;;   "Show the current thread with a different filter"
;;   (interactive)
;;   (setq notmuch-show-query-context thread)
;;   (notmuch-show-refresh-view t))

;;  (defun expand-only-unread-hook () (interactive)
;;    (let ((unread nil)
;;          (open (notmuch-show-get-message-ids-for-open-messages)))
;;      (notmuch-show-mapc (lambda ()
;;                           (when (member "unread" (notmuch-show-get-tags))
;;                             (setq unread t))))
;;      (when unread
;;        (let ((notmuch-show-hook (remove 'expand-only-unread-hook notmuch-show-hook)))
;;          (notmuch-show-filter-thread "tag:unread")))))

;; (add-hook 'notmuch-show-hook 'expand-only-unread-hook)

(setq smtpmail-default-smtp-server "smtp.gmail.com")
(require 'smtpmail)
(setq send-mail-function 'smtpmail-send-it)
(setq message-send-mail-function 'smtpmail-send-it)
(setq user-full-name "Rustem Muslimov")
(setq smtpmail-local-domain "getgoing.com")
(setq smtpmail-smtp-service 465)
(setq smtpmail-stream-type 'ssl)
(setq user-mail-address (concat "rmuslimov@" smtpmail-local-domain))

(setq notmuch-fcc-dirs nil)

(global-set-key (kbd "C-c m m") 'notmuch)
(global-set-key (kbd "C-c m j") 'notmuch-jump-search)



;; ;; columns: key after C-x c, query, older first?
;; (setq
;;  notmuch--own-searches
;;  '(('Unread "n" "tag:unread" nil)
;;    ('Jira "j" "tag:jira and date:1w..now" nil)
;;    ('Phab "p" "tag:phab and date:1w..now" nil)
;;    ))

;; (defun notmuch--globals-keys ()
;;   (global-set-key (kbd "C-x c m") 'notmuch)
;;   (global-set-key
;;    (kbd "C-x c n")
;;    (lambda () (interactive) (notmuch-search "tag:unread" nil)))
;;   (global-set-key
;;    (kbd "C-x c j")
;;    (lambda () (interactive) (notmuch-search "tag:jira and date:1w..now" nil)))
;;   (global-set-key
;;    (kbd "C-x c p")
;;    (lambda () (interactive) (notmuch-search "tag:phab and date:1w..now" nil)))
;;   (global-set-key
;;    (kbd "C-x c u")
;;    (lambda () (interactive) (notmuch-search "tag:unread" nil)))
;;   (global-set-key
;;    (kbd "C-x c i")
;;    (lambda () (interactive) (notmuch-search "not tag:phab and not tag:jira and not tag:bookings-daily and date:4w..now" nil)))
;;   )


;;; genius script

;; (setq notmuch-saved-searches '
;;       ((:name "unreadnew"
;;               :query "tag:unread"
;;               :count-query "tag:unread"
;;               :sort-order newest-first)))

;; ends here

(provide 'notmuch-settings)
