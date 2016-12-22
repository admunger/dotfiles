; vi:syntax=lisp
;; Personnal configuration
(load-file "~/.emacs.d/private.el")

;; start directly in *scratch* buffer
(setq inhibit-startup-screen t) 
(setq read-file-name-completion-ignore-case t)

;; start maximized
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-indent-level 4)
 '(TeX-brace-indent-level 4)
 '(TeX-newline-function (quote newline-and-indent))
 '(auth-source-save-behavior nil)
 '(initial-frame-alist (quote ((fullscreen . maximized)))))
 
;; access today's date
(defun insert-current-date () (interactive)
    (insert (shell-command-to-string "echo -n $(date +%Y/%m/%d)")))
(global-set-key "\C-x\M-d" 'insert-current-date)

;; hide useless toolbar
(tool-bar-mode -1)

;; for evil, Vim in Emacs
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(setq evil-shift-width 4)
(set 'evil-vsplit-window-right t)

;; Color theme specification from color-theme-library
(require 'color-theme)
(color-theme-initialize)
;;(color-theme-oswald) color-theme-euphoria
(color-theme-calm-forest)
;;(require 'color-theme-sanityinc-tomorrow)
;;(load-theme 'sanityinc-tomorrow-bright t)
;;;; (color-theme-sanityinc-tomorrow--define-theme bright)

;; this is to keep background in terminal
;; (defun on-after-init ()
;;   (unless (display-graphic-p (selected-frame))
;;     (set-face-background 'default "unspecified-bg" (selected-frame))))
;; (add-hook 'window-setup-hook 'on-after-init)

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
;; Vim-surround
(require 'evil-surround)
(global-evil-surround-mode 1)

;; Git : magit
;; (setq evil-magit-state 'motion)
;; (require 'evil-magit)

(evil-set-initial-state 'shell-mode 'emacs)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; show the matching parenthesis/braces/etc.
(show-paren-mode t)
;;(require 'highlight)
;;(require 'evil-search-highlight-persist)
;;(global-evil-search-highlight-persist t)

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

;;avoid emacs deleting mail after retrieving them
(setq vm-pop-expunge-after-retrieving nil) 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:foreground "white" :bold t))))
 '(org-level-2 ((t (:foreground "red"))))
 '(org-level-3 ((t (:foreground "orange"))))
 '(org-level-4 ((t (:foreground "DodgerBlue"))))
 '(org-level-5 ((t (:foreground "pink"))))
 '(org-level-6 ((t (:foreground "magenta")))))

;; LaTex preferences
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(add-hook 'LaTeX-mode-hook (lambda () (electric-indent-local-mode -1)))
;; (add-hook 'LaTeX-mode-hook 'visual-line-mode) ;; or auto-fill mode
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex) will be done soon
;; (setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)
;; (TeX-global-PDF-mode t)
(setq-default LaTeX-default-offset 4)
(setq-default TeX-newline-function 'newline-and-indent)
(setq-default indent-tabs-mode t) ; I want tabs. I like tabs
(setq-default standard-indent 4) ; A tab is 4 spaces
(setq-default tab-width 4) ; A tab is still 4 spaces... what's the difference to the above?
;; Company stuff (doesn't work for the moment)
;; (require 'company-auctex)
;; (company-auctex-init) 
(add-to-list 'load-path "~/.emacs.d/elpa/predictive/")
(add-to-list 'load-path "~/.emacs.d/elpa/predictive/latex/")
(autoload 'predictive-mode "predictive" "predictive" t)
(set-default 'predictive-auto-add-to-dict t)
(setq predictive-main-dict 'rpg-dictionary
      predictive-auto-learn t
      predictive-add-to-dict-ask nil
      predictive-use-auto-learn-cache nil
      predictive-which-dict t)
(require 'predictive)

;;;;set in scratch, set it if tabs went wild
;; (set 'tab-always-indent nil)
;; (set 'indent-line-function 'indent-relative)


;; LEDGER MODE CONFIGURATION
(use-package ledger-mode
    :ensure t
    :init
    :config
    :mode "\\.dat\\'") 
(setq ledger-highlight-xact-under-point nil)

;; Helm Configuration
(require 'helm)
(require 'helm-config)
;;(helm-mode 0)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
