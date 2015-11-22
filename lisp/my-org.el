
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

(defun myorg-iter ()
  (interactive)
  (defun do-something ()
    (let ((id (org-entry-get (point) "VALUE")))
      (when id (print id))))

  (org-map-entries 'do-something)
  )

(defun myorg-getfirst-element (key value)
  "Returns first org element which meets requirements."
  (defun get-first ()
    (let ((val (org-entry-get (point) key)))
      (when (equal val value) (point))))

  (-first 'identity (org-map-entries 'get-first)))

;; (-when-let (point (myorg-getfirst-element "value" "asdad")) (goto-char point))

(provide 'my-org)
