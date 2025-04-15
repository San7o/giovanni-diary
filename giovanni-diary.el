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
	;;(giovanni-diary-generate-rss default-directory)
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
               :makeindex t               ;; Generate the index
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
  (shell-command "./after-build.sh")
	(message "Build complete!"))

(defun giovanni-diary-set-org-agenda-files ()
	"Set the agenda files with all the files names wishlist.org
  under the diary directory.
	Then call the function ==org-agenda== to list the TODO items.
	All the items are tagged besed on the subject for easy filtering."
	(interactive)
	(setq org-agenda-files
				(directory-files-recursively (concat giovanni-diary-root-dir "content/") "wishlist.org$" t)))

(defun giovanni-diary-generate-rss ()
	"Generate RSS feed for Giovanni's Diary."
	(interactive)
	(setq root-dir giovanni-diary-root-dir)
	(load (concat root-dir "tiny-rss/tiny-rss.el"))
	(tiny-rss-generate
	 :input-directory (concat root-dir "/content")
	 :output-directory (concat root-dir "/public/feeds")
   :category-info '((:category "Ephemeris"
                               :title "Giovanni's Diary Ephemeris"
                               :link "giovanni-diary.netlify.app/ephemeris/ephemeris.html"
                               :description "Ephemeris (ἐφημερίς) is an ancient greek word meaning diary, journal. In astronomy, ephemeris refers to a book of tables describing the trajectory of astronomical objects. Here I will keep a sort of public diary with various thoughts and stuff I find interesting for the record.")
                    (:category "Surroundings"
                               :title "Giovanni's Diary Surroundings"
                               :link "giovanni-diary.netlify.com/reading/surroundings/surroundings.html"
                               :description "Surroundings is a series of descriptions of places I find myself into. It is a raw translation of what my eyes see looking outward, filtered by my own mind, in the historical period I live in. The purpose of those writings is to provide a testimony of what a place looks like and feels like in a certain moment. It indirectly records what I, Giovanni, notice and pay attention to and feel, in this particular moment of my life. ")
                    (:category "Programming"
                               :title "Giovanni's Diary Programming"
                               :link "giovanni-diary.netlify.com/programming/programming.html"
                               :description "Giovanni's programmer diary."))
   :enforce-rfc822 t))

(defun giovanni-diary-export-latex ()
  "Generate Latex book."
  (interactive)
  (setq default-directory giovanni-diary-root-dir)
  (setq org-publish-project-alist
				(list
         (list "org-site:latex"
             :recursive t
             :base-directory "./latex"
             :publishing-function 'org-latex-publish-to-latex
             :publishing-directory "./latex"
             :with-author nil
             :with-creator nil
             :with-toc nil
             :makeindex t
             :section-numbers nil
             :time-stamp-file nil)))    ;; Don't include time stamp in file
	(org-publish-all t)
  (message "Latex build completed"))
