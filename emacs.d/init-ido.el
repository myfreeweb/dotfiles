;;; init-ido.el -- initialize ido mode
;;;
;;; This came from Greg V's dotfiles:
;;;      https://github.com/myfreeweb/dotfiles
;;; Feel free to steal it, but attribution is nice
;;;
;;; Thanks:
;;;  http://whattheemacsd.com/setup-ido.el-02.html

(setq ido-everywhere t
      ;ido-ignore-buffers (append '(".*Completion" "*magit-process*" "*Pymacs*" "*Messages*") ido-ignore-buffers)
      ido-ignore-extensions t
      ido-confirm-unique-completion t
      ido-enable-flex-matching t
      ido-max-directory-size 100500)

(add-hook 'ido-setup-hook
  (lambda () ;; Go straight home
    (define-key ido-file-completion-map
      (kbd "~")
      (lambda ()
        (interactive)
        (if (looking-back "/")
          (insert "~/")
          (call-interactively 'self-insert-command))))))

(ido-mode t)

;; Smex -- ido in M-x
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(provide 'init-ido)

