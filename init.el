;; Miscellaneous
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(coverlay-mode t)
 '(coverlay:tested-line-background-color "dark green")
 '(custom-safe-themes
   (quote
    ("235dc2dd925f492667232ead701c450d5c6fce978d5676e54ef9ca6dd37f6ceb" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "45712b65018922c9173439d9b1b193cb406f725f14d02c8c33e0d2cdad844613" "0820d191ae80dcadc1802b3499f84c07a09803f2cb90b343678bdb03d225b26b" "110bb04298a575bc9b0dc3ee2c885e3bdd11137d0b9c48c89e155d7552359826" "f9574c9ede3f64d57b3aa9b9cef621d54e2e503f4d75d8613cbcc4ca1c962c21" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "38e64ea9b3a5e512ae9547063ee491c20bd717fe59d9c12219a0b1050b439cdd" "26ce7eea701bfd143ac536e6805224cff5598b75effb60f047878fe9c4833ae4" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "405b0ac2ac4667c5dab77b36e3dd87a603ea4717914e30fcf334983f79cfd87e" default)))
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(js2-global-externs (quote ("describe" "it" "spyOn" "beforeEach" "expect")))
 '(js2-include-node-externs t)
 '(package-selected-packages
   (quote
    (prettier-js elm-mode yafolding flow-minor-mode xterm-color web-mode tern-auto-complete tabbar swiper smex smart-mode-line-powerline-theme rainbow-identifiers rainbow-delimiters project-explorer powerline-evil php-mode peacock-theme mustard-theme magit lush-theme labburn-theme key-chord jsx-mode json-mode js-doc jbeans-theme init-loader inf-clojure ido-vertical-mode highlight-parentheses helm-projectile helm-flycheck flycheck-flow find-file-in-project exec-path-from-shell evil-tabs evil-surround evil-nerd-commenter evil-leader cyberpunk-theme coverlay company-tern company-flow color-identifiers-mode clojurescript-mode clj-refactor ac-js2 ac-cider abyss-theme)))
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
;;(load-theme 'mustard t)
;; (load-theme 'cyberpunk t)
;; (load-theme 'lush t)
(load-theme 'tango-dark t)

(sml/setup)
(setq sml/theme 'powerline)

;; Make sure path is loaded if using GUI emacs
(exec-path-from-shell-initialize)


;; Enable mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)

(fset 'evil-visual-update-x-selection 'ignore)

; Override the default x-select-text function because it doesn't
; respect x-select-enable-clipboard on OS X.
(defun x-select-text (text))
(setq x-select-enable-clipboard nil)
(setq x-select-enable-primary nil)
(setq mouse-drag-copy-region nil)

(setq interprogram-cut-function 'ns-set-pasteboard)
(setq interprogram-paste-function 'ns-get-pasteboard)



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
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
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

(add-to-list 'company-backends 'company-tern 'company-flow)

(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))

;; Don't lower-case autocomplete options
(add-to-list 'company-dabbrev-code-modes 'web-mode)
(setq company-dabbrev-downcase nil)

(defun delete-tern-process ()
  (interactive)
  (delete-process "Tern"))

;; disable evil-mode keys in magit
(eval-after-load 'evil-core
  '(evil-set-initial-state 'magit-popup-mode 'emacs))


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


;; Fix evil-mode mouse weird behavior
(eval-after-load "evil-maps"
  (define-key evil-motion-state-map [down-mouse-1] nil))

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
  "co" 'coverlay-toggle-overlays
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
(key-chord-define evil-normal-state-map "ft" 'flow-minor-type-at-pos)
(key-chord-define evil-normal-state-map "tt" 'yafolding-toggle-all)
(key-chord-define evil-normal-state-map "tf" 'yafolding-toggle-element)


;; Prettier
(require 'prettier-js)
(add-hook 'js2-mode-hook 'prettier-js-mode)

(defun enable-minor-mode (my-pair)
  "Enable minor mode if filename match the regexp.  MY-PAIR is a cons cell (regexp . minor-mode)."
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
      (funcall (cdr my-pair)))))

(add-hook 'web-mode-hook #'(lambda ()
                            (enable-minor-mode
                             '("\\.jsx?\\'" . prettier-js-mode))))

 '(prettier-js-mode t)

;; Machine-specific configs, etc
(require 'init-loader)
(init-loader-load)
