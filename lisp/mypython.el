
;; Test environment

(defun local/compile (filename method)
  "run testing command"
  (let* (
        (cmd_cd (format "cd %s" (rope-get-project-root)))
        (cmd_run (if method (format "nosetests -s %s:%s" filename method)
                   (format "nosetests -s %s" filename)))
        (cmd (format "%s;%s" cmd_cd cmd_run))
        (project-name (last (f-split (rope-get-project-root))))
        (action-buffer (get-buffer-create (format "%s-compile" project-name)))
        )
    (display-buffer action-buffer)
    (set-buffer action-buffer)
    (erase-buffer)
    (insert (format "PROJECT: %s\n" (rope-get-project-root)))
    (insert (format "COMMAND: %s\n\n" cmd_run))
    (insert (shell-command-to-string cmd))
    (display-buffer action-buffer)))

(defun local/do-python-test()
  "Run tests for function at point"
  (interactive)
  (let
      ((filename (f-relative (buffer-file-name) (rope-get-project-root)))
       (method (python-info-current-defun)))
    (local/compile (s-replace "" "" filename) method)))

(require 'bind-key)

(add-hook 'python-mode-hook (lambda ()
		  (bind-keys :map python-mode-map
					 ((kbd "M-t") . local/do-python-test))))

;; (require 'py-smart-operator)
(add-hook 'python-mode-hook 'py-smart-operator-mode)

;;  ----

(provide 'mypython)
