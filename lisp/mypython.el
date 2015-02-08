

(defun flycheck-virtualenv-set-python-executables ()
  (let* ((venv (expand-file-name (vc-git-root (buffer-file-name))))
         (envpath (s-replace "projects" "envs" venv)))
    (if (file-exists-p envpath)
        (progn
          (pyvenv-activate envpath)
          (setq flycheck-python-flake8-executable (executable-find "flake8")
                flycheck-flake8rc (concat venv "setup.cfg")))
      (progn
        (pyvenv-deactivate)
        (exec-path-from-shell-initialize)
        (setq flycheck-python-flake8-executable (executable-find "flake8")
              flycheck-flake8rc (expand-file-name "~/.config/flake8")))
      )))

(add-hook 'flycheck-before-syntax-check-hook
          #'flycheck-virtualenv-set-python-executables 'local)

(provide 'mypython)
