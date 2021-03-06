;; package --- Summary
;;; Code:
;;; Commentary:

(use-package rust-mode
  :ensure t
  :mode ("\\.rs\\'" . rust-mode)
  )

(use-package toml-mode
  :ensure t
  :mode ("\\.toml\\'" . toml-mode))
(use-package racer
  :ensure t
  :init (progn
	  (defun samray/get-rust-src-path ()
	    (let* ((command (concat "rustc --print sysroot"))
		   (rustc-sysroot-path (shell-command-to-string command))
		   (strip-path (replace-regexp-in-string "\n$" "" rustc-sysroot-path)))
	      (if (samray/is-windows)
		  (concat strip-path "\\lib\\rustlib\\src\\rust\\src")
		(concat strip-path "/lib/rustlib/src/rust/src"))))
	  (setenv "RUST_SRC_PATH" (samray/get-rust-src-path))
	  ;; Set path to racer binary
	  (setq racer-cmd (expand-file-name "~/.cargo/bin/racer"))
	  ;; Set path to rust src directory
	  (setq racer-rust-src-path  (getenv "RUST_SRC_PATH"))
  	  (add-hook 'rust-mode-hook 'racer-mode)
	  (add-hook 'racer-mode-hook 'eldoc-mode)
	  )
  )
(use-package cargo
  :ensure t
  :defer t
  :init (progn
	  (add-hook 'rust-mode-hook 'cargo-minor-mode)))
(provide 'init-rust)
;;; init-rust.el ends here
