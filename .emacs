(defvar emacs-dir "/home/idfumg/.emacs.d/extensions")
(add-to-list 'load-path emacs-dir)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; USEFULL FUNCTIONS INTERACTIVE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
                             "python -mjson.tool" (current-buffer) t)))

(defun byte-recompile-init-files ()
  "Recompile all of the startup files"
  (interactive)
  (byte-recompile-directory "~/.emacs.d" 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; USEFULL FUNCTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun disable-modes (modes)
  (dolist (mode modes)
    (when (functionp mode)
      (funcall mode -1))))

(defun enable-modes (modes)
  (dolist (mode modes)
    (funcall mode t)))

(defun bind-global-keys (key-fns)
  (dolist (key-fn key-fns)
    (global-set-key (kbd (car key-fn)) (cdr key-fn))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MARMALADE/ELPA/MELPA Repo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)

(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ("melpa" . "http://melpa.milkbox.net/packages/")
                  ))
  (add-to-list 'package-archives source t))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MY PACKAGES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar my/install-packages
  '(
    ;; package management
    use-package

    ;; hide modes from mode-line
    diminish

    ;; auto-complete
    company
    irony company-irony company-c-headers ;; c / c++ / objc
    anaconda-mode company-anaconda ;; python
;;    company-cmake ;; cmake
    company-statistics ;; statistics

    ;; flycheck
    ;; flycheck flycheck-tip

    ;; highlight word
    highlight-symbol

    ;; pretty smooth scrolling
    smooth-scrolling

    ;; pretty working with filesystem
    ido flx flx-ido ido-vertical-mode ido-ubiquitous

	;; compile
	smart-compile

	;; open huge files quickly
	vlf
    ))

(dolist (package my/install-packages)
  (unless (package-installed-p package)
    (package-install package)))

;; Load use-package, used for loading packages everywhere else
(require 'use-package)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SET CUSTOM VARIABLES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c++-tab-always-indent t)
 '(default-tab-width 4 t)
 '(echo-keystrokes 0.1)
 '(fill-column 80)
 '(find-file-visit-truename nil)
 '(font-use-system-font t)
 '(gc-cons-threshold 20000000)
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ru")
 '(inhibit-startup-screen t)
 '(initial-major-mode (quote fundamental-mode))
 '(jit-lock-chunk-size 1000)
 '(jit-lock-defer-time 0.01)
 '(jit-lock-stealth-load 100)
 '(jit-lock-stealth-time 1)
 '(large-file-warning-threshold (* 30 1024 1024))
 '(line-move-visual t)
 '(make-pointer-invisible nil)
 '(mouse-sel-retain-highlight t)
 '(mouse-wheel-follow-mouse t)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (3 ((shift) . 1))))
 '(query-replace-highlight t)
 '(read-file-name-completion-ignore-case t)
 '(require-final-newline t)
 '(ring-bell-function (lambda nil) t)
 '(scheme-program-name "guile-2.0")
 '(scroll-step 1)
 '(search-highlight t)
 '(sentence-end-double-space nil)
 '(show-trailing-whitespace nil)
 '(user-full-name "Pushkin Artem")
 '(user-mail-address "idfumg@gmail.com")
 '(visible-bell t)
 '(indent-tabs-mode nil)
 '(tab-width 4)
 )

(load-theme 'wombat)

;; Make sure auto automatically rescan for imenu changes:
(set-default 'imenu-auto-rescan t)

(disable-modes
 '(menu-bar-mode
   scroll-bar-mode
   tooltip-mode
   tool-bar-mode
   blink-cursor-mode
   whitespace-mode
   set-fringe-style
   delete-selection-mode
   electric-pair-mode
   guru-global-mode
   ))

(enable-modes
 '(ido-mode
   flx-ido-mode
   iswitchb-mode
   column-number-mode
   line-number-mode
   show-paren-mode
   ;; turn on syntax highlighting for all buffers.
   global-font-lock-mode
   ;; If you change buffer, or focus, disable the current buffer's mark:
   transient-mark-mode
   ;; Automatically revert file if it's changed on disk.
   global-auto-revert-mode
   ))

