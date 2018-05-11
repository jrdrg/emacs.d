;;; reason-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "reason-mode" "reason-mode.el" (23275 32774
;;;;;;  0 0))
;;; Generated autoloads from reason-mode.el

(autoload 'reason-mode "reason-mode" "\
Major mode for Reason code.

\\{reason-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.rei?\\'" . reason-mode))

;;;***

;;;### (autoloads nil "refmt" "refmt.el" (23275 32774 0 0))
;;; Generated autoloads from refmt.el

(autoload 'refmt-before-save "refmt" "\
Add this to .emacs to run refmt on the current buffer when saving:
 (add-hook 'before-save-hook 'refmt-before-save).

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("reason-indent.el" "reason-interaction.el"
;;;;;;  "reason-mode-pkg.el") (23275 32774 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; reason-mode-autoloads.el ends here
