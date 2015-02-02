(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el")
(cask-initialize)

(require 'package)
(setq package-archives
 '(("melpa" . "http://melpa.org/packages/")
   ("gnu" . "http://elpa.gnu.org/packages/")
   ("e6h" . "http://www.e6h.org/packages/"))
)
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'customs)
(require 'my-functions)

(require 'prodigy-settings)
(require 'browse-at-remote)

(load-theme 'tango)
