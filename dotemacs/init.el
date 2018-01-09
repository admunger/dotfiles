;; Personnal configuration
(load-file "~/.emacs.d/private.el")

(server-start)

;; start directly in *scratch* buffer
(setq inhibit-startup-screen t) 
(setq read-file-name-completion-ignore-case t)
(global-unset-key (kbd "<menu>"))

;; start maximized
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-brace-indent-level 4)
 '(TeX-newline-function (quote newline-and-indent))
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#ffffff" "#ff9da4" "#d1f1a9" "#ffeead" "#bbdaff" "#ebbbff" "#99ffff" "#003f8e"))
 '(auth-source-save-behavior nil)
 '(company-idle-delay 0.3)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
	(org-wc use-package relative-line-numbers org-bullets matlab-mode ledger-mode helm evil-surround evil-search-highlight-persist evil-leader dash company-auctex color-theme-sanityinc-tomorrow color-theme-approximate color-theme autopair)))
 '(vc-annotate-very-old-color nil))
(global-set-key (kbd "C-h h") nil) 
'(package-selected-packages
   (quote
	(auctex use-package relative-line-numbers org-bullets matlab-mode ledger-mode helm evil-search-highlight-persist evil-leader dash company-auctex color-theme-approximate autopair)))
 '(tab-always-indent (quote complete))
 
;; access today's date
(defun insert-current-date () (interactive)
    (insert (shell-command-to-string "echo -n $(date +%Y/%m/%d)")))
(global-set-key "\C-x\M-d" 'insert-current-date)

;; hide useless toolbar
(tool-bar-mode -1)

(add-hook 'after-init-hook 'global-company-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; for evil, Vim in Emacs
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(setq evil-shift-width 4)
(set 'evil-vsplit-window-right t)

;; ;; Color theme specification from color-theme-library
;; (require 'color-theme)
;; (color-theme-initialize)
;; ;;(color-theme-oswald) color-theme-euphoria
;; (color-theme-calm-forest)

(add-to-list 'custom-theme-load-path "~/.emacs.d/colors")
;;(require 'ample-theme)
(load-theme 'ample t)
(set-background-color "gray5")

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
(setq linum-format "%2d")

(setq relative-line-numbers-motion-function 'forward-line)
(setq relative-line-numbers-max-count 60)
;;(global-linum-mode 1) ;; line numbers

;; set pretty cursors for every mode
(setq evil-normal-state-cursor '("cyan" box))
(setq evil-emacs-state-cursor '("purple" box))
(setq evil-insert-state-cursor '("cyan" bar))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-replace-state-cursor '("red" box))
;; allow to jump on next visible line instead of next real line (after CRLF)
;; Vim-surround
(require 'evil-surround)
(global-evil-surround-mode 1)

;; Git : magit
;; (setq evil-magit-state 'motion)
;; (require 'evil-magit)

(evil-set-initial-state 'shell-mode 'emacs)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
;; (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
(define-key evil-insert-state-map (kbd "C-V") 'evil-paste-after)
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
 '(org-level-2 ((t (:foreground "DodgerBlue"))))
 '(org-level-3 ((t (:foreground "orange"))))
 '(org-level-4 ((t (:foreground "red"))))
 '(org-level-5 ((t (:foreground "pink"))))
 '(org-level-6 ((t (:foreground "magenta")))))

;; LaTex preferences
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-save-query nil) ;;autosave before compiling
(add-hook 'tex-mode-hook (lambda () (setq ispell-parser 'tex)))
;; (add-hook 'LaTeX-mode-hook (lambda () (electric-indent-local-mode -1)))
(setq ispell-dictionary "francais")
;; (add-hook 'LaTeX-mode-hook 'visual-line-mode) ;; or auto-fill mode
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex) will be done soon
;; (setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)
(setq LaTeX-item-indent 4)
(setq LaTeX-indent-level 4)
;; (TeX-global-PDF-mode t)
(setq-default LaTeX-default-offset 4)
(setq-default TeX-newline-function 'newline-and-indent)
(setq-default indent-tabs-mode t) ; I want tabs. I like tabs
(setq-default standard-indent 4) ; A tab is 4 spaces
;; (setq-default TeX-brace-indent-level 4) swap of custom-var. if it changes nothing
(setq-default tab-width 4) ; A tab is still 4 spaces... what's the difference to the above?

;; Company stuff
(add-hook 'tex-mode-hook (lambda ()
    (set (make-local-variable 'company-backends) '(company-auctex))))
;; (add-hook 'TeX-mode-hook (lambda () 
(require 'company-auctex)
(company-auctex-init) 
;;    (set (make-local-variable 'company-backends) '(company-auctex))
;;    (company-mode t)))

;; Predictive stuff
;; (add-to-list 'load-path "~/.emacs.d/elpa/predictive/")
;; (add-to-list 'load-path "~/.emacs.d/elpa/predictive/latex/")
;; (autoload 'predictive-mode "predictive" "predictive" t)
;; (set-default 'predictive-auto-add-to-dict t)
;; (setq predictive-main-dict 'rpg-dictionary
;;       predictive-auto-learn t
;;       predictive-add-to-dict-ask nil
;;       predictive-use-auto-learn-cache nil
;;       predictive-which-dict t)
;; (require 'predictive)
;; (add-hook 'LaTeX-mode-hook 'predictive-mode) ;; or auto-fill mode

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
(helm-mode 0)
(define-key helm-find-files-map (kbd "<tab>") 'helm-execute-persistent-action)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

