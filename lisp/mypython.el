

(defun flycheck-local-flake8/get-venv-from-project-path (projectpath)
  "Calc env path from project path"
  (f-join (expand-file-name (getenv "WORKON_HOME"))
          (car (last (split-string projectpath "/")))))

(defun flycheck-local-flake8/flycheck-virtualenv-set-python-executables ()
  (let* ((venv (expand-file-name (vc-git-root (buffer-file-name))))
         (envpath (flycheck-local-flake8/get-venv-from-project-path (substring venv 0 -1))))
    (if (file-exists-p envpath)
        (progn
          (pyvenv-activate envpath)
          (setq-local flycheck-python-flake8-executable (executable-find "flake8"))
          (setq-local flycheck-flake8rc (concat venv "setup.cfg")))
      (progn
        (pyvenv-deactivate)
        (exec-path-from-shell-initialize)
        (setq-local flycheck-python-flake8-executable (executable-find "flake8"))
        (setq-local flycheck-flake8rc (expand-file-name "~/.config/flake8"))
        )
      )))

(add-hook 'flycheck-before-syntax-check-hook
          #'flycheck-local-flake8/flycheck-virtualenv-set-python-executables 'local)

;;;;;;;;;; -----------

(defun local/compile (filename method)
  "run "
  (let* (
        (cmd_cd (format "cd %s" (rope-get-project-root)))
        (cmd_run (if method (format "nosetests %s:%s" filename method)
                   (format "nosetests %s" filename)))
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
(bind-keys :map python-mode-map
           ((kbd "M-t") . local/do-python-test))


(provide 'mypython)
