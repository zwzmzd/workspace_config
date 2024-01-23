(setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
			 ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; install dependencies
(mapc
 (lambda (package)
   (or (package-installed-p package)
       (package-install package)))
 '(zenburn-theme magit clang-format google-c-style))

(load-theme 'zenburn t)
(menu-bar-mode -1)

(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-to-list 'auto-mode-alist '("\\.bazel\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.bzl\\'" . python-mode))
(add-to-list 'auto-mode-alist '("BUILD\\'" . python-mode))
(add-to-list 'auto-mode-alist '("WORKSPACE\\'" . python-mode))

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
(defun c-open-other-file ()
  "if current file is a header file, then open the
       corresponding source file or vice versa.
      "
  (interactive)
  (let ((f (buffer-file-name))
	(headers '("h" "hpp" "hxx"))
	(sources '("c" "cxx" "cpp" "cc")))
    (if f
	(let* ((b (file-name-sans-extension f))
	       (x (file-name-extension f))
	       (s (cond
		   ((member x headers) sources)
		   ((member x sources) headers)
		   (t nil)))
	       (return-value nil))
	  (while s
	    (let ((try-file (concat b "." (car s))))
	      (cond
	       ((find-buffer-visiting try-file)
		(switch-to-buffer (find-buffer-visiting
				   try-file))
		(setq s nil
		      return-value t))
	       ((file-readable-p try-file)
		(find-file try-file)
		(setq s nil
		      return-value t))
	       (t (setq s (cdr s))))))
	  return-value))))
(global-set-key (kbd "C-x t") 'c-open-other-file)

(show-paren-mode t)
(setq show-paren-style 'parentheses)

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

(defun c++-mode-clang-format-keys ()
  "Modify keymaps used by `irony-mode'."
  (local-set-key [tab] 'clang-format-region)
  (local-set-key (kbd "TAB") 'clang-format-region))
(add-hook 'c++-mode-hook 'c++-mode-clang-format-keys)

(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; workaround for magit 20240112 version
(unless (fboundp 'seq-keep)
  (defun seq-keep (function sequence)
    "Apply FUNCTION to SEQUENCE and return the list of all the non-nil results."
    (delq nil (seq-map function sequence))))
