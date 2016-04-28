;; Miscellaneous
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "405b0ac2ac4667c5dab77b36e3dd87a603ea4717914e30fcf334983f79cfd87e" default)))
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(js2-global-externs (quote ("describe" "it" "spyOn" "beforeEach" "expect")))
 '(js2-include-node-externs t)
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:background "Yellow" :foreground "Black")))))

(set-keyboard-coding-system nil)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))


(package-initialize)

(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))


;; Spaces instead of tabs
(setq-default tab-width 4 indent-tabs-mode nil)

;; Theme stuff
(load-theme 'mustard t)


;; Make sure path is loaded if using GUI emacs
(exec-path-from-shell-initialize)


;; Mouse scrolling
(defun up-slightly () (interactive) (scroll-up 1))
(defun down-slightly () (interactive) (scroll-down 1))
(global-set-key (kbd "<mouse-4>") 'down-slightly)
(global-set-key (kbd "<mouse-5>") 'up-slightly)

(xterm-mouse-mode)

(ido-vertical-mode t)
(projectile-global-mode t)
(global-linum-mode t)
(global-evil-surround-mode t)
;; (global-auto-complete-mode t)
(global-company-mode t)
(global-flycheck-mode t)
(global-color-identifiers-mode)


;; Use rainbow-delimiters-mode and rainbow-identifiers-mode for all programming modes
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)


;; Remove trailing whitespace before saving a file
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; Enable copy/paste to OS X clipboard
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)


;; Smart-mode-line
(sml/setup)


;; File associations
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))

;; Flycheck
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jscs)))

(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'js2-mode)


;; Indent JSON files 2 spaces instead of 4
(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 4)))


;; Disable backup files
(setq make-backup-files nil)


;; Highlight parentheses
(setq show-paren-delay 0)
(show-paren-mode 1)


;; Tern.js support

(add-to-list 'company-backends 'company-tern)

(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))

(defun delete-tern-process ()
  (interactive)
  (delete-process "Tern"))


;; Better UI for showing functions in JS files
(js2-imenu-extras-mode)



;; Clojurescript figwheel REPL
(defun figwheel-repl ()
  (interactive)
  (run-clojure "lein figwheel"))

(add-hook 'clojure-mode-hook #'inf-clojure-minor-mode)

;; Evil-mode
(require 'evil-leader)
(global-evil-leader-mode t)
(evil-leader/set-leader ",")

(require 'evil)
(evil-mode 1)

(evil-leader/set-key
  "e" 'find-file
  "x" 'smex
  "f" 'helm-projectile
  "b" 'helm-buffers-list
  "g" 'helm-do-grep
  "k" 'kill-buffer
  "o" 'other-window

  "ci" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "\\" 'evilnc-comment-operator ; if you prefer backslash key
  )


(key-chord-mode t)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-normal-state-map "ff" 'helm-find-files)
(key-chord-define evil-normal-state-map "ri" 'rainbow-identifiers-mode)
(key-chord-define evil-normal-state-map "rd" 'rainbow-delimiters-mode)
(key-chord-define evil-normal-state-map "gs" 'magit-status)
(key-chord-define evil-normal-state-map "gb" 'magit-blame)
(key-chord-define evil-normal-state-map "bq" 'magit-blame-quit)
(key-chord-define evil-normal-state-map "fn" 'helm-imenu)

;; Machine-specific configs, etc
(require 'init-loader)
(init-loader-load)
