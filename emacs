;; start directly in *scratch* buffer
(setq inhibit-startup-screen t) 

;; for evil, Vim in Emacs
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Color theme specification from color-theme-library
(require 'color-theme)
(color-theme-initialize)
(color-theme-oswald)
;;;; Yes, I need that color scheme
;;(require 'color-theme-sanityinc-tomorrow)
;;(load-theme 'sanityinc-tomorrow-bright t)
;;;; (color-theme-sanityinc-tomorrow--define-theme bright)

;; Vim environment mappings
(require 'evil)
(evil-mode 1)
(define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-replace-state-map (kbd "C-c") 'evil-normal-state)
(global-relative-line-numbers-mode)
;;(global-linum-mode 1) ;; line numbers
(setq evil-normal-state-cursor '("yellow" box))
(setq evil-emacs-state-cursor '("purple" box))
(setq evil-insert-state-cursor '("yellow" bar))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-replace-state-cursor '("red" box))

;; color support in the emacs shell
(color-theme-approximate-on)

;; org-mode preferences
(add-hook 'org-mode-hook
	  (lambda ()
	    (org-bullets-mode t)))

(setq org-hide-leading-stars t)

;; Makefile highlights
(require 'make-mode)

;; emacs email environment
(setq user-mail-address "a.munger@hotmail.com")
(setq user-full-name "Adriel Munger")

(setq gnus-select-method
    '(nnimap "hotmail"
            (nnimap-address "imap-mail.outlook.com")
            (nnimap-server-port "993")
            (nnimap-stream ssl)))
(setq smtpmail-smtp-service 587
    gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")
;;avoid emacs deleting mail after retrieving them
(setq vm-pop-expunge-after-retrieving nil) 
