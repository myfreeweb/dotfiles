;;; init-lisp.el --- initialize lisp editing settings
;;;
;;; This came from Greg V's dotfiles:
;;;      https://github.com/myfreeweb/dotfiles
;;; Feel free to steal it, but attribution is nice
;;;
;;; Thanks:
;;;  https://github.com/bodil/emacs.d
;;;  https://github.com/overtone/emacs-live

(require 'init-fns)

;; All Lisps

(setq lisp-modes '(emacs-lisp-mode lisp-mode scheme-mode clojure-mode cider-repl-mode))

(defun add-lisp-hook (f)
  (add-hooks lisp-modes f))

(add-lisp-hook 'smartparens-strict-mode)

;; Clojure

(require 'clojure-mode)

;(eval-after-load "clojure-mode" '(require 'cider))
;(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
;(add-hook 'cider-repl-mode-hook 'subword-mode)

(setq nrepl-hide-special-buffers t
      nrepl-lein-command "lein"
      nrepl-server-command "echo \"lein repl :headless\" | $SHELL -l")

(setenv "MIDJE_COLORIZE" "false")

(defun live-toggle-clj-keyword-string ()
  "convert the string or keyword at (point) from string->keyword or keyword->string."
  (interactive)
  (let* ((original-point (point)))
    (while (and (> (point) 1)
                (not (equal "\"" (buffer-substring-no-properties (point) (+ 1 (point)))))
                (not (equal ":" (buffer-substring-no-properties (point) (+ 1 (point))))))
      (backward-char))
    (cond
     ((equal 1 (point))
      (message "beginning of file reached, this was probably a mistake."))
     ((equal "\"" (buffer-substring-no-properties (point) (+ 1 (point))))
      (insert ":" (substring (live-delete-and-extract-sexp) 1 -1)))
     ((equal ":" (buffer-substring-no-properties (point) (+ 1 (point))))
      (insert "\"" (substring (live-delete-and-extract-sexp) 1) "\"")))
    (goto-char original-point)))

(define-key clojure-mode-map (kbd "C-:") 'live-toggle-clj-keyword-string)

;; Elisp

(defun remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))))

(add-hook 'emacs-lisp-mode-hook 'remove-elc-on-save)

(provide 'init-lisp)
