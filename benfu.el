;;; benfu.el --- The home of some personal Emacs extensions

;; Copyright 2013 Benjamin Cluff

;; Author: Benjamin Cluff <psyllo@gmail.com>
;; URL: https://github.com/psyllo/benfu.el
;; Created: 05-Dec-2013
;; Version: 20131205.0001
;; Keywords: personal

;;; Synopsis:
;;   * Code for just about anything that doesn't have its own project/package.
;;   * Things to do with working in lisp dialects.
;;   * Paredit key binding adjustments for things like Macs and terminals.
;;   * Ad-hoc keyboard macros for various things.
;;   * Niceties like: `benfu-undo-until-reverted'

;;; Usage:
;;   (require 'benfu)
;;   (setq benfu-mode t)


(defgroup benfu-mode nil
  "Benfu is a minor mode for Benjamin Cluff's personal emacs extensions.
   Not designed for others."
  :prefix "benfu-"
  :group 'personal)

(defcustom benfu-menu-string "Benfu"
  "The string that appears in the menu.")

;;;###autoload
(define-minor-mode benfu-mode
  "Toggle benfu mode.
   With no argument, this command toggles the mode.
   Non-null prefix argument turns on the mode.
   Null prefix argument turns off the mode."
  ;; The initial value.
  :init-value nil
  ;; The indicator for the mode line.
  :lighter " Benfu"
  ;; This mode is best as a global minor mode
  :global t
  ;; The minor mode bindings.
  :keymap
  '(("\C-s"    . isearch-forward)
    ("\C-cbu"  . benfu-undo-until-reverted)
    ("\C-c;"   . benfu-comment-sexp)

    ;; paredit keys for Mac + terminals
    ("\C-cw"   . paredit-copy-as-kill)
    ;; ("\C-cbw"  . paredit-copy-as-kill)
    ;; ("\C-cbfs" . paredit-forward-slurp-sexp)
    ;; ("\C-cbbs" . paredit-backward-slurp-sexp)
    ;; ("\C-cbfb" . paredit-forward-barf-sexp)
    ;; ("\C-cbbb" . paredit-backward-barf-sexp)

    ;; paredit with Hyper key
    ;; ([(hyper ?f)] . paredit-forward-slurp-sexp)
    ;; ([(hyper ?b)] . paredit-forward-barf-sexp)
    ;; ([(hyper ?p)] . paredit-convolute-sexp)
    ;; ([(hyper ?n)] . paredit-backward-slurp-sexp)
    ;; ([(hyper ?r)] . paredit-raise-sexp)
    ;; ([(hyper ?s)] . paredit-splice-sexp)
    ;; ([(hyper ?\()] . paredit-wrap-round) ;; paredit overrides this :(
    ;; ([(hyper ?\{)] . paredit-wrap-curly)
    ;; ([(hyper ?\|)] . paredit-wrap-square)

    ;; paredit functions not bound be default
    ;; NOTE: The following 2 are related to paredit-join-sexps (M-J)
    ("\C-c[n"  . paredit-add-to-next-list)
    ("\C-c[p"  . paredit-add-to-previous-list)

    ;; mark-sexp (C-M-SPC) keys for Mac + terminal
    ("\C-c "   . mark-sexp) ; A portable convenient alternative to C-M-SPC
    ("\M-[ "   . mark-sexp) ; Bind to the sequence I configured iTerm2 to send
    )
  :group 'benfu-mode)

;;;; Non-interactive functions

;;;###autoload
(defun benfu-load-elisp-or-warn-but-continue (filename)
  "Call `load' on `filename' handling `file-error' gracefully by using `warn'.
   Return non-nil on successful file load."
  (condition-case nil
      ;; TODO: Not using `expand-file-name' so that `load' with `load-path'
      ;; but it could be a useful addition.
      (load filename)
    (file-error
     (warn "benfu: Failed to load '%s' - continuing anyway" filename)
     nil)))

;;;; Interactive functions (commands)

;;; Undo buffer until reverted
;; Inspired by: http://www.emacswiki.org/emacs/RevertBuffer
(defun benfu-undo-until-reverted ()
  "Undo all edits until the buffer is unmodified."
  (interactive)
  (when (buffer-modified-p)
    (undo))
  (while (buffer-modified-p)
    (undo-more 1))
  (message "benfu: Buffer was undone until no longer modified."))

(defun benfu-comment-sexp ()
  "Essentially `mark-sexp' then `comment-sexp'"
  (interactive)
  (fset 'benfu-comment-sexp-kbd-macro "\C-[xmark-sexp\C-m\C-[;")
  (execute-kbd-macro 'benfu-comment-sexp-kbd-macro))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'benfu)

;;; benfu.el ends here
