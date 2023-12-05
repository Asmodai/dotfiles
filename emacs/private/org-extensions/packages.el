;;; packages.el --- org-extensions layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2022 Sylvain Benner & Contributors
;;
;; Author: Paul Ward <asmodai@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `org-extensions-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `org-extensions/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `org-extensions/pre-init-PACKAGE' and/or
;;   `org-extensions/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst org-extensions-packages
  '(ob-bitfield
    plantuml-mode
    consult-org-roam
    citar
    org-roam-bibtex
    org-bullets
    citar-org-roam))

(defun org-extensions/init-ob-bitfield ()
  (use-package ob-bitfield
    :defer t
    :after org
    :init
    (progn
      (org-babel-do-load-languages 'org-babel-load-languages
                                   '((bitfield . t))))))

(defun org-extensions/init-plantuml-mode ()
  (use-package plantuml-mode
    :defer t
    :after org
    :config
    (progn
      (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
      (setq-default plantuml-jar-path          "~/.emacs.d/private/local/java/plantuml.jar"
                    org-plantuml-jar-path      "~/.emacs.d/private/local/java/plantuml.jar"
                    plantuml-default-exec-mode 'jar)
      (org-babel-do-load-languages 'org-babel-load-languages
                                   '((plantuml . t))))))

(defun org-extensions/init-consult-org-roam ()
  (use-package consult-org-roam
    :defer t
    :after org-roam
    :init
    (progn
      (require 'consult-org-roam)
      (consult-org-roam-mode 1))
    :custom
    (consult-org-roam-grep-func #'consult-ripgrep)
    (consult-org-roam-buffer-narrow-key ?r)
    (consult-org-roam-buffer-after-buffers t)
    :config
    (consult-customize
     consult-org-roam-forward-links :preview-key (kbd "M-."))
    :bind
    ("C-c n e" . consult-org-roam-file-find)
    ("C-c n b" . consult-org-roam-backlinks)
    ("C-c n l" . consult-org-roam-forward-links)
    ("C-c n r" . consult-org-roam-search)))

(defun org-extensions/init-citar ()
  (use-package citar
    :defer t
    :custom
    (citar-bibliography "~/Dropbox/org-roam/books.bib")
    :hook
    (LaTeX-mode . citar-capf-setup)
    (org-mode . citar-capf-setup)))


(defun org-extensions/init-org-roam-bibtex ()
  (use-package org-roam-bibtex
    :after (org-roam citar)
    :config
    (progn
      (require 'org-ref))))

(defun org-extensions/init-citar-org-roam ()
  (use-package citar-org-roam
    :defer t
    :after (org-roam citar org-roam-bibtex)
    :config (citar-org-roam-mode)
    :init
    (progn
      (require 'citar-org-roam)
      (citar-register-notes-source
       'org-citar-source (list :name "Org-Roam Notes"
                               :category 'org-roam-node
                               :items #'citar-org-roam--get-candidates
                               :hasitems #'citar-org-roam-has-notes
                               :open #'citar-org-roam-open-note
                               :create #'orb-citar-edit-node
                               :annotate #'citar-org-roam--annotate))
      (setq citar-notes-source                 'orb-citar-souce
            citer-org-roam-note-title-template "${title} - ${author}"
            org-roam-capture-templates '(("d" "default" plain
                                          "%?"
                                          :target (file+head
                                                   "${slug}.org"
                                                   "#+title: ${note-title}\n")
                                          :unnarrowed t)
                                         ("n" "literature note" plain
                                          "%?"
                                          :target (file+head
                                                   "${slug}.org"
                                                   "#+title: ${note-title}\n#+cite_key: ${citar-citekey}\n#+created: %U\n\n")
                                          :unnarrowed t))))))

(defun org-extensions/init-org-bullets ()
  (use-package org-bullets
    :defer t
    :config
    (add-hook 'org-mode-hook (lambda ()
                               (org-bullets-mode 1)))))

(defun org-extensions/post-init-org-bullets ()
  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook (lambda ()
                             (auto-fill-mode 1)
                             (org-num-mode 1))))

