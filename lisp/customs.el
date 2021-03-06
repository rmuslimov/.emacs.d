(server-start)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(setq ns-function-modifier 'hyper)

(global-font-lock-mode 1)
(tool-bar-mode -1)
(global-hl-line-mode 0)
(windmove-default-keybindings 'super)
(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key [kp-delete] 'delete-char)
(global-set-key [C-kp-delete] 'delete-word)

(put 'upcase-region 'disabled nil)
(pending-delete-mode 1)

(global-set-key [f5] 'call-last-kbd-macro)
(global-set-key [f8] 'linum-mode)
(global-set-key [f11] 'ibuffer)
(global-set-key [f10] 'bookmark-bmenu-list)

(setq inhibit-startup-message t)
(setq default-tab-width 4)
(setq x-select-enable-clipboard t)

(setq jsx-indent-level 4)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-set-key "\M-sr" 'replace-string)
(global-set-key "\C-cs" 'shell)
(global-set-key "\C-cf" 'rgrep)

(set-default-font "Consolas-11")
(set-fontset-font "fontset-default" 'cyrillic '("consolas" . "utf-8"))
(set-face-attribute 'default nil :height 135)

(global-set-key (kbd "C-x m") 'magit-status)
(global-set-key (kbd "C-x l") 'pianobar-next-song)

(global-set-key (kbd "C-<backspace>") 'backward-kill-word)
(global-set-key (kbd "C-<delete>") 'kill-word)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))

(global-set-key (kbd "M-d") 'duplicate-line)

(autoload 'pianobar "pianobar" nil t)

(ido-mode)
(ido-vertical-mode 1)

(bash-completion-setup)

(global-set-key (kbd "C-.") 'next-buffer)
(global-set-key (kbd "C-,") 'previous-buffer)

(add-hook 'python-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'linum-mode)
(add-hook 'python-mode-hook 'autopair-mode)

(add-hook 'javascript-mode-hook 'linum-mode)

;; (require 'kill-ring-ido)
;; (global-set-key "\M-y" 'kill-ring-ido)
(global-set-key "\M-y" 'browse-kill-ring)

(setq history-length 1000)

(global-set-key (kbd "C-j") 'avy-goto-char)
(global-set-key (kbd "C-x '") 'toggle-truncate-lines)

(hl-highlight-mode 1)

(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

(defun move-line-up ()
  (interactive)
  (transpose-lines 1) (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1) (forward-line -1))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

(setq ag-highlight-search t)
(yas-global-mode 1)

;; ;; pymacs
;; (defmacro after (mode &rest body)
;;   `(eval-after-load ,mode
;;      '(progn ,@body)))

;; (after 'auto-complete
;;        (add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
;;        (setq ac-use-menu-map t)
;;        (define-key ac-menu-map "\C-n" 'ac-next)
;;        (define-key ac-menu-map "\C-p" 'ac-previous))

;; (after 'auto-complete-config
;;        (ac-config-default)
;;        (when (file-exists-p (expand-file-name "~/projects/Pymacs"))
;;          (ac-ropemacs-initialize)
;;          (ac-ropemacs-setup)))

;; (after 'auto-complete-autoloads
;;        (autoload 'auto-complete-mode "auto-complete" "enable auto-complete-mode" t nil)
;;        (add-hook 'python-mode-hook
;;                  (lambda ()
;;                    (require 'auto-complete-config)
;;                    (add-to-list 'ac-sources 'ac-source-ropemacs)
;;                    (auto-complete-mode))))

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;; (getenv "PATH")
(pymacs-load "ropemacs" "rope-")

(defun sort-lines-nocase ()
  (interactive)
  (let ((sort-fold-case t))
    (call-interactively 'sort-lines)))


;; powerline as VIM
(require 'powerline)
(powerline-default-theme)

(require 'moe-theme)

(require 'flycheck-local-flake8)
(add-hook 'flycheck-before-syntax-check-hook
          #'flycheck-local-flake8/flycheck-virtualenv-set-python-executables 'local)

(setq flycheck-check-syntax-automatically '(mode-enabled save))

(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . jsx-mode))
(autoload 'jsx-mode "jsx-mode" "JSX mode" t)

(powerline-moe-theme)
;; (load-theme 'whiteboard)

(require 'py-smart-operator)
(require 'browse-at-remote)
(require 'itunes)

(global-set-key (kbd "C-c i n") 'itunes-next)
(global-set-key (kbd "C-c i p") 'itunes-prev)

(defun grizzl-kill-ring ()
  (interactive)
  (let* ((index (grizzl-make-index (reverse kill-ring)))
        (search (grizzl-completing-read "Kill-ring:" index)))
    (insert search)
  ))

;; (global-set-key (kbd "M-y") 'grizzl-kill-ring)
(global-set-key (kbd "M-/") 'company-complete)

(define-key 'help-command (kbd "C-f") 'find-function)

(add-to-list 'exec-path "/usr/local/bin")
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))

;; setup jenkins extension
(add-to-list 'load-path "~/projects/jenkins.el")
(require 'jenkins)

;; setup webpack extension
(add-to-list 'load-path "~/projects/webpack.el")
(require 'webpack)

(add-hook
 #'jsx-mode-hook
 (lambda ()
   (local-set-key "\C-cg" 'webpack-goto-definition)))

(setq jenkins-api-token "9325efbdcfacd26d5eacfcc90b557862")
(setq jenkins-url "http://jenkins.team.getgoing.com:80/")
(setq jenkins-username "rmuslimov")
(setq jenkins-viewname "0.%20Active")

(add-hook 'after-init-hook 'global-company-mode)
(setq company-backends '(company-elisp company-ropemacs))

(avy-setup-default)
;; (load-theme 'tango-dark)

;; ends
(provide 'customs)
