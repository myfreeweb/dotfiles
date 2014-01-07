;;; This came from Greg V's dotfiles:
;;;      https://github.com/myfreeweb/dotfiles
;;; Feel free to steal it, but attribution is nice
;;;
;;; Thanks:
;;;   https://github.com/edtsech/clojure-emacs-setup
;;;   http://whattheemacsd.com
;;;   https://github.com/bodil/emacs.d

(require 'cask "~/.cask/cask.el")
(cask-initialize)

(load-theme 'zenburn t)

(add-to-list 'load-path "~/.emacs.d")
(require 'init-ido)
(require 'init-fns)
(require 'init-lisp)

(cua-mode t)
(global-hl-line-mode t)
(savehist-mode t)
(recentf-mode t)
(delete-selection-mode t)
(toggle-truncate-lines -1)
(auto-fill-mode -1)
;(set-terminal-coding-system 'utf-8)
;(set-keyboard-coding-system 'utf-8)
;(prefer-coding-system 'utf-8)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq edit-server-new-frame nil
      word-wrap nil
      confirm-nonexistent-file-or-buffer nil
      delete-by-moving-to-trash t
      next-line-add-newlines t
      tooltip-use-echo-area t
      vc-handled-backends '()
      kill-buffer-query-functions (remq 'process-kill-buffer-query-function
                                        kill-buffer-query-functions)
      redisplay-dont-pause t
      inhibit-startup-message t)

(setq-default indent-tabs-mode nil
              tab-width 2)

;; Drag Stuff
(drag-stuff-global-mode t)

;; Smart Tab
(require 'smart-tab)
(global-smart-tab-mode t)

;; Smartparens
(require 'smartparens-config)

;; Popwin
(setq display-buffer-function 'popwin:display-buffer)

;; Windmove
(global-set-key (kbd "C-j") 'windmove-up)
(global-set-key (kbd "C-k") 'windmove-down)
(global-set-key (kbd "C-l") 'windmove-right)
(global-set-key (kbd "C-h") 'windmove-left)

;; Diminish modeline clutter
(diminish 'smart-tab-mode)

;; Rainbow delimiters
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Find File In Project
(global-set-key (kbd "C-p") 'find-file-in-project)

