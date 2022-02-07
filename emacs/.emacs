(setq package-archives '(("gnu" . "http://mirrors.ustc.edu.cn/elpa/gnu/")
			 ("melpa" . "http://mirrors.ustc.edu.cn/elpa/melpa/")
			 ("melpa-stable" . "http://mirrors.ustc.edu.cn/elpa/melpa-stable/")
			 ("org" . "http://mirrors.ustc.edu.cn/elpa/org/")))
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(menu-bar-mode -1)

(setq locale-coding-system'utf-8)
(setq grep-command "grep --exclude=\"*\\.svn*\" -nHi -e ")
(setq grep-cpp-command "grep --include=\"*\\.cc\" --include=\"*\\.cpp\" --include=\"*\.h\" -nHi -e ")
(setq grep-etest-command "grep --exclude=\"*/test*\" --include=\"*\\.cpp\" --include=\"*\.h\" \. -r -nHi -e ")
(setq grep-py-command "grep --include=\"*\\.py\" -nHi -e ")
(defun grepcpp(command-args)
  (interactive
   (list (read-from-minibuffer "Run grep *.cpp *.h: "
			       grep-cpp-command
			       nil
			       nil
			       'grep-cpp-history)))
         (grep command-args))

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(global-set-key (kbd "M-i") 'find-file-at-point)


;;compilation settings
(defun my-compile()
  "Save buffers and start compile"
  (interactive)
  (save-some-buffers t)
  (switch-to-buffer-other-window "*compilation*")
  (compile compile-command))
(global-set-key [f6] 'my-compile)

(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-item-highlight ((t (:inherit nil))))
 '(region ((t (:background "blue" :foreground "white")))))
(defun disable-magit-highlight-in-buffer ()
  (face-remap-add-relative 'magit-item-highlight '()))
(add-hook 'magit-status-mode-hook 'disable-magit-highlight-in-buffer)
