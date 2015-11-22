(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el")
(cask-initialize)

(pyvenv-workon 'default)

(add-to-list 'load-path "~/projects/Pymacs")
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/projects/playground/lisps")

(require 'customs)
(require 'mypython)
(require 'myclojure)
(require 'my-functions)
(require 'prodigy-settings)
(require 'my-org)
(require 'getgoing)
;; (require 'local)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(setq-default indent-tabs-mode nil)

(setq flycheck-highlighting-mode 'lines)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-safe-themes
   (quote
    ("8e5dd88c42089566d5f8e1a23d3017c213eeccd94a7b9e1a58a2dc3e08cb26d5" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "d7088a7105aa09cc68e3d058f89917e07e0505e0f4ab522a6045ec8092d67c44" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "90edd91338ebfdfcd52ecd4025f1c7f731aced4c9c49ed28cfbebb3a3654840b" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "1b450ee31c063bca2d91835cb05b2ae141af2ac5309943430ee3a57007c6988f" default)))
 '(fci-rule-color "#383838"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq magit-push-always-verify t)
