;;; This came from Greg V's dotfiles:
;;;      https://github.com/myfreeweb/dotfiles
;;; Feel free to steal it, but attribution is nice
;;;
;;; Thanks:
;;;   https://github.com/edtsech/clojure-emacs-setup
;;;   http://whattheemacsd.com
;;;   https://github.com/bodil/emacs.d

(add-to-list 'load-path "~/.emacs.d")
(require 'cask "~/.cask/cask.el")
(cask-initialize)

(load-theme 'base16-default t)

(require 'init-ido)
(require 'init-fns)
(require 'init-lisp)

(global-hl-line-mode t)
(savehist-mode t)
(recentf-mode t)
(delete-selection-mode t)
(toggle-truncate-lines -1)
(auto-fill-mode -1)
(setq initial-major-mode 'text-mode)
;(set-terminal-coding-system 'utf-8)
;(set-keyboard-coding-system 'utf-8)
;(prefer-coding-system 'utf-8)
(defalias 'yes-or-no-p 'y-or-n-p)
(require 'uniquify)
(setq uniquify-ignore-buffers-re "^\\*")

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
      inhibit-startup-message t
      backup-by-copying t
      backup-directory-alist '(("." . "~/.tmp/emacs"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(setq-default indent-tabs-mode nil
              tab-width 2)

;; Evil
(require 'evil-leader)
(setq evil-leader/in-all-states 1)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key "f" 'find-file)
(require 'evil)
(evil-mode t)
(define-key evil-normal-state-map (kbd "k") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "j") 'evil-previous-visual-line)
(define-key evil-normal-state-map (kbd "<left>") 'evil-prev-buffer)
(define-key evil-normal-state-map (kbd "<right>") 'evil-next-buffer)
(define-key global-map (kbd "RET") 'newline-and-indent)
(require 'evil-search-highlight-persist)
(global-evil-search-highlight-persist t)
(define-key evil-normal-state-map (kbd "RET") 'evil-search-highlight-persist-remove-all)
(require 'evil-numbers)
(define-key evil-normal-state-map (kbd "+") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "-") 'evil-numbers/dec-at-pt)
(unless (display-graphic-p)
  (require 'evil-terminal-cursor-changer))

;; Powerline
(require 'powerline)
(powerline-evil-vim-color-theme)

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
(diminish 'undo-tree-mode)

;; Rainbow delimiters
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Find File In Project
(evil-leader/set-key "p" 'find-file-in-project)
