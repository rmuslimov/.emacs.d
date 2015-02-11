

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

(provide 'mypython)