(bind-global-keys
 '(;; Kill whole line.
   ("C-M-k" . kill-whole-line)
   ("C-M-л" . kill-whole-line)

   ;; Goto line number.
   ("M-g" . goto-line)
   ("M-п" . goto-line)

   ;; Goto end of line.
   ("C-e" . move-end-of-line)
   ("C-у" . move-end-of-line)

   ;; Goto begin of line
   ("C-a" . move-beginning-of-line)
   ("C-ф" . move-beginning-of-line)

   ;; Bind moving keys for russian symbols.
   ("M-а" . forward-word)
   ("M-и" . backward-word)
   ("C-а" . forward-char)
   ("C-и" . backward-char)
   ("C-т" . next-line)
   ("C-з" . previous-line)

   ;; Bind delete keys.
   ("M-d" . kill-word)
   ("M-в" . kill-word)
   ("C-d" . delete-forward-char)
   ("C-в" . delete-forward-char)

   ("M--" . highlight-symbol-at-point)
   ("C-=" . highlight-symbol-next)
   ("C--" . highlight-symbol-prev)))

(require 'highlight-symbol)

;; Set yes/no -> y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Set font.
(set-default-font "DejaVu Sans Mono")
(set-language-environment 'UTF-8)

;; Set enconding.
(setq default-input-method 'russian-computer)
(prefer-coding-system 'cp866)
(prefer-coding-system 'utf-8-unix)
;; (set-default-coding-systems 'cp866)

;; Bury the *scratch* buffer, never kill it:
(defadvice kill-buffer (around kill-buffer-around-advice activate)
  (let ((buffer-to-kill (ad-get-arg 0)))
    (if (equal buffer-to-kill "*scratch*")
        (bury-buffer)
      ad-do-it)))

; savehist
(setq savehist-additional-variables
      ;; also save my search entries
      '(search-ring regexp-search-ring)
      savehist-file "~/.emacs.d/savehist")
(savehist-mode t)
(setq-default save-place t)

;; delete-auto-save-files
(setq delete-auto-save-files t)
(setq backup-directory-alist
      '(("." . "~/.emacs_backups")))

;; Prettify all the symbols, if available (an Emacs 24.4 feature).
(when (boundp 'global-prettify-symbols-mode)
  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (push '("lambda" . ?λ) prettify-symbols-alist)))
  (add-hook 'clojure-mode-hook
            (lambda ()
              (push '("fn" . ?ƒ) prettify-symbols-alist)))
  (global-prettify-symbols-mode +1))

(setq vc-handled-backends '(SVN Git))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; compile setup.
(use-package smart-compile
  :config
  (dolist (elem '((c-mode . "make -sj6")))
	(add-to-list 'smart-compile-alist elem)))

;; open huge files quickly.
(use-package vlf-setup
  :config
  (setq vlf-application 'dont-ask))

;; Uniquify buffers, using angle brackets, so you get foo and foo<2>.
(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

;; Turn on auto-fill mode in text buffers.
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(use-package diminish
  :init
  (progn
    (diminish 'auto-fill-function "AF")))

;; Hide abbrev mode from mode-line.
(use-package abbrev
  :diminish abbrev-mode)

;; Start a server if not running, but a only for text-only.
(use-package server
  :config
  (progn
    (when (not (window-system))
      (if (server-running-p server-name)
          nil
        (server-start)))))

;; Allows me to use C-c LEFT to undo window configuration changes.
(use-package winner
  :idle (winner-mode 1))

(use-package smooth-scrolling
  :config
  (setq smooth-scroll-margin 4))

(use-package ido
  :config
  (progn
    (setq ido-use-virtual-buffers nil
          ;; this setting causes weird TRAMP connections, don't set it!
          ;;ido-enable-tramp-completion nil
          ido-enable-flex-matching t
          ido-auto-merge-work-directories-length nil
          ido-create-new-buffer 'always
          ido-use-filename-at-point 'guess
          ido-max-prospects 10)))

(use-package flx-ido
  :init (flx-ido-mode 1)
  :config
  (setq ido-use-faces nil))

(use-package ido-vertical-mode
  :init (ido-vertical-mode t))

(use-package ido-ubiquitous)

(use-package company-irony
  :config
  (progn (use-package company ;; completion system
           :init
           (global-company-mode)
           (company-statistics-mode))



         (use-package irony ;; c/c++ smart completion
           :config
           (define-key irony-mode-map [remap completion-at-point]
             'irony-completion-at-point-async)
           (define-key irony-mode-map [remap complete-symbol]
             'irony-completion-at-point-async)
           (progn (add-hook 'c++-mode-hook 'irony-mode)
                  (add-hook 'c-mode-hook 'irony-mode)
                  (add-hook 'objc-mode-hook 'irony-mode)
                  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)))
         (use-package company-c-headers
           :config
           (add-to-list 'company-backends 'company-c-headers))
         (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
         (add-to-list 'company-backends 'company-irony)))

(use-package company-anaconda
  :config
  (progn (use-package company
           :init
           (global-company-mode)
           (company-statistics-mode))
         (add-to-list 'company-backends 'company-anaconda)
         (add-hook 'python-mode-hook 'anaconda-mode))
  :diminish (anaconda-mode))

;; (use-package company-cmake
;;   :config
;;   (progn (use-package company
;;            :init
;;            (global-company-mode))
;;          (add-to-list 'company-backends 'company-cmake)
;;          (add-hook 'cmake-mode-hook 'cmake-mode)))

;; (eval-after-load 'flycheck
;;   '(add-to-list 'flycheck-checkers 'irony))

;; (add-hook 'after-init-hook 'global-flycheck-mode)

;; (setq flycheck-clang-include-path "..")
;; (setq flycheck-gcc-include-path "..")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SET THEME
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (display-graphic-p)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:overline nil :inherit nil :stipple nil :background "black" :foreground "#9FBFA0" :inverse-video nil :box nil :strike-through nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(border ((t nil)))
 '(cursor ((t (:background "firebrick1" :foreground "black"))))

 '(font-lock-comment-delimiter-face ((default (:inherit font-lock-comment-face :weight ultra-bold)) (((class color) (min-colors 16)) nil)))
 '(font-lock-comment-face ((t (:foreground "gray40" :slant italic))))
 '(font-lock-doc-face ((t (:foreground "tomato" :slant italic))))
 '(font-lock-function-name-face ((t (:foreground "#447FCF" :underline nil :weight bold))))
 '(font-lock-keyword-face ((t (:foreground "#49A524" :weight bold))))
 '(font-lock-builtin-face ((t (:foreground "dark cyan" :weight bold))))
 '(font-lock-variable-name-face ((t (:foreground "sienna" :weight bold :slant italic :width normal))))
 '(font-lock-type-face ((t (:foreground "dark cyan"))))
 '(font-lock-constant-face ((t (:foreground "dark cyan"))))
 '(font-lock-string-face ((t (:foreground "#D39D13" :slant italic))))

 '(fringe ((nil (:background "black"))))
 '(highlight ((t (:background "khaki1" :foreground "black" :box (:line-width -1 :color "firebrick1")))))
 '(highlight-current-line-face ((t (:inherit highlight))))
 '(lazy-highlight ((t (:background "paleturquoise" :foreground "black"))))
 '(link ((t (:foreground "DodgerBlue3" :underline t))))
 '(menu ((t (:background "gray2" :foreground "#FFF991"))))
 '(minibuffer-prompt ((t (:foreground "dark green"))))
 '(mouse ((t (:background "Grey" :foreground "black"))))
 '(trailing-whitespace ((((class color) (background dark)) (:background "firebrick1")))))
)

; make sure the frames have the dark background mode by default
(setq default-frame-alist (quote (
  (frame-background-mode . dark)
  )))

;; Mode line setup
(setq-default
 mode-line-format
 '(
   ; read-only or modified status
   " "
   (:eval
    (cond (buffer-read-only
           (propertize "*" 'face 'mode-line-read-only-face))
          ((buffer-modified-p)
           (propertize "*" 'face 'mode-line-modified-face))
          (t "")))
   ; Position, including warning for 80 columns
   (:propertize "%5l : " face mode-line-position-face)
   (:eval (propertize "%2c" 'face
                      (if (> (current-column) 90)
                          'mode-line-90col-face
                        'mode-line-position-face)))
   "  "
   (:eval (propertize "%p" 'face 'mode-line-procent-face))
   "  "
   ; directory and buffer/file name
   ;; (:propertize (:eval (shorten-directory default-directory 30))
   ;;              face mode-line-folder-face)
   (:propertize "%b"
                face mode-line-filename-face)
   ; narrow [default -- keep?]
   "%n"
   ; mode indicators: vc, recursive edit, major mode, minor modes, process, global
   (vc-mode vc-mode)
   "  %["
   (:propertize mode-name
                face mode-line-mode-face)
   "%] "
   (:eval (propertize (format-mode-line minor-mode-alist)
                      'face 'mode-line-minor-mode-face))
   (:propertize mode-line-process
                face mode-line-process-face)
   (global-mode-string global-mode-string)
   ))

;; Helper function
;; (defun shorten-directory (dir max-length)
;;   "Show up to `max-length' characters of a directory name `dir'."
;;   (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
;;         (output ""))
;;     (when (and path (equal "" (car path)))
;;       (setq path (cdr path)))
;;     (while (and path (< (length output) (- max-length 4)))
;;       (setq output (concat (car path) "/" output))
;;       (setq path (cdr path)))
;;     (when path
;;       (setq output (concat ".../" output)))
;;     output))

;; Extra mode line faces
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-90col-face)
(make-face 'mode-line-procent-face)

(set-face-attribute 'mode-line nil
    :foreground "gray50" :background "gray20"
    :inverse-video nil
	:height 120
	:weight 'bold)
(set-face-attribute 'mode-line-inactive nil
    :foreground "gray30" :background "gray30"
    :inverse-video nil
    :box '(:line-width 1 :color "gray30" :style nil))
(set-face-attribute 'mode-line-read-only-face nil
    :inherit 'mode-line-face
    :foreground "green")
(set-face-attribute 'mode-line-modified-face nil
    :inherit 'mode-line-face
    :foreground "red")
(set-face-attribute 'mode-line-90col-face nil
    :inherit 'mode-line-position-face
	:family "Menlo"
	:weight 'bold
	:height 110
    :foreground "dark goldenrod"
	:background "gray20")
;; (set-face-attribute 'mode-line-folder-face nil
;;     :inherit 'mode-line-face
;;     :foreground "gray60")
(when (display-graphic-p) (progn
(set-face-attribute 'mode-line-position-face nil
	:inherit 'mode-line-face
	:foreground "gray50"
    :family "Menlo"
	:weight 'bold
	:height 110)
(set-face-attribute 'mode-line-procent-face nil
	:inherit 'mode-line-position-face
	:height 110
	:weight 'bold
    :foreground "gray50")
(set-face-attribute 'mode-line-filename-face nil
    :inherit 'mode-line-face
    :foreground "dark goldenrod"
	:weight 'bold
	:height 130)
(set-face-attribute 'mode-line-mode-face nil
    :inherit 'mode-line-face
    :foreground "gray50"
	:height 120)
(set-face-attribute 'mode-line-minor-mode-face nil
    :inherit 'mode-line-mode-face
    :foreground "gray50"
    :height 120)
(set-face-attribute 'mode-line-process-face nil
	:inherit 'mode-line-face
	:weight 'bold
	:height 120
    :foreground "gray50")
))

(when (not (display-graphic-p)) (progn
(set-face-attribute 'mode-line-position-face nil
	:inherit 'mode-line-face
	:foreground "magenta"
    :family "Menlo"
	:weight 'bold
	:height 110)
(set-face-attribute 'mode-line-procent-face nil
	:inherit 'mode-line-position-face
	:height 110
	:weight 'bold
    :foreground "magenta")
(set-face-attribute 'mode-line-filename-face nil
    :inherit 'mode-line-face
    :foreground "dark goldenrod"
	:weight 'bold
	:height 130)
(set-face-attribute 'mode-line-mode-face nil
    :inherit 'mode-line-face
    :foreground "magenta"
	:height 120)
(set-face-attribute 'mode-line-minor-mode-face nil
    :inherit 'mode-line-mode-face
    :foreground "magenta"
    :height 120)
(set-face-attribute 'mode-line-process-face nil
	:inherit 'mode-line-face
	:weight 'bold
	:height 120
    :foreground "magenta")
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SET INTENDATION
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(c-add-style "mycodingstyle"
             '((c-basic-offset . 4)
               (c-comment-only-line-offset . 0)
               (c-hanging-braces-alist . ((substatement-open before after)))
               (c-offsets-alist . ((topmost-intro        . 0)
                                   (topmost-intro-cont   . 0)
                                   (substatement         . 4)
                                   (substatement-open    . 4)
                                   (statement-case-open  . 4)
                                   (statement-cont       . 4)
                                   (access-label         . -4)
                                   (inclass              . 4)
                                   (inline-open          . 0)
                                   (innamespace          . 4)
                                   ))))
;; treat all tabs to spaces
(defun intendation-c-mode-hook ()
  (c-set-style "mycodingstyle"))

(add-hook 'c-mode-common-hook   'intendation-c-mode-hook)
(add-hook 'c++-mode-common-hook 'intendation-c-mode-hook)

(defun intend-by-ret ()
  (local-set-key (kbd "RET") 'newline-and-indent))

(add-hook 'slime-mode-hook      'intend-by-ret)
(add-hook 'emacs-lisp-mode-hook 'intend-by-ret)
(add-hook 'lisp-mode-hook       'intend-by-ret)
(add-hook 'c-mode-common-hook   'intend-by-ret)
(add-hook 'c++-mode-common-hook 'intend-by-ret)
(add-hook 'python-mode-hook     'intend-by-ret)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C & C++ HOOKS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key (kbd "C-4") 'ff-find-other-file)))

;; (defun run-python-once ()
;;   (remove-hook 'python-mode-hook 'run-python-once)
;;   (run-python))

(add-hook 'python-mode-hook
          (lambda()
            (run-python "/usr/bin/python")))
