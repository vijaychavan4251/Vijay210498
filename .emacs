(require 'package)

;; Add melpa package source when using package list
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;; Load emacs packages and activate them
;; This must come before configurations of installed packages.
;; Don't delete this line.
(package-initialize)

(require 'site-gentoo)

(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)

(require 'slime-autoloads)
(setq inferior-lisp-program "/usr/bin/sbcl")

;; Load a nice theme if in GUI
(when (display-graphic-p)
  (load-theme 'solarized-dark t)
  (set-default-font "xos4 Terminus:pixelsize=28:foundry=xos4:weight=normal:slant=normal:width=normal:spacing=110:scalable=false"))
  ;; (set-default-font "Terminus (TTF) for Windows:pixelsize=28:foundry=PfEd:weight=normal:slant=normal:width=normal:spacing=100:scalable=true"))

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (solarized-theme ##))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
