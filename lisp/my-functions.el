;; -*- lexical-binding:t -*-

(defconst getgoing/projects
  (list "airborne" "bowman" "cessna" "fokker" "fasttrace"))

(defun getgoing/get-project-path (project)
  (f-join "~/projects" project))

(defconst overriden-projects '("hyatt" "quicksilver" "radisson" "courtyard"))

(defun setup-local-project(project-name)
  (let ((shell-name (format "shell-%s" project-name))
        (project-path (f-join "~/projects" project-name))
        (overriden-paths
         (mapconcat
          (lambda (x) (format "~/projects/%s" x))
          overriden-projects ":"))
        )
    (if (get-buffer shell-name)
        (switch-to-buffer shell-name)
      (progn
        (shell)
        (rename-buffer shell-name)
        (insert (format "cd %s;" project-path))
        (insert (format "export PATH=~/.virtualenvs/%s/bin:$PATH;" project-name))
        (insert (format "export PYTHONHOME=~/.virtualenvs/%s;" project-name))
        (insert (format "export PYTHONPATH=%s:%s;" overriden-paths project-path))
        (insert (format "export VIRTUAL_ENV=~/.virtualenvs/%s;" project-name))
        (insert "export PYTHONIOENCODING=\"utf-8\";")
        (comint-send-input nil t)
        (kill-region (point-min) (point-max)))
      )))

(defun setup-airborne()
  "Setup airborne project"
  (interactive)
  (setup-local-project "airborne"))

(defun setup-bowman()
  "Setup bowman project"
  (interactive)
  (setup-local-project "bowman"))

(defun setup-cessna()
  "Setup cessna project"
  (interactive)
  (setup-local-project "cessna"))

(defun setup-fokker()
  "Setup fokker project"
  (interactive)
  (setup-local-project "fokker"))

(defun setup-fasttrace()
  "Setup fasttrace project"
  (interactive)
  (setup-local-project "fasttrace"))


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

(defun resort-region ()
  (interactive)
  (let* (
         (selected (buffer-substring-no-properties (region-beginning) (region-end)))
         (parents (-map 's-trim (s-split "," selected)))
         (response (s-join ", " (-sort 'string< parents)))
         )
    (delete-region (region-beginning) (region-end))
    (insert response)
    ))

;; autocmplete
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac")
;; (ac-config-default)
;; (setq ac-auto-start t)
;; (setq ac-auto-show-menu 1)

(defun py-get-space-in (str)
  (let* ((items (string-to-list str))
         (val 0)
         (item (car items))
        )
    (while (equal item 32)
      (setq val (1+ val))
      (setq item (nth val items))
      )
    val
    ))

(defun py-format-docstring ()
  (interactive)
  (let* ((region-string
          (if (use-region-p)
              (buffer-substring-no-properties (region-beginning) (region-end))))
         (spaces (s-repeat (py-get-space-in region-string) " "))
         (items (mapcar 'string-trim (split-string region-string "\n")))
         (new-string
          (replace-regexp-in-string "'''" "\"\"\""
                                    (apply 'format "%s%s.%s\n" items)))
         )
    (progn
      (delete-region (region-beginning) (region-end))
      (insert (format "%s%s" spaces new-string)))
    ))

(require 'ag)

(defconst AG-SEPARATOR "::")
(defun ag-do-search (searchterm)
  "My way to use ag.el"
  (interactive "sSearchtem (like '<text>::<file_ext>$', or <text>): ")
  (let* ((terms (s-split AG-SEPARATOR searchterm))
         (searchtext (car terms))
         (ext (cadr terms)))
    (ag/search searchtext (dired-current-directory) :file-regex ext)))


(defun open-file-on-line ()
  (interactive)

  (save-excursion
    (progn
      (move-beginning-of-line nil)
      (setq beg (point))
      (move-end-of-line nil)
      (setq end (point))

      (setq filepath
       (format "~/projects/logs/logs-fokker-rtarik/%s"
               (substring-no-properties (buffer-string) (1- beg) (1- end))))))

  (with-temp-buffer
    (insert-file-contents filepath)
    (save-excursion
      (search-forward "timeStamp=\"")
      (setq beg (point))
      (search-forward "\"")
      (setq end (point))
      (setq searchvar
            (substring-no-properties (buffer-string) (1- beg) (- end 2))))


    (save-excursion
      (condition-case exc
          (search-forward "<eb:Service eb:type=\"OTA\">")
        ('error (search-forward "<eb:Action>")))
      (setq beg (point))
      (search-forward "</")
      (setq end (point))
      (setq methodvar
            (substring-no-properties (buffer-string) (1- beg) (- end 3))))
      )

  (insert (format ", %s, %s" searchvar methodvar)))


(provide 'my-functions)
