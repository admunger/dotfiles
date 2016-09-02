(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (deeper-blue))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; for evil, Vim in Emacs
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;;(require 'evil)
;;(evil-mode 1)



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
