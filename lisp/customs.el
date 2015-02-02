(server-start)

(setenv "WORKON_HOME" "~/envs")

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
;; (desktop-save-mode t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq tramp-default-method "scp")

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
  (yank)
)
(global-set-key (kbd "M-d") 'duplicate-line)

(autoload 'pianobar "pianobar" nil t)

(ido-mode)
(ido-vertical-mode 1)

(bash-completion-setup)

(setenv "BASH_ENV" "$HOME/.bashrc")

(global-set-key (kbd "C-.") 'next-buffer)
(global-set-key (kbd "C-,") 'previous-buffer)

(add-hook 'python-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'linum-mode)
(add-hook 'python-mode-hook 'autopair-mode)

(add-hook 'javascript-mode-hook 'linum-mode)

(require 'kill-ring-ido)
(global-set-key "\M-y" 'kill-ring-ido)

(pyvenv-workon 'default)

(setq history-length 250)

;; (global-set-key (kbd "C-j") 'ace-jump-mode)
(global-set-key (kbd "C-x '") 'toggle-truncate-lines)

(defcustom elpy-default-minor-modes '(eldoc-mode
                                      yas-minor-mode
                                      auto-complete-mode)
  "Minor modes enabled when `elpy-mode' is enabled."
  :group 'elpy)
(elpy-enable)

(eval-after-load "elpy-mode"
  '(define-key standardp-mode-keymap (kbd "<M-left>") windmove-left))

(setq shell-switcher-new-shell-function 'shell-switcher-make-shell)
(shell-switcher-mode)

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

;; ends

(provide 'customs)
