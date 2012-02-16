;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; 日本語設定                                           ■
;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
; font-lockの設定
(global-font-lock-mode t)

;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; 基本設定                                             ■
;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
;; フォント
(set-face-attribute 'default nil :family "Ricty" :height 180)
(if window-system (progn
  (set-fontset-font "fontset-default" 'japanese-jisx0208 '("Ricty" . "iso10646-*"))
))
;; ツールバーを非表示
(if window-system (progn
  ; ツールバーの非表示
  (tool-bar-mode -1))
)
;; 何文字目にいるか表示
(column-number-mode 1)
;; 常にホームディレクトリから
(cd "~")
;; 起動時の画面はいらない
(setq inhibit-startup-message t)
;;;リージョンの色
(setq transient-mark-mode t)
;;;最近使ったファイル
(recentf-mode 1)
;;M-x recentf-open-files
;;http://www.bookshelf.jp/soft/meadow_23.html#SEC243
;;; 新しいフレームを開かない
(setq gnuserv-frame (selected-frame)) 
;;;Yes/No y/n
(fset 'yes-or-no-p 'y-or-n-p)
;; diredの履歴
(icomplete-mode 1)
;; ウィンドウの透明化
(add-to-list 'default-frame-alist '(alpha . (0.80 0.80)))
;; タイトルバーにファイル名表示
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))

;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; 拡張設定   以下は拡張                                ■
;                                                      ■
;                                                      ■
;                                                      ■
;                                                      ■
;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
;;;; パス設定
(setq load-path (append '("~/.emacs.d"
			  "~/.emacs.d/color-theme/"
			  "~/.emacs.d/site-lisp/"
			  "~/.emacs.d/remember/"
			  ) load-path))

;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; 前回画面サイズ復元                                   ■
;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
(defun my-window-size-save ()
  (let* ((rlist (frame-parameters (selected-frame)))
         (ilist initial-frame-alist)
         (nCHeight (frame-height))
         (nCWidth (frame-width))
         (tMargin (if (integerp (cdr (assoc 'top rlist)))
                      (cdr (assoc 'top rlist)) 0))
         (lMargin (if (integerp (cdr (assoc 'left rlist)))
                      (cdr (assoc 'left rlist)) 0))
         buf
         (file "~/.framesize.el"))
    (if (get-file-buffer (expand-file-name file))
        (setq buf (get-file-buffer (expand-file-name file)))
      (setq buf (find-file-noselect file)))
    (set-buffer buf)
    (erase-buffer)
    (insert (concat
             ;; 初期値をいじるよりも modify-frame-parameters
             ;; で変えるだけの方がいい?
             "(delete 'width initial-frame-alist)\n"
             "(delete 'height initial-frame-alist)\n"
             "(delete 'top initial-frame-alist)\n"
             "(delete 'left initial-frame-alist)\n"
             "(setq initial-frame-alist (append (list\n"
             "'(width . " (int-to-string nCWidth) ")\n"
             "'(height . " (int-to-string nCHeight) ")\n"
             "'(top . " (int-to-string tMargin) ")\n"
             "'(left . " (int-to-string lMargin) "))\n"
             "initial-frame-alist))\n"
             ;;"(setq default-frame-alist initial-frame-alist)"
             ))
    (save-buffer)
    ))

(defun my-window-size-load ()
  (let* ((file "~/.framesize.el"))
    (if (file-exists-p file)
        (load file))))

(my-window-size-load)

;; Call the function above at C-x C-c.
(defadvice save-buffers-kill-emacs
  (before save-frame-size activate)
  (my-window-size-save))

;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; 括弧の対応表示                                       ■
;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
(setq blink-matching-paren t)
(show-paren-mode t)
(setq paren-sexp-mode t)

;; Command-Key and Option-Key
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; 現在行の設定設定                                     ■
;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
(defface hlline-face
  '((((class color)
      (background dark))
     ;;(:background "dark state gray"))
     (:background "gray10"
                  :underline "gray24"))
    (((class color)
      (background light))
     (:background "ForestGreen"
                  :underline nil))
    (t ()))
  "*Face used by hl-line.")
;;(setq hl-line-face 'underline)
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)


;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; カラーの設定                                         ■
;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
(require 'color-theme)
(color-theme-initialize)
(color-theme-midnight)

;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; Coffee-scriptの設定                                  ■
;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
(require 'coffee-mode)
;; coffee-mode
(defun coffee-custom ()
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 2)
 ;; Emacs key binding
 (define-key coffee-mode-map [(meta R)] 'coffee-compile-buffer)
 (define-key coffee-mode-map [(meta r)] 'coffee-compile-region)
 )
(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; pc-bufsw.elの設定                                    ■
;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
;(require 'pc-bufsw)

;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; remember.elの設定         ■
;■■■■■■■■■■■■■■■■■■■■■■■■■■■■
(require 'remember)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cr" 'org-remember)
(setq org-directory "~/memo/")
(setq remember-data-file "~/.notes.org")
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-agenda-files '("~/memo/memo.txt"))
