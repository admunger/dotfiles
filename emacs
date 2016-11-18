; vi:syntax=lisp

;; start directly in *scratch* buffer
(setq inhibit-startup-screen t) 
(setq read-file-name-completion-ignore-case t)

;; start maximized
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(org-agenda-files
   (quote
    ("~/Documents/horaire_relâche.org" "~/Documents/agenda.org" "~/elec2016.org")) t))
 

;; hide useless toolbar
(tool-bar-mode -1)

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

;; EMACS DEFAULT BEHAVIOUR
(global-set-key "\C-s" 'isearch-forward-regexp)

;;;; Vim environment mappings
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)
(global-relative-line-numbers-mode)
(setq relative-line-numbers-motion-function 'forward-line)
(setq relative-line-numbers-max-count 60)
;;(global-linum-mode 1) ;; line numbers

;; set pretty cursors for every mode
(setq evil-normal-state-cursor '("cyan" box))
(setq evil-emacs-state-cursor '("purple" box))
(setq evil-insert-state-cursor '("blue" bar))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-replace-state-cursor '("red" box))
;; allow to jump on next visible line instead of next real line (after CRLF)
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
;; show the matching parenthesis/braces/etc.
(show-paren-mode t)

;; color support in the emacs shell
(color-theme-approximate-on)

;;org-mode preferences
(add-hook 'org-mode-hook
 	  (lambda ()
      (visual-line-mode t)))
;; 	    (org-bullets-mode t)))
(custom-theme-set-faces 'user
                        '(org-level-1 ((t (:foreground "white" :bold t))))
                        '(org-level-2 ((t (:foreground "red"))))
                        '(org-level-3 ((t (:foreground "orange"))))
                        '(org-level-4 ((t (:foreground "DodgerBlue"))))
                        '(org-level-5 ((t (:foreground "pink"))))
                        '(org-level-6 ((t (:foreground "magenta")))))
(setq org-hide-leading-stars t)

;; Makefile highlights
(require 'make-mode)

;;;; emacs email environment
;; gnus will wait because hotmail still have "2-step protection"

(setq user-mail-address "a.munger@hotmail.com")
(setq user-full-name "Adriel Munger")

 (setq gnus-select-method
     '(nnimap "hotmail"
             (nnimap-address "imap-mail.outlook.com")
             (nnimap-server-port "993")
             (nnimap-stream ssl)
             (nnir-search-engine imap)))
(setq smtpmail-default-smtp-server "smtp-mail.outlook.com")
(setq smtpmail-smtp-service 587
   gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

;;avoid emacs deleting mail after retrieving them
(setq vm-pop-expunge-after-retrieving nil) 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; LaTex preferences
(setq TeX-auto-save t)
(setq TeX-parse-self t)
;; (add-hook 'LaTeX-mode-hook 'visual-line-mode) or auto-fill mode
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; (setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)
;; (TeX-global-PDF-mode t)

;; Org-Mode configurations
(setq org-agenda-files (quote ("~/Documents/agenda.org"
			       "~/elec2016.org")))
