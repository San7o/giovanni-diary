;; Load the publishing system
(require 'ox-publish)
(require 'org-agenda)

(defgroup giovanni-diary nil
	"Options for giovanni-diary"
	:tag "giovanni-diary"
	:group 'giovanni-diary)

(defcustom giovanni-diary-root-dir "~/giovanni-diary/"
	"Root directory of the diary."
	:group 'giovanni-diary
	:type 'string)

(defun giovanni-diary-rebuild-site ()
	"Rebuild the entire website with default options."
	(interactive)
	(setq default-directory giovanni-diary-root-dir)
	(shell-command "./prepare-build.sh")
	(giovanni-diary-generate-rss default-directory)
	(setq org-publish-project-alist
				(list
				 (list "org-site:main"
							 :recursive t
							 :base-directory "./content"
							 :publishing-function 'org-html-publish-to-html
							 :publishing-directory "./public"
							 :with-author nil           ;; Don't include author name
							 :with-creator nil          ;; Don't include Emacs and Org versions in footer
							 :with-toc nil              ;; Don't include a table of contents
							 :section-numbers nil       ;; Don't include section numbers
							 :time-stamp-file nil)))    ;; Don't include time stamp in file
	;; Customize the HTML output
	(setq org-html-validation-link nil            ;; Don't show validation link
				org-html-head-include-scripts nil       ;; Use our own scripts
				org-html-head-include-default-style nil ;; Use our own styles
				;; org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")
				org-html-head "<link rel=\"stylesheet\" href=\"/simple.css\" />")
	;; Generate the site output
	(org-publish-all t)
	(message "Build complete!"))

(defun giovanni-diary-set-org-agenda-files ()
	"Set the agenda files with all the files names wishlist.org
  under the diary directory.
	Then call the function ==org-agenda== to list the TODO items.
	All the items are tagged besed on the subject for easy filtering."
	(interactive)
	(setq org-agenda-files
				(directory-files-recursively (concat giovanni-diary-root-dir "content/") "wishlist.org$" t)))

(defun giovanni-diary-generate-rss (root-dir)
	"Generate RSS feed for Giovanni's Diary."
	(load (concat root-dir "tiny-rss/tiny-rss.el"))
	(tiny-rss-generate
	 :input-directory (concat root-dir "/content")
	 :output-directory (concat root-dir "/public/feeds")
	 :title "Giovanni's Diary"
	 :link "giovanni-diary.netlify.app"
	 :description "RSS Feed for Giovanni's Diary"))
