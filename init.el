(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el")
(cask-initialize)

(require 'pallet)
(pallet-mode t)

(pyvenv-workon 'default)

(add-to-list 'load-path "~/projects/Pymacs")
(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'customs)
(require 'mypython)
(require 'my-functions)
(require 'prodigy-settings)
(require 'local)

(load-theme 'tango)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(setq-default indent-tabs-mode nil)

(setq flycheck-highlighting-mode 'lines)
(global-set-key "\M-y" 'browse-kill-ring)
