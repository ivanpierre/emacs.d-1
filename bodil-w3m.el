;;; bodil-w3m.el -- Settings for the w3m web browser.

(require 'w3m-search)

(setq w3m-use-cookies t)
(setq w3m-use-favicon t)
(setq w3m-use-header-line t)
(setq w3m-use-header-line-title nil)
(setq w3m-use-tab t)
(setq w3m-use-tab-menubar t)

;; Bind a global shortcut for searching the web
(global-set-key (kbd "C-x C-g") 'w3m-search)

;; Search shortcuts
(add-to-list 'w3m-search-engine-alist
             '("emacs-wiki" "http://www.emacswiki.org/cgi-bin/wiki.pl?search=%s"))
(add-to-list 'w3m-search-engine-alist
             '("stack overflow" "http://stackoverflow.com/search?q=%s"))

(setq w3m-uri-replace-alist
      (quote (("\\`g:" w3m-search-uri-replace "google")
              ("\\`gg:" w3m-search-uri-replace "google groups")
              ("\\`urn:ietf:rfc:\\([0-9]+\\)" w3m-pattern-uri-replace "http://www.ietf.org/rfc/rfc\\1.txt")
              ("\\`wiki:" w3m-search-uri-replace "en.wikipedia")
              ("\\`ewiki:" w3m-search-uri-replace "emacs-wiki")
              ("\\`so:" w3m-search-uri-replace "stack overflow"))))

;; Remove annoying trailing whitespace from rendered pages
(add-hook 'w3m-display-hook
          (lambda (url)
            (let ((buffer-read-only nil))
              (delete-trailing-whitespace))))

;; Keymap from http://www.emacswiki.org/emacs/WThreeMKeymap
(let ((map (make-keymap)))
  (suppress-keymap map)
  (define-key map [backspace] 'w3m-scroll-down-or-previous-url)
  (define-key map [delete] 'w3m-scroll-down-or-previous-url)
  (define-key map "\C-?" 'w3m-scroll-down-or-previous-url)
  (define-key map "\t" 'w3m-next-anchor)
  (define-key map [(shift tab)] 'w3m-previous-anchor)
  (define-key map [(shift iso-left-tab)] 'w3m-previous-anchor)
  (define-key map "\C-m" 'w3m-view-this-url)
  (define-key map [(shift return)] 'w3m-view-this-url-new-session)
  (define-key map [(shift kp-enter)] 'w3m-view-this-url-new-session)
  (define-key map [(button2)] 'w3m-mouse-view-this-url)
  (define-key map [(shift button2)] 'w3m-mouse-view-this-url-new-session)
  (define-key map " " 'scroll-up)
  (define-key map "a" 'w3m-bookmark-add-current-url)
  (define-key map "\M-a" 'w3m-bookmark-add-this-url)
  (define-key map "+" 'w3m-antenna-add-current-url)
  (define-key map "A" 'w3m-antenna)
  (define-key map "c" 'w3m-print-this-url)
  (define-key map "C" 'w3m-print-current-url)
  (define-key map "d" 'w3m-download)
  (define-key map "D" 'w3m-download-this-url)
  ;; (define-key map "D" 'w3m-download-with-wget)
  ;; (define-key map "D" 'w3m-download-with-curl)
  (define-key map "g" 'w3m-goto-url)
  (define-key map "G" 'w3m-goto-url-new-session)
  (define-key map "h" 'describe-mode)
  (define-key map "H" 'w3m-gohome)
  (define-key map "I" 'w3m-toggle-inline-images)
  (define-key map "\M-i" 'w3m-save-image)
  (define-key map "M" 'w3m-view-url-with-external-browser)
  (define-key map "n" 'w3m-view-next-page)
  (define-key map "N" 'w3m-namazu)
  (define-key map "o" 'w3m-history)
  (define-key map "O" 'w3m-db-history)
  (define-key map "p" 'w3m-view-previous-page)
  (define-key map "q" 'w3m-close-window)
  (define-key map "Q" 'w3m-quit)
  (define-key map "R" 'w3m-reload-this-page)
  (define-key map "s" 'w3m-search)
  (define-key map "S" (lambda ()
                        (interactive)
                        (let ((current-prefix-arg t))
                          (call-interactively 'w3m-search))))
  (define-key map "u" 'w3m-view-parent-page)
  (define-key map "v" 'w3m-bookmark-view)
  (define-key map "W" 'w3m-weather)
  (define-key map "=" 'w3m-view-header)
  (define-key map "\\" 'w3m-view-source)
  (define-key map "?" 'describe-mode)
  (define-key map ">" 'scroll-left)
  (define-key map "<" 'scroll-right)
  (define-key map "." 'beginning-of-buffer)
  (define-key map "^" 'w3m-view-parent-page)
  (define-key map "]" 'w3m-next-form)
  (define-key map "[" 'w3m-previous-form)
  (define-key map "}" 'w3m-next-image)
  (define-key map "{" 'w3m-previous-image)
  (define-key map "\C-c\C-c" 'w3m-submit-form)
  (setq dka-w3m-map map))
(add-hook 'w3m-mode-hook '(lambda () (use-local-map dka-w3m-map)))
