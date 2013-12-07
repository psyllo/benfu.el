;;; benfu-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (benfu-load-elisp-or-warn-but-continue benfu-mode)
;;;;;;  "benfu" "benfu.el" (21153 4723 0 0))
;;; Generated autoloads from benfu.el

(defvar benfu-mode nil "\
Non-nil if Benfu mode is enabled.
See the command `benfu-mode' for a description of this minor mode.")

(custom-autoload 'benfu-mode "benfu" nil)

(autoload 'benfu-mode "benfu" "\
Toggle benfu mode.
   With no argument, this command toggles the mode.
   Non-null prefix argument turns on the mode.
   Null prefix argument turns off the mode.

\(fn &optional ARG)" t nil)

(autoload 'benfu-load-elisp-or-warn-but-continue "benfu" "\
Call `load' on `filename' handling `file-error' gracefully by using `warn'.
   Return non-nil on successful file load.

\(fn FILENAME)" nil nil)

;;;***

(provide 'benfu-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; benfu-autoloads.el ends here
