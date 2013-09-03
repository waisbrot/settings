;; Emacs init file
;; Under Aquamacs, this is named ~/Library/Preferences/Aquamacs Emacs/Preferences.el


;; Erlang (assumes that Erlang is installed already)
(setq load-path (cons "/usr/local/lib/erlang/lib/tools-2.6.8/emacs" load-path))
(setq erlang-root-dir "/usr/local/lib/erlang")
(setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
(require 'erlang-start)

;; Auto-install: http://www.emacswiki.org/AutoInstall
(add-to-list 'load-path (expand-file-name "~/elisp"))
(require 'auto-install)

;; "Interactively Do Things": http://www.emacswiki.org/emacs/InteractivelyDoThings
;; Does buffer switching and file selection more aggressively
(require 'ido)
(ido-mode t)


;; Auto-complate: http://cx4a.org/software/auto-complete/index.html
(add-to-list 'load-path "~/.emacs.d/auto-complete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)

;; Turn off the toolbar
(if (boundp 'tool-bar-mode)
    (tool-bar-mode -1))
(menu-bar-mode -1)

;; Turn off Aquamacs buffer bar
(tabbar-mode -1)
