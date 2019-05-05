;;; packages.el --- metals layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Eduardo <doomsday@eduardo-pc>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `metals-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `metals/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `metals/pre-init-PACKAGE' and/or
;;   `metals/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst metals-packages
  '(
    scala-mode
    sbt-mode
    flycheck
    lsp-mode
    lsp-ui
    company-lsp
    lsp-scala
    )
  "The list of Lisp packages required by the metals layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")


(defun metals/init-scala-mode ()
  (use-package scala-mode
    :mode "\\.s\\(cala\\|bt\\)$")
  )


(defun metals/init-sbt-mode ()
  (use-package sbt-mode
    :commands sbt-start sbt-command
    :config
    ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
    ;; allows using SPACE when in the minibuffer
    (substitute-key-definition
     'minibuffer-complete-word
     'self-insert-command
     minibuffer-local-completion-map))
  )

;; (defun metals/init-flycheck ()
;;   (use-package flycheck
;;     :init (global-flycheck-mode)))

(defun metals/init-lsp-mode ()
  (use-package lsp-mode
    :init (setq lsp-prefer-flymake nil))
  )

(defun metals/init-lsp-ui ()
  (use-package lsp-ui))

(defun metals/init-company-lsp ()
  (use-package company-lsp))

(defun metals/init-lsp-scala ()
  (use-package lsp-scala
    :after scala-mode
    :demand t
    ;; Optional - enable lsp-scala automatically in scala files
    :hook (scala-mode . lsp)) )
;;; packages.el ends here
