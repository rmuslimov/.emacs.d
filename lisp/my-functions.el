(defconst getgoing/projects
  (list "airborne" "bowman" "cessna" "fokker" "fasttrace"))

(defun getgoing/get-project-path (project)
  (f-join "~/projects" project))

(defun init-shell-for (project)
  (interactive "sProject: ")
  (get-buffer-create (format "shell-%s" project))
  (insert (getgoing/get-project-path project))
  (insert (format "workon %s" project))
  (comint-send-input nil t))

(defun setup-airborne()
  (interactive)
  (shell-switcher-new-shell)
  (rename-buffer "shell-airborne")
  (insert "cd ~/projects/airborne;")
  (insert "workon airborne;")
  (comint-send-input nil t)
  (kill-region (point-min) (point-max))
)

(defun setup-bowman()
  (interactive)
  (shell-switcher-new-shell)
  (rename-buffer "shell-bowman")
  (insert "cd ~/projects/bowman;")
  (insert "workon bowman;")
  (comint-send-input nil t)
  (kill-region (point-min) (point-max))
)

(defun setup-cessna()
  (interactive)
  (shell-switcher-new-shell)
  (rename-buffer "shell-cessna")
  (insert "cd ~/projects/cessna;")
  (insert "workon cessna;")
  (comint-send-input nil t)
  (kill-region (point-min) (point-max))
)

(defun setup-fasttrace()
  (interactive)
  (shell-switcher-new-shell)
  (rename-buffer "shell-fasttrace")
  (insert "cd ~/projects/fasttrace;")
  (insert "workon fasttrace;")
  (comint-send-input nil t)
  (kill-region (point-min) (point-max))
)

(defun setup-gaylord()
  (interactive)
  (shell-switcher-new-shell)
  (rename-buffer "shell-gaylord")
  (insert "cd ~/projects/gaylord/chains;")
  (insert "workon gaylord;")
  (comint-send-input nil t)
  (kill-region (point-min) (point-max))
)

(defun setup-festagent()
  (interactive)
  (shell-switcher-new-shell)
  (rename-buffer "shell-festagent")
  (insert "cd ~/projects/festagent;")
  (insert "workon festagent;")
  (comint-send-input nil t)
  (kill-region (point-min) (point-max))
)

(defun setup-fokker()
  (interactive)
  (shell-switcher-new-shell)
  (rename-buffer "shell-fokker")
  (insert "cd ~/projects/fokker;")
  (insert "workon fokker;")
  (comint-send-input nil t)
  (kill-region (point-min) (point-max))
)

(defun setup-gg-projects ()
  (interactive)
  (setup-airborne)
  (setup-bowman)
  (setup-cessna)
  (setup-fokker)
)

;; (defun setup-tests (projectname)
;;   (interactive "sProject name: ")
;;   (elpy-set-project-root (concat "~/projects/" ))
;;   (pyvenv-workon projectname)
;; )

;; open external links

(defun open-gg-issue (issue_code)
  (interactive "sIssue: ")
  (browse-url (concat "https://getgoing.atlassian.net/browse/GG-" issue_code))
)

;; org files
(defun daily ()
  (interactive)
  (find-file "~/org/journal.org"))

(defun main-org ()
  (interactive)
  (find-file "~/org/main.org")
)

(defun fa-daily ()
  (interactive)
  (find-file "~/org/festagent/fa.org")
)

(defun uniq-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (kill-line 1)
        (yank)
        (let ((next-line (point)))
          (while
              (re-search-forward
               (format "^%s" (regexp-quote (car kill-ring))) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-todo-keywords
      '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE")))


(setq yas-snippet-dirs (append yas-snippet-dirs
                               '("~/.emacs.d/snippets")))

(provide 'my-functions)
