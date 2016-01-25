;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(auto-completion
     colors
     emacs-lisp
     javascript
     html
     react
     ;; git
     markdown
     org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     (spell-checking :variables
                      spell-checking-enable-by-default nil)
     syntax-checking
     unimpaired
     (version-control :variables
                       version-control-diff-tool 'diff-hl
                       version-control-global-margin t))

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(tern-auto-complete
     diff-hl)

   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages
   '(vi-tilde-fringe)

   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update t
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner nil
   dotspacemacs-startup-lists '(recents bookmarks projects)
   dotspacemacs-startup-recent-list-size 5
   dotspacemacs-themes '(spacemacs-dark)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font
   '("Source Code Pro"
     :size 13
     :weight normal
     :width normal
     :powerline-scale 1.15)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   dotspacemacs-command-key ":"
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-use-ido nil
   dotspacemacs-helm-resize t
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-enable-paste-micro-state t
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar nil
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup t
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers nil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'changed))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put almost
any user code here.  The exception is org related code, which should be placed
in `dotspacemacs/user-config'."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  ;; When we are within Windows, Emacs can't seem to find Tern.
  (when (eq system-type 'windows-nt)
    (setq tern-command '("c:/Users/Lewis/AppData/Roaming/npm/tern")))

  ;; Provide access to clipboard entries created outside of Emacs.
  (fset 'evil-visual-update-x-selection 'ignore)

  ;; Replace active region inserting text.
  (delete-selection-mode 1)

  ;; Binding for toggling whitespace. Useful when checking for tab indents.
  (global-set-key (kbd "<f8>") 'whitespace-mode)

  ;; Binding for removing tabs in buffer
  (global-set-key
   (kbd "<f7>")
   (lambda ()
     (interactive)
     (untabify (point-min) (point-max))))

  ;; Switching to a buffer will force normal mode.
  (add-hook 'window-configuration-change-hook 'evil-force-normal-state)

  ;; Enable support for Dust templates.
  (add-to-list 'auto-mode-alist '("\\.dust\\'" . web-mode))
  (setq web-mode-engines-alist  '(("dust" . "\\.dust\\'")))

  (defun lewie9021/js2-mode-hook ()
    "Hook when js2-mode is enabled"
    (diff-hl-mode t))

  (add-hook 'js2-mode-hook 'lewie9021/js2-mode-hook)

  ;; Make diff-hl update the margin on the fly.
  (setq diff-hl-flydiff-mode t)
  ;; Make diff-hl show changes on the right margin.
  (setq diff-hl-side 'right)

  ;; Declare 4 space indentations.
  (setq web-mode-script-padding 4)
  (setq web-mode-style-padding 4)
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-attr-indent-offset 2)

  ;; Adds highlighting of many Ecma built-in functions.
  (setq js2-highlight-level 3)

  ;; Switch statement body is indented one additional level.
  (setq js2-indent-switch-body t)

  ;; Prevent warning if return values aren't the same.
  (setq js2-strict-inconsistent-return-warning nil)

  ;; Include Node.js externs in the master externs list.
  (setq js2-include-node-externs t)

  ;; Load computer-specific configuration.
  (when (file-exists-p "~/local.el")
    (load "~/local.el")))
