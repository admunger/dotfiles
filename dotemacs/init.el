;; Personnal configuration
;; (load-file "~/.emacs.d/private.el")

(server-start)

;; start directly in *scratch* buffer
(setq inhibit-startup-screen t) 
(setq read-file-name-completion-ignore-case t)
(global-unset-key (kbd "<menu>"))

;; set default font
;; (add-to-list 'default-frame-alist '(font . "WenQuanYi Micro Hei Mono-10"))
(add-to-list 'default-frame-alist '(font . "Consolas-11"))

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
 '(org-file-apps
   (quote
	((auto-mode . emacs)
	 ("\\.mm\\'" . default)
	 ("\\.x?html?\\'" . default)
	 ("\\.pdf\\'" . "evince %s"))))
 '(org-time-stamp-custom-formats (quote ("<%a %B %d,%Y >" . "<%d %m %Y  %a [%H:%M]>")))
 '(package-selected-packages
   (quote
	(yasnippet-snippets yasnippet org-wc use-package relative-line-numbers org-bullets matlab-mode ledger-mode helm evil-surround evil-search-highlight-persist evil-leader dash company-auctex color-theme-sanityinc-tomorrow color-theme-approximate color-theme autopair)))
 '(vc-annotate-very-old-color nil))
(global-set-key (kbd "C-h h") nil) 
'(package-selected-packages
   (quote
	(auctex use-package relative-line-numbers org-bullets matlab-mode ledger-mode helm evil-search-highlight-persist evil-leader dash company-auctex color-theme-approximate autopair)))
 '(tab-always-indent (quote complete))
 
;; access today's date
(defun date-short () (interactive)
    (insert (shell-command-to-string "echo -n $(date +%Y/%m/%d)")))
(defun date-long () (interactive)
    (insert (shell-command-to-string "echo -n $(date '+%B %_e, %Y')")))
;;  (insert (format-time-string "%a %_e %B")))
;;(global-set-key "\C-x\M-d" 'date-short)

;; hide useless toolbar
(tool-bar-mode -1)

;; undo split configurations with C-c left|right
(winner-mode 1)

(add-hook 'after-init-hook 'global-company-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; for evil, Vim in Emacs
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(setq evil-shift-width 4)
(set 'evil-vsplit-window-right t)
(set 'evil-split-window-below t)

; scrolling behaving like vim
(setq scroll-step            1
      scroll-conservatively  10000)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

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
(setq scroll-margin 2) ;; vim scrolloff equivalent

(require 'evil)
(evil-mode 1)
;; from linum-relative
;; check this if you're not satisfied : 
;; https://www.emacswiki.org/emacs/LineNumbers
;; allows to handle folding in org-mode
(setq display-line-numbers-type 'visual)
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))
;; (global-display-line-numbers-mode)
(setq-default display-line-numbers-type 'relative)
;; (global-relative-line-numbers-mode)
(setq linum-format "%2d")

;; (setq relative-line-numbers-motion-function 'forward-line)
;; (setq relative-line-numbers-max-count 60)
;;(global-linum-mode 1) ;; line numbers
(define-key evil-normal-state-map (kbd "<up>") 'evil-previous-visual-line)
(define-key evil-normal-state-map (kbd "<down>") 'evil-next-visual-line)
(define-key evil-visual-state-map (kbd "<up>") 'evil-previous-visual-line)
(define-key evil-visual-state-map (kbd "<down>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "\C-n") 'next-line)
(define-key evil-normal-state-map (kbd "\C-p") 'previous-line)

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

;; command alias with emacs' equivalent
(evil-ex-define-cmd "W" 'save-buffer)

;; Git : magit
;; (setq evil-magit-state 'motion)
;; (require 'evil-magit)

(evil-set-initial-state 'shell-mode 'emacs) ;; bad one
(evil-set-initial-state 'eshell-mode 'emacs)
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
(add-hook 'org-mode-hook
      (lambda ()
      (setq display-line-numbers-type 'visual)
      (org-toggle-time-stamp-overlays)))
;; 	    (org-bullets-mode t)))
(setq org-hide-leading-stars t)
;; Change timestamp format
(custom-set-variables
    '(org-time-stamp-custom-formats (quote ("<%a %B %d,%Y >" . "<%d %m %Y  %a [%H:%M]>")))) 
(setq org-display-custom-times t)
  ;;(org-translate-time "<2014-04-29 Tu.>"))

;; Makefile highlights
(require 'make-mode)

;;avoid emacs deleting mail after retrieving them
(setq vm-pop-expunge-after-retrieving nil) 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil)))
 '(org-level-1 ((t (:foreground "white" :bold t))))
 '(org-level-2 ((t (:foreground "LimeGreen"))))
 '(org-level-3 ((t (:foreground "DodgerBlue"))))
 '(org-level-4 ((t (:foreground "orange"))))
 '(org-level-5 ((t (:foreground "pink"))))
 '(org-level-6 ((t (:foreground "firebrick1"))))
 '(org-level-7 ((t (:foreground "aquamarine1")))))

;; LaTex preferences
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-save-query nil) ;;autosave before compiling
(add-hook 'tex-mode-hook (lambda () (setq ispell-parser 'tex)))
;; (add-hook 'LaTeX-mode-hook (lambda () (electric-indent-local-mode -1)))
(add-hook 'LaTeX-mode-hook 'visual-line-mode) ;; or auto-fill mode
;; (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode) ;; allows `a = \alpha
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
    (set (make-local-variable 'company-backends) '(company-auctex company-files))))
;; (add-hook 'TeX-mode-hook (lambda () 
;; switch to document sections using C-c =
(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(require 'company-auctex)
(company-auctex-init) 
;;    (set (make-local-variable 'company-backends) '(company-auctex))
;;    (company-mode t)))


;; avoid changing font for exponent and indices
(custom-set-faces
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil)))
 )
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
(setq helm-ff-skip-boring-files t)
(setq helm-boring-file-regexp-list '("\\.aux$"))

;; Dired configuration
(ranger-override-dired-mode t)
(setq ranger-hide-cursor nil)

;; MATLAB configuration
(setq matlab-shell-command "~/Applications/Matlab/R2017b/bin/matlab")
(setq matlab-shell-command-switches (list "-nodesktop"))
(setq matlab-comment-region-s "% ")

;; YASNIPPET configuration
(require 'yasnippet)
(yas-global-mode 1)
; avoid conflict with LaTeX-mode's keymaps
(define-key yas-minor-mode-map (kbd "C-c & C-s") nil)
(define-key yas-minor-mode-map (kbd "C-c C-s") 'yas-insert-snippet)

;; C/C++ configuration
(add-hook 'c-mode-common-hook
          (lambda ()
            (define-key c-mode-base-map (kbd "C-c C-c") 'compile)))
(add-hook 'c-mode-common-hook
          (lambda ()
            (define-key c-mode-base-map (kbd "C-c ;") 'comment-or-uncomment-region)))

;; ido-mode, fuzzy buffer finder
(defvar ido-dont-ignore-buffer-names '("*grep*" "*Scratch" "Messages"))

(defun ido-ignore-most-star-buffers (name)
  (and
   (string-match-p "^*" name)
   (not (member name ido-dont-ignore-buffer-names))))

(setq ido-ignore-buffers (list "\\` " #'ido-ignore-most-star-buffers))
(ido-mode 1)
