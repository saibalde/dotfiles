;; start Emacs in full-screen mode
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; start Emacs with a blank screen
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; maximize editor area by disabling menubar etc.
(menu-bar-mode -1)
(when window-system
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1)
  (blink-cursor-mode -1))

;; setup in-built package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; setup use-package for easier package management
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; load the configuration
(org-babel-load-file "~/.emacs.d/config.org")
