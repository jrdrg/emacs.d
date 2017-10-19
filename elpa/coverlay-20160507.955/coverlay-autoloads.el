;;; coverlay-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "coverlay" "coverlay.el" (22508 10841 0 0))
;;; Generated autoloads from coverlay.el

(autoload 'coverlay-load-file "coverlay" "\
(re)load lcov coverage data from FILEPATH.

\(fn FILEPATH)" t nil)

(autoload 'coverlay-reload-file "coverlay" "\
(re)load lcov coverage data from current filepath.

\(fn)" t nil)

(autoload 'coverlay-watch-file "coverlay" "\
Watch file at FILEPATH for coverage data.

\(fn FILEPATH)" t nil)

(autoload 'coverlay-toggle-overlays "coverlay" "\
Toggle coverage overlay in BUFFER.

\(fn BUFFER)" t nil)

(autoload 'coverlay-display-stats "coverlay" "\
Display buffer with current coverage statistics.

\(fn)" t nil)

(defvar coverlay-mode nil "\
Non-nil if Coverlay mode is enabled.
See the command `coverlay-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `coverlay-mode'.")

(custom-autoload 'coverlay-mode "coverlay" nil)

(autoload 'coverlay-mode "coverlay" "\
overlays for uncovered lines

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; coverlay-autoloads.el ends here
