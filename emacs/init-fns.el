;;; init-fns.el -- initialize custom functions and keybindings
;;;
;;; This came from Greg V's dotfiles:
;;;      https://github.com/unrelentingtech/dotfiles
;;; Feel free to steal it, but attribution is nice
;;;
;;; Thanks:
;;;  http://whattheemacsd.com/setup-shell.el-01.html
;;;  http://whattheemacsd.com/key-bindings.el-03.html
;;;  https://stackoverflow.com/questions/88399/how-do-i-duplicate-a-whole-line-in-emacs
;;;  https://github.com/bodil/emacs.d

;; OS X copy-paste

(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;; Add hook to multiple modes

(defun add-hooks (modes func)
  (dolist (mode modes)
    (add-hook (intern (concat (symbol-name mode) "-hook")) func)))

;; Comment/uncomment

(defun comment-or-uncomment-line ()
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(global-set-key (kbd "C-\\") 'comment-or-uncomment-line)

;; Kill buffers

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

;; Kill shell with C-d when empty

(defun comint-delchar-or-eof-or-kill-buffer (arg)
  (interactive "p")
  (if (null (get-buffer-process (current-buffer)))
      (kill-buffer)
    (comint-delchar-or-maybe-eof arg)))

(add-hook 'shell-mode-hook
          (lambda ()
            (define-key shell-mode-map
              (kbd "C-d") 'comint-delchar-or-eof-or-kill-buffer)))

;; Join

(global-set-key (kbd "M-j")
                (lambda ()
                  (interactive)
                  (join-line -1)))

;; Paragraph movement

(global-set-key (kbd "M-[") 'backward-sentence)
(global-set-key (kbd "M-]") 'forward-sentence)

;; Duplicate

(defun duplicate-line ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))

(global-set-key (kbd "C-d") 'duplicate-line)

(provide 'init-fns)
