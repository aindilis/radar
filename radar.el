;; see /var/lib/myfrdcsa/codebases/internal/radar/function-documentation.txt
(global-set-key "\C-creL" 'radar-open-function-documentation)

(global-set-key "\C-crr" 'radar-jump-to-radar-directory)
(global-set-key "\C-crp" 'radar-jump-to-packager-directory)
(global-set-key "\C-crf" 'radar-jump-to-myfrdcsa-directory)
(global-set-key "\C-crea" 'radar-apt-utils)

;; (global-set-key "\C-crem" 'radar-myfrdcsa-utils)
(global-set-key "\C-creS" 'radar-dired-system-scripts-dir)

(global-set-key "\C-cres" 'radar-edit-system-frdcsa-file)
(global-set-key "\C-cree" 'radar-edit-system-emacs-code)
(global-set-key "\C-crepro" 'radar-edit-system-prolog-code)
(global-set-key "\C-creE" 'radar-edit-system-emacs-code-all)
(global-set-key "\C-crei" 'radar-edit-item-in-path)
(global-set-key "\C-crem" 'radar-edit-system-manual)
(global-set-key "\C-crey" 'radar-edit-cso-system-kb)
(global-set-key "\C-creK" 'radar-edit-frdcsa-sys-for-cso)
(global-set-key "\C-crek" 'radar-edit-frdcsa-sys-for-cso-autoload)
(global-set-key "\C-creF" 'radar-edit-frdcsa-sys-for-flp)
(global-set-key "\C-cref" 'radar-edit-frdcsa-sys-for-flp-autoload)
(global-set-key "\C-cren" 'radar-edit-latest-dated-daily-todo-file-chooser)
(global-set-key "\C-creN" 'radar-edit-todays-dated-daily-todo-file)
(global-set-key "\C-crepl" 'radar-edit-perl-module)
(global-set-key "\C-crec" 'radar-edit-debian-control-file)
(global-set-key "\C-cret" 'radar-edit-todo-file)
(global-set-key "\C-creT" 'radar-edit-dated-daily-todo-file)
;; (global-set-key "\C-crer" 'radar-edit-system-radar-info)
;; (global-set-key "\C-crex" 'pse-edit-pse-file)

(global-set-key "\C-crR" 'radar-insert-radar-directory)
(global-set-key "\C-crP" 'radar-insert-packager-directory)
(global-set-key "\C-crF" 'radar-insert-myfrdcsa-directory)

(global-set-key "\C-crla" 'radar-lookup-afs-project)
(global-set-key "\C-crld" 'radar-lookup-debian-package)
(global-set-key "\C-crlp" 'radar-lookup-perl-module)
(global-set-key "\C-crls" 'radar-lookup-perl-module-source)

(global-set-key "\C-crdu" 'radar-download-url)
(global-set-key "\C-crds" 'radar-download-system)
(global-set-key "\C-crdq" 'radar-download-queued-systems)

;; (global-unset-key "\C-cri")
(global-set-key "\C-crip" 'radar-install-cpan-module)

					; (global-set-key "\C-cry" 'radar-search-system-at-point)
(global-set-key "\C-crq" 'radar-queue-system-at-point)

(global-set-key "\C-crb" 'radar-w3m-browse-system)
(global-set-key "\C-crm" 'radar-mozilla-browse-system)

;; (global-unset-key "\C-cru")
;; (global-unset-key "\C-crk")
;; (global-unset-key "\C-crs")

;; FIXME: write a function which allows us to turn off C-cru, C-crk
;; and C-crs as needed

(global-set-key "\C-cru" 'ushell)
(global-set-key "\C-crk" 'ushell-kill)
(global-set-key "\C-crs" 'ushell-restart)

;;(global-set-key "\C-crf" 'radar-perl-find-file-at-point-debug)
;;(global-set-key "\C-c\C-r" 'radar-jump-to-directory)

;;(global-set-key "\C-c\C-j" 'jump-to-shops)

(defun radar-add-if-dir-exists (possible-dir dir-list)
 (if (file-directory-p possible-dir)
  (add-to-list dir-list possible-dir 1 (lambda (a b) nil))))

(setq radar-radar-dirs-possible
 (list
  frdcsa-home
  frdcsa-codebases
  frdcsa-internal-codebases
  frdcsa-external-codebases
  frdcsa-binary-packages
  frdcsa-minor-codebases
  frdcsa-work
  frdcsa-work-clients
  frdcsa-work-work
  frdcsa-partial-packages
  frdcsa-projects
  frdcsa-datasets
  (concat frdcsa-internal-codebases "/source-hatchery")
  (concat frdcsa-projects "/project-hatchery/projects")

  ;; the new collections and repositories
  frdcsa-collections
  frdcsa-repositories-external
  frdcsa-repositories-external-cvs
  frdcsa-repositories-external-git
  frdcsa-repositories-external-svn
  frdcsa-repositories-internal
  frdcsa-repositories-internal-cvs
  frdcsa-repositories-internal-git
  frdcsa-repositories-internal-svn
  frdcsa-capabilities
  frdcsa-github
  ))

(if (file-directory-p frdcsa-cats)
 (setq radar-radar-dirs-possible
  (append radar-radar-dirs-possible
   (mapcar (lambda (dir) (frdcsa-el-concat-dir (list frdcsa-cats dir)))
    (kmax-grep-list-regexp (directory-files frdcsa-cats) "^[^\.]")))))

;; (mapcar
;;  (lambda (dir2)
;;   (mapcar
;;    (lambda (dir1)
;;     (unshift (frdcsa-el-concat-dir (list frdcsa-cats dir2 dir1)) radar-radar-dirs-possible))
;;    (kmax-grep-list-regexp
;;     (directory-files (frdcsa-el-concat-dir (list frdcsa-cats dir2)))
;;     "^[^\.]")))
;;  (kmax-grep-list-regexp (directory-files frdcsa-cats) "^[^\.]"))

(setq radar-radar-work-dirs-possible
 (list
  frdcsa-work
  frdcsa-work-clients
  frdcsa-work-work
  )
 )
(if (file-exists-p frdcsa-work-clients)
 (mapcar
  (lambda (possible-dir) (radar-add-if-dir-exists (concat frdcsa-work-clients "/" possible-dir "/projects") 'radar-radar-work-dirs-possible))
  (directory-files frdcsa-work-clients)))

(setq radar-radar-dirs nil)
(mapcar (lambda (possible-dir) (radar-add-if-dir-exists possible-dir 'radar-radar-dirs)) radar-radar-dirs-possible)
(setq radar-radar-work-dirs nil)
(mapcar (lambda (possible-dir) (radar-add-if-dir-exists possible-dir 'radar-radar-work-dirs)) radar-radar-work-dirs-possible)

(setq radar-sandbox-dirs
 (list
  frdcsa-sandbox
  frdcsa-releases))

(setq radar-packager-dirs
 (list
  frdcsa-sandbox
  frdcsa-external-codebases))

(setq radar-myfrdcsa-dirs
 (list
  frdcsa-home))

(defvar radar-system-queue nil
 "a list of systems to be searched")

(defvar radar-jump-to-directory-additional-options nil
 "Enable corpus -s and other options to follow
 radar-jump-to-directory")

;; ANALYSIZE DOCUMENTS

(defun radar-edit-debian-control-file (&optional dirs)
 "Edit debian control file file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive)
 (let* ((lists (if dirs
		dirs
		radar-sandbox-dirs))
	(directory
	 (radar-select-directory lists))
	(file
	 (progn
	  (string-match ".*\/\\(.*\\)$" directory)
	  (match-string 1 directory))))
  (find-file (concat directory "/" file "/debian/control"))))

(defun radar-edit-perl-module (&optional dirs)
 "Edit FRDCSA.xml file for given system"
 ;; look at all the system perl modules
 (interactive)
 (let* ((module 
	 (completing-read "Which module?: " 
	  (split-string 
	   (shell-command-to-string "boss list_modules") "[\n]+" t)))
	(filename (concat "/usr/share/perl5/" module)))
  (if (length module)
   (if (file-exists-p filename)
    (find-file filename)))))

(defun radar-util-list-files-in-path ()
 ""
 ;; (interactive)
 (let* ((mylist nil))
  (mapcar
   (lambda (dir) 
    (if (file-directory-p dir) 
     (mapcar (lambda (file) (if (and (not (string= file ".")) (not (string= file ".."))) (push (list file (concat dir "/" file)) mylist))) (directory-files dir)))) exec-path)
  mylist))

(defun radar-edit-item-in-path (&optional dirs)
 "Edit FRDCSA.xml file for given system"
 (interactive)
 (let* ((files-in-path (radar-util-list-files-in-path))
	(script (completing-read "Which item in path?: " files-in-path))
	(filename (cadr (assoc script files-in-path))))
  (if (file-exists-p filename)
   (find-file filename))))

(defun radar-edit-system-frdcsa-file (&optional dirs)
 "Edit FRDCSA.xml file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive)
 (let* ((lists (if dirs
		dirs
		radar-radar-dirs))
	(directory
	 (radar-select-directory lists))
	(file (concat directory "/frdcsa/FRDCSA.xml")))
  ;; create the directory and populate with empty template and move to
  ;; position if not exists
  (find-file file)
  (if (= (length (kmax-buffer-contents)) 0)
   (insert
    (kmax-read-file "/var/lib/myfrdcsa/codebases/internal/boss/templates/FRDCSA.xml")))))

(defun radar-edit-todo-file (&optional dirs)
 "Edit to.do file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive)
 (let* ((lists (if dirs
		dirs
		radar-radar-dirs))
	(directory
	 (radar-select-directory lists)))
  (if directory
   (find-file (concat directory "/to.do"))
   (find-file "~/to.do"))))

(defvar radar-todo-directory
 (frdcsa-el-concat-dir (list homedir ".config" "frdcsa" "todo")))

(defun radar-edit-dated-daily-todo-file (&optional dirs)
 "Edit to.do file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive)
 (find-file (radar-select-directory (list radar-todo-directory))))

(defvar radar-todays-latest-dated-daily-todo-file
 (frdcsa-el-concat-dir (list radar-todo-directory "latest.do")))

(defun radar-get-todays-dated-daily-todo-file (&optional dirs)
 "Edit to.do file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive)
 (frdcsa-el-concat-dir (list radar-todo-directory (concat (kmax-current-date-yyyymmdd) ".do"))))

(defun radar-edit-todays-dated-daily-todo-file (&optional dirs)
 "Edit to.do file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive)
 (radar-update-latest-symlink)
 (find-file (radar-get-todays-dated-daily-todo-file)))


(defun radar-update-latest-symlink ()
 ""
 (if nil
  ;; (or
  ;;      (not (file-exists-p (radar-get-latest-symlink-dated-daily-todo-file)))
  ;;      (not
  ;; 	(string=
  ;; 	 (radar-get-latest-dated-daily-todo-file)
  ;; 	 (radar-get-latest-symlink-dated-daily-todo-file))))
  (if (yes-or-no-p "Update symlink to latest daily todo file?: ")
   (manager-approve-commands
    (list
     ;; (concat
     ;;  "cp -n " (shell-quote-argument (frdcsa-el-concat-dir (list radar-todo-directory "template.do")))
     ;;  " " (shell-quote-argument new-file))
     ;; (concat "rm "(shell-quote-argument radar-todays-latest-dated-daily-todo-file))
     (concat "cd " (shell-quote-argument (eshell/dirname radar-todays-latest-dated-daily-todo-file)) " && "
      "ln -s " (shell-quote-argument (eshell/basename (radar-get-latest-dated-daily-todo-file)))
      " latest.do"))))))

(defun resource-manager-iterate-resource-file (&optional arg)
 "Jump to the latest version of the log file"
 (interactive "P")
 (let* ((first (concat (kmax-timestamp) ".pl"))
	(new-file (frdcsa-el-concat-dir (list resource-manager-state-dir first))))
  (shell-command
   (concat
    "cp "
    (shell-quote-argument (file-chase-links resource-manager-state-file))
    " "
    (shell-quote-argument new-file)
    "; rm "
    (shell-quote-argument resource-manager-state-file)
    "; cd " resource-manager-state-dir " && "
    "ln -s " (shell-quote-argument first) " " (shell-quote-argument resource-manager-state-file)))
  (ffap (file-chase-links resource-manager-state-file))
  ;; FIXME: fix the today([YYYY-MM-DD]). statement
  ))

(defun radar-edit-latest-dated-daily-todo-file-chooser (&optional arg)
 (interactive "P")
 (if arg
  (radar-edit-latest-dated-daily-todo-file)
  (radar-edit-latest-symlink-dated-daily-todo-file)))

(defun radar-get-latest-dated-daily-todo-file ()
 "Edit the latest todo file"
 (interactive)
 (concat radar-todo-directory "/" 
  (car (reverse (directory-files radar-todo-directory nil "^[^\.][0-9\.do]+[^~]$")))))

(defun radar-edit-latest-dated-daily-todo-file ()
 "Edit the latest todo file"
 (interactive)
 (find-file (radar-get-latest-dated-daily-todo-file)))

(defun radar-get-latest-symlink-dated-daily-todo-file ()
 "Edit the latest todo file"
 (interactive)
 (concat radar-todo-directory "/latest.do"))

(defun radar-edit-latest-symlink-dated-daily-todo-file ()
 "Edit the latest todo file"
 (interactive)
 (radar-update-latest-symlink)
 (find-file (radar-get-latest-symlink-dated-daily-todo-file)))

(defun radar-edit-system-emacs-code (&optional dirs)
 "Edit FRDCSA.xml file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive)
 (let* ((lists (if dirs
		dirs
		radar-radar-dirs))
	(res
	 (radar-select-directory-special lists))
	(file
	 (concat (aref res 0) "/" (aref res 1) ".el")))
  (if (file-exists-p file)
   (find-file file)
   (find-file (radar-select-directory (list (aref res 0)))))))

;; (radar-select-directory (list "/var/lib/myfrdcsa/codebases/minor/execution-engine"))
;; (radar-select-directory-special radar-radar-dirs)

(defun radar-edit-system-prolog-code (&optional dirs)
 "Edit FRDCSA.xml file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive)
 (let* ((lists (if dirs
		dirs
		radar-radar-dirs))
	(res
	 (radar-select-directory-special lists))
	(file1
	 (concat (aref res 0) "/" (replace-regexp-in-string "-" "_" (aref res 1)) ".pl"))
	(file2
	 (concat (aref res 0) "/frdcsa/sys/flp/" (replace-regexp-in-string "-" "_" (aref res 1)) ".pl")))
  (if (file-exists-p file1)
   (find-file file1)
   (if (file-exists-p file2)
    (find-file file2)
    (let ((file3 (radar-select-directory (list (aref res 0)))))
     (if (file-exists-p file3)
      (ffap file3)
      (ffap (radar-select-directory (list (concat (aref res 0) "/frdcsa/sys/flp/"))))))))))

(defun radar-edit-system-emacs-code-all (&optional arg dirs)
 "Edit FRDCSA.xml file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive "P")
 (let* ((lists (if dirs
		dirs
		radar-radar-dirs))
	(res
	 (radar-select-directory-special lists))
	(files
	 (kmax-find-name-dired (aref res 0) "\.el$")))
  (ffap (ido-completing-read "Choose Emacs code to open: " files nil nil
	 (if arg
	  nil
	  ;; (frdcsa-el-concat-dir (list (car res) "frdcsa/emacs"))
	  (try-completion "" files))))))

(defun radar-edit-cso-system-kb (&optional dirs)
 "Edit FRDCSA.xml file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive)
 (let* ((lists (if dirs
		dirs
		radar-radar-dirs))
	(directory
	 (radar-select-directory lists)))
  (kmax-find-file-or-create-including-parent-directories
   (concat directory "/frdcsa/sys/cso/autoload/system-kb.pl"))))

(defun radar-edit-frdcsa-sys-for-flp (&optional dirs)
 "Edit FRDCSA.xml file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive)
 (radar-edit-frdcsa-sys-for-project nil "flp"))

(defun radar-edit-frdcsa-sys-for-flp-autoload (&optional arg dirs)
 "Edit FRDCSA.xml file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive "P")
 (if arg
  (radar-edit-frdcsa-sys-for-project nil "flp" (list "autoload"))
  (radar-edit-frdcsa-sys-for-project nil "flp" (list "autoload") t)))

(defun radar-edit-frdcsa-sys-for-cso (&optional dirs)
 "Edit FRDCSA.xml file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive)
 (radar-edit-frdcsa-sys-for-project nil "cso"))

(defun radar-edit-frdcsa-sys-for-cso-autoload (&optional arg dirs)
 "Edit FRDCSA.xml file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive "P")
 (if arg
  (radar-edit-frdcsa-sys-for-project nil "cso" (list "autoload"))
  (radar-edit-frdcsa-sys-for-project nil "cso" (list "autoload") t)))

(defvar radar-frdcsa-sys-dir-types (list "cso" "flp"))

(defun radar-edit-frdcsa-sys-for-project (&optional dirs type-arg extra-path search rest-of-file-path)
 "Edit FRDCSA.xml file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive)
 (let* ((lists (if dirs
		dirs
		radar-radar-dirs))
	(directory
	 (radar-select-directory lists))
	(type (or type-arg
	       (completing-read "FRDCSA Sys Dir Type: "
		radar-frdcsa-sys-dir-types)))
	(path (list directory "frdcsa" "sys" type)))
  (if extra-path
   (mapcar (lambda (path-component) (unshift path-component path)) extra-path))
  (if rest-of-file-path
   (progn
    (unshift rest-of-file-path path)
    (kmax-find-file-or-create-including-parent-directories
     (frdcsa-el-concat-dir path))))
  (if (and search (file-directory-p (frdcsa-el-concat-dir path)))
   (let* ((files (kmax-directory-files-no-hidden (frdcsa-el-concat-dir path)))
	  (file (completing-read (concat "Choose " type " autoload file: ") files 
		 nil nil
		 (try-completion "" files)))
	  (list (if (kmax-non-empty-string file)
		 (unshift file path)
		 path)))
    (kmax-find-file-or-create-including-parent-directories
     (frdcsa-el-concat-dir list)))
   (progn
    (kmax-mkdir-p (frdcsa-el-concat-dir path))
    (ffap (frdcsa-el-concat-dir path))))))

(defun radar-edit-system-manual (&optional dirs)
 "Edit FRDCSA.xml file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive)
 (let* ((lists (if dirs
		dirs
		radar-radar-dirs))
	(directory
	 (radar-select-directory lists)))
  (find-file (concat directory "/doc/manual/manual.xml"))))

(defun radar-search-capabilities ()
 "")

(defun radar-ner-region ()
 "Perform Named  Entity Recognition on  text in region.   Extracts all
important terms  such as package  names, author names,  author emails,
package  homepages,   package  mirrors,  package   versions,  packages
documentation,   manuals,  copyright/license   information,  operating
system, etc."
 (interactive "r"))

(defun radar-categorize-current-url ()
 "Insert current URL into some kind of database."
 (interactive)
 (kill-new (w3m-anchor)))

(defun radar-cache-url (url)
 "Cache a URL to a file"
 (interactive)
 (shell-command
  (concat "wget " url " -O /tmp/tmp.txt"))
 "/tmp/tmp.txt")

(defun radar-tag-url ()
 "Cache the current URL and launch a tagging environment"
 (interactive)
 ;; check to see that we are in w3m browser
 (if (string= "w3m" mode-name)
  (let*
   ((url (w3m-print-current-url))
    (cached-url (radar-cache-url url)))
   (start-process "awb" "awb" "awb"
    (concat "-input " cached-url)))
  (error "Error: Must be in a w3m buffer.")))

(defun radar-heuristics ()
 "Attempt various heuristic methods for locating packages"
 (interactive))

(defun radar-create-package-from-file ()
 "Take an file on the system and create a new package for it."
 (interactive))

(defun radar-region-to-package-field ()
 "Insert text in region into selected field of package database."
 (interactive))

(defun radar-extract-possible-packages-from-url ()
 "Come  up  with  a  list  of  lists of  possible  packages  that  are
referenced from the current URL."
 (interactive))

(defun radar-download-url-special ()
 "Download file under point as part of either current package or all packages."
 (interactive)
 (let* ((myurl
	 (if (string= major-mode "w3m-mode")
	  (or
	   (w3m-print-this-url)
	   (w3m-print-current-url))
	  (thing-at-point 'url))))
  (message myurl)
  (start-process "RADAR" "RADAR" "rxvt" "-geometry" "179x66+0+34" "-e" "radar" myurl)))

(defun radar-download-url ()
 "Download file under point as part of either current package or all packages."
 (interactive)
 (radar-run-in-shell
  (if (string= major-mode "w3m-mode")
   (or
    (w3m-print-this-url)
    (w3m-print-current-url))
   (thing-at-point 'url))))

;; generalize this to install, and it get everything, same with download, etc
(defun radar-install-cpan-module ()
 "Download file under point as part of either current package or all packages."
 (interactive)
 (let* 
  ((module (thing-at-point 'symbol)))
  (start-process "CPAN" "CPAN" "uxterm" "-e" "install-cpan-modules" module)))

(defun radar-run-in-shell (arg)
 ""
 (run-in-shell (concat "radar \"" arg "\"")))

(defun run-in-shell (command &optional name optional-message mode)
 ""
 (let (
       (mybuffer
	(progn
	 ;; (split-window-right)
	 (get-buffer-create 
	  (or name
	   (generate-new-buffer-name "*shell*")))))
       )
  (message command)
  (shell mybuffer)
  (if mode
   (kmax-funcall mode nil))
  ;; (switch-to-buffer mybuffer)
  (radar-shell-do-command command optional-message)
  ))

(defun radar-run-in-shell (arg)
 ""
 (let (
       (command
	(concat
	 "radar \"" arg "\""))
       (mybuffer
	(get-buffer-create (generate-new-buffer-name "*shell*")))
       )
  (shell mybuffer)
					; (switch-to-buffer mybuffer)
  (radar-shell-do-command command)
  ))

(defun radar-shell-do-command (command &optional optional-message delay)
 ""
 (progn
  (end-of-buffer)
  
  ;; FIXME: have to do this somehow without making it a command that
  ;; is then executed

  ;; (if optional-message
  ;;  (insert (concat optional-message "\n"))
  ;; )

  (insert command)
  (sit-for (or delay 2))
  (ignore-errors
   (eshell-send-input))
  (ignore-errors
   (comint-send-input))
  )
 )

(defun run-in-ansi-term (command &optional name optional-message)
 ""
 (ansi-term "/bin/bash")
 (term-send-string (get-buffer-process (current-buffer)) (concat command "\n"))
 (if (non-nil name)
  (rename-buffer name)))

(defun radar-ansi-term-do-command (command &optional optional-message)
 ""
 (progn
  (end-of-buffer)
  (insert command)
  (if (derived-mode-p 'eshell-mode)
   (ignore-errors
    (eshell-send-input))
   (if (derived-mode-p 'shell-mode)
    (ignore-errors
     (comint-send-input))))))

(defun radar-download-system ()
 "Download file under point as part of either current package or all packages."
 (interactive)
 (radar-run-in-shell (thing-at-point 'symbol)))

;; SEARCH METHODS

(defun radar-get-ls-alR ()
 "Take an ftp site via point or prompt and retrieve an ls-alR of it."
 (interactive))


;; Archive functions

(defun radar-upload-package ()
 "Upload package to default package archive"
 (interactive))


;; FTP functions

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MyFRDCSA		  ;;
;; Navigation Aids	  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun radar-jump-to-radar-directory ()
 "Jump to a radar directory"
 (interactive)
 (radar-jump-to-directory (append radar-radar-dirs radar-radar-work-dirs)))

(defun radar-jump-to-packager-directory (&optional arg)
 "Jump to a packager directory"
 (interactive "P")
 (radar-jump-to-directory radar-packager-dirs)
 (if arg
  (let* ((dir (kmax-get-buffer-file-name-all-modes))
	 (new-dir
	  (frdcsa-el-concat-dir
	   (list dir
	    (eshell/basename (kmax-strip-trailing-forward-slashes dir))))))
   (if (or (string= "EShell" mode-name) (string= "Shell" mode-name))
    (radar-shell-do-command (concat "pushd " new-dir) nil 0.5)
    (dired new-dir)))))

(defun radar-jump-to-myfrdcsa-directory ()
 "Jump to a packager directory"
 (interactive)
 (radar-jump-to-directory radar-myfrdcsa-dirs))

(defun radar-insert-radar-directory ()
 ""
 (interactive)
 (insert (radar-select-directory radar-radar-dirs)))

(defun radar-insert-packager-directory ()
 ""
 (interactive)
 (insert (radar-select-directory radar-packager-dirs)))

(defun radar-insert-myfrdcsa-directory ()
 ""
 (interactive)
 (insert (radar-select-directory radar-myfrdcsa-dirs)))

(defun radar-select-directory (&optional dirs initial-input)
 "program to select a directory"
 (interactive "S")
 (let* ((lists (if dirs
		dirs
		radar-radar-dirs))
	(name-dir
	 (apply 'append
	  (mapcar
	   (lambda (dir)
	    (mapcar (lambda (name)
		     (list name dir))
	     (directory-files dir nil "[^\.]")))
	   lists)))
	(selected-name
	 ;; (iswitchb-read-buffer "Entity: "))
	 (completing-read "Entity: " name-dir nil nil initial-input))
	(directory
	 (if (> (length selected-name) 0)
	  (concat
	   (radar-get-dir selected-name name-dir)
	   "/"
	   selected-name)
	  nil)))
  directory))

(defun radar-get-dir (selected-name name-dir)
 (interactive)
 (cadr (assoc selected-name name-dir))
 ;; (see (prin1-to-string (list "selected-name" selected-name "name-dir" name-dir)))
 )

(defun radar-select-directory-special (&optional dirs)
 "program to select a directory"
 (interactive "S")
 (let* ((lists (if dirs
		dirs
		radar-radar-dirs))
	(name-dir
	 (apply 'append
	  (mapcar
	   (lambda (dir)
	    (mapcar (lambda (name)
		     (list name dir))
	     (directory-files dir nil "[^\.]")))
	   lists)))
	(selected-name
	 ;; (iswitchb-read-buffer "Entity: "))
	 (completing-read "Entity: " name-dir))
	(directory
	 (concat
	  (cadr (assoc selected-name name-dir))
	  "/"
	  selected-name)))
  (vector directory selected-name)))

(defun radar-jump-to-directory (&optional dirs)
 ""
 (interactive "S")
 (if radar-jump-to-directory-additional-options
  (radar-jump-to-directory-with-corpus-dash-s dirs)
  (radar-jump-to-directory-original dirs)))

(defun radar-select-directory-dirs (dirs)
 (interactive)
 (radar-select-directory
  (if dirs
   dirs
   radar-radar-dirs)))

(defun radar-jump-to-directory-original (&optional dirs)
 "Jump to a myfrdcsa entity with completing read"
 ;; create a list of <name,dir> and then select via name and jump to dir
 ;; if the current buffer is a shell or eshell, cd, otherwise dired
 (interactive "S")
 (let* ((directory
	 (radar-select-directory-dirs dirs)))
  (if (or (string= "EShell" mode-name) (string= "Shell" mode-name))
   (radar-shell-do-command (concat "pushd " directory) nil 0.5)
   (dired directory))))

(defun radar-jump-to-directory-with-corpus-dash-s (&optional dirs)
 "Jump to a myfrdcsa entity with completing read"
 ;; create a list of <name,dir> and then select via name and jump to dir
 ;; if the current buffer is a shell or eshell, cd, otherwise dired
 (interactive "S")
 (let* ((lists (if dirs
		dirs
		radar-radar-dirs))
	(res 
	 (radar-select-directory-special lists))
	(directory
	 (aref res 0)))
  (if (or (string= "EShell" mode-name) (string= "Shell" mode-name))
   (radar-shell-do-command (concat "pushd " directory " ; " "corpus -d 1000 -s " (aref res 1) " -k") nil 0.5)
   (dired directory))))

(defun radar-jump-to-directory-2 (&optional dirs)
 "Jump to a myfrdcsa entity with completing read"
 ;; create a list of <name,dir> and then select via name and jump to dir
 ;; if the current buffer is a shell or eshell, cd, otherwise dired
 (interactive "S")
 (let* ((lists (if dirs
		dirs
		radar-radar-dirs))
	(name-dir
	 (apply 'append
	  (mapcar
	   (lambda (dir)
	    (mapcar (lambda (name)
		     (list name dir))
	     (directory-files dir nil "[^\.]")))
	   lists)))
	(selected-name
	 ;; (iswitchb-read-buffer "Entity: "))
	 (completing-read "Entity: " name-dir))
	(directory
	 (concat
	  (cadr (assoc selected-name name-dir))
	  "/"
	  selected-name)))
  (if (or (string= "EShell" mode-name) (string= "Shell" mode-name))
   (radar-shell-do-command (concat "pushd " directory))
   (dired directory))))

(defun radar-next ()
 "Switch to the next package in the wanted section."
 (interactive)
 (kill-new (w3m-anchor)))

(defun radar-prev ()
 "Switch to the previous package in the wanted section."
 (interactive)
 (kill-new (w3m-anchor)))

(defun create-phrase-dictionary-entry ()
 "")

(defun push-phrase-dictionary-key ()
 "")

(defun radar-jump-to-radar-directory ()
 "Jump to a radar directory"
 (interactive)
 (radar-jump-to-directory radar-radar-dirs))



;; CLASSIFICATION TOOLS

(setq filenumber 0)
(defun radar-classify-url ()
 "Send the current URL information to a buffer"
 (interactive)
 (if
  (string= (buffer-name) "*w3m*")
  (progn
   (w3m-copy-buffer)
   (w3m-view-source)
   (write-file
    (concat
     frdcsa-internal-codebases "/radar/test/"
     (int-to-string filenumber)
     ".html"))
   (setq filenumber (+ filenumber 1))
   (kill-buffer (current-buffer))
   (rename-uniquely))))

(defun radar-lookup-debian-package ()
 "Shows information for package at point"
 (interactive)
 (let*
  ((mysym (thing-at-point 'symbol))
   (mymatch (progn
	     (string-match "\\([A-Za-z0-9\.\+\-]+\\)" mysym)
	     (match-string 1 mysym))))
  (or
   (apt-utils-show-package mymatch)
   (message mymatch))))

(defun radar-lookup-afs-project ()
 "Lookup a CMU project"
 (interactive)
 (browse-url
  (concat "http://www.google.com/search?hl=en&ie=UTF-8&oe=UTF-8&q=site%3Acmu.edu+project+" 
   ;; (read-from-minibuffer "Project Name: ")
   (thing-at-point 'word)
   "&btnG=Google+Search")))

(defun radar-new-class ()
 "Prompts the user for class names and writes a template")

;; #############################################################################
;; #
;; # Gourmet::Conf
;; # Manage configuration for RADAR
;; # Copyright(c) 2004, Andrew John Dougherty (ajd@frdcsa.org)
;; # Distribute under the GPL
;; #
;; ############################################################################

;; also apply that prettyprinter, perltidy, in combination with our
;; own algorithms to ensure that things are properly printed.

;; (fset 'fix-perl-names
;;  [?\C-s ?s ?u ?b ?  ?\C-  ?\C-  ?\C-  ?\C-s ?  ?\C-b ?\C-x ?n ?n ?\C-a ?\M-c ?\M-c ?\M-c ?\M-c ?\M-c ?\M-c ?\M-c ?\M-c ?\M-c ?\M-c ?\M-c ?\C-a ?\M-% ?_ ?\C-m ?\C-m ?! ?\C-a ?\C-x ?n ?w ?\C-a])

(defun radar-perl-find-file-at-point-debug ()
 "FFAP but also jump to the line specified behind it"
 (interactive)
 (set-mark-command)
 (isearch-forward " line ")
 (set-mark-command)
 (forward-word)
 (pop-global-mark)
 (ffap))


(defun radar-lookup-perl-module ()
 "Lookup package documentation at CPAN"
 (interactive)
 (browse-url
  (concat "http://search.cpan.org/search?mode=module&query="
   (or
    (thing-at-point 'symbol)
    (read-from-minibuffer "Module: ")))))

(setq thing-at-point-perl-module-regexp
 "\\<\\(https?://\\|ftp://\\|gopher://\\|telnet://\\|wais://\\|file:/\\|s?news:\\|mailto:\\)[^]	\n \"'()<>[^`{}]*[^]	\n \"'()<>[^`{}.,;]+")

(defun radar-perl-man-module ()
 "Lookup package documentation at CPAN"
 (interactive)
 (browse-url
  (man
   (or
    (thing-at-point 'symbol)
    (read-from-minibuffer "Module: ")))))

(defun radar-lookup-perl-module-source ()
 "Given a module name, return the file that contains it."
 (interactive)
 (let*
  ((module (substring-no-properties (thing-at-point 'filename)))
   (matched
    (progn
     (while
      (string-match "\\(::\\)" module)
      (setq module (replace-match "/" nil t module)))
     (string-match "\\([A-Za-z0-9_\/]+\\)" module)
     (concat (match-string 0 module) ".pm")))
   (filename (radar-locate-module matched)))
  (if (and 
       (not (null filename))
       (file-exists-p filename))
   (progn
    (find-file filename)
    (message filename))
   (message (concat "Module does not exist: " filename)))))

;; (setq debug-on-error t)

(defun radar-locate-module (module)
 ""
 (let*
  ((myroots
    (split-string
     (shell-command-to-string
      "perl -e 'foreach (@INC) { print \"$_\\n\" };'") "\n")))
  (dolist (tmp myroots)
   (let* ((thisroot (concat tmp "/")))
    (message thisroot)
    (if (file-exists-p (concat thisroot module))
     (return (concat thisroot module)))))))

;; (defun radar-locate-module (module)
;;  ""
;;  (let*
;;   ((myroots (list
;; 	     "/usr/lib/perl/5.14.2/"
;; 	     "/usr/local/share/perl/5.14.2/"
;; 	     "/usr/lib/perl5/"
;; 	     "/usr/share/perl5/"
;; 	     "/usr/share/perl/5.14.2/")))
;;   (dolist (thisroot myroots)
;;    (progn
;;     (message thisroot)
;;     (if (file-exists-p (concat thisroot module))
;;      (return (concat thisroot module)))))))

(defun radar-apt-utils ()
 "Do apt-utils-show-package on thing-at-point"
 (interactive)
 (or
  (apt-utils-show-package-1 t (thing-at-point `symbol))))

;; (defun radar-apt-utils ()
;;  ""
;;  (interactive)
;;  (apt-utils-show-package (thing-at-point `symbol)))

(defun radar-myfrdcsa-utils ()
 ""
 (interactive)
 (or
  (thing-at-point `symbol)
  nil))

(defun radar-search-system-at-point ()
 "Search for the system indicated at point, if it is found bring up an
overview"
 (interactive)
 (let* ((system (thing-at-point 'symbol))
	(command
	 (concat
	  "cd /var/lib/myfrdcsa/codebases/internal/sorcerer && "
	  "rxvt -geometry 179x66+0+34 -e sorcerer -w -s -n " system " &")))
  (message command)
  (shell-command command)))


(defun radar-queue-system-at-point ()
 "Search for the system indicated at point, if it is found bring up an
overview"
 (interactive)
 (let* ((system (thing-at-point 'symbol)))
  (push system radar-system-queue)
  (message (concat "queued " system))))

(defun radar-download-queued-systems ()
 "Search for the system indicated at point, if it is found bring up an
overview"
 (interactive)
 (let ((arg (join " " radar-system-queue)))
  (setq radar-system-queue nil)
  (radar-run-in-shell arg)))

(defun radar-search-system-at-point-proto ()
 "Search for the system indicated at point, if it is found bring up an
overview"
 (interactive)
 (let* ((system (thing-at-point 'symbol)))
  (radar-search-systems system)))

(defun radar-search-systems (&optional s)
 "program to select a directory"
 (interactive)
 (let* ((search (if s
		 s
		 (read-from-minibuffer "System name?")))
	(lists radar-packager-dirs)
	(name-dir
	 (apply 'append
	  (mapcar
	   (lambda (dir)
	    (mapcar (lambda (name)
		     (list name dir))
	     (directory-files dir nil "[^\.]")))
	   lists))))))

(defun radar-get-source ()
 "Get the current source"
 (interactive)
 (setq radar-source
  (completing-read "Source: "
   '(("sourceforge.net" . 1)
     ("sourceforge.net.2" . 1)
     ("freshmeat.net" . 1)
     ("search.cpan.net" . 1)))))

(defun radar-get-url-for-system-at-point (&optional reget)
 (let*
  ((system
    (thing-at-point 'symbol))
   (source (if reget
	    (radar-get-source)
	    (if (boundp 'radar-source)
	     radar-source
	     (radar-get-source))))
   (url
    (cond
     ((string= source "sourceforge.net") (concat "http://" system "." source))
     ((string= source "sourceforge.net.2") (concat "http://sf.net/projects/" system))
     ((string= source "freshmeat.net") (concat "http://" source "/projects/" system))
     ((string= source "search.cpan.net") nil))))
  url))

(defun radar-w3m-browse-system (arg)
 "view the system's url"
 (interactive "P")
 ;; first need to figure out the url for the system
 (w3m-browse-url (radar-get-url-for-system-at-point arg)))

(defun radar-mozilla-browse-system (arg)
 "view the system's url"
 (interactive "P")
 ;; first need to figure out the url for the system
 ;; (browse-url-mozilla (radar-get-url-for-system-at-point arg))
 (shell-command (concat "mozilla -remote 'openURL(" (radar-get-url-for-system-at-point arg) ",new-tab)'"))
 )

(defun radar-add-critic-connection ()
 "view the system's url"
 (interactive)
 ;; first need to figure out the url for the system
 (let*
  ((system
    (thing-at-point 'symbol))
   ;; select a current system
   ()
   ;; select a relationship
   )
  (if url
   ())))

(defun radar-edit-systems-profile ()
 "Add a system to the system (simple script)"
 (interactive)
 (let*
  ((directory (radar-select-directory radar-radar-dirs)))
  (find-file (concat directory "/.radar-profile"))))

					; https://guage.dev.java.net/
;; if elog is added, record the storage, which may include indexing the file

(defun radar-dired-system-scripts-dir (&optional dirs)
 "Edit FRDCSA.xml file for given system"
 ;; prompt for the creation of the file if it does not already exist
 (interactive)
 (let* ((lists (if dirs
		dirs
		radar-radar-dirs))
	(res
	 (radar-select-directory-special lists))
	(file
	 (concat (aref res 0) "/scripts")))
  (if (file-exists-p file)
   (dired file))))

(defun radar-get-project-directory (&optional dirs project)
 "program to select a directory"
 (interactive "S")
 (let* ((lists (if dirs
		dirs
		radar-radar-dirs))
	(name-dir
	 (apply 'append
	  (mapcar
	   (lambda (dir)
	    (mapcar (lambda (name)
		     (list name dir))
	     (directory-files dir nil "[^\.]")))
	   lists)))
  	(assocation
	 (assoc project name-dir))
  	(directory
  	 (if (> (length (cdr assocation)) 0)
  	  (concat
	   (cadr assocation)
  	   "/"
	   (car assocation))
  	  nil))
	)
  directory))

(defun radar-open-function-documentation ()
 ""
 (interactive)
 ;; (ffap "/var/lib/myfrdcsa/codebases/internal/radar/doc/commands.notes")
 (ffap "/var/lib/myfrdcsa/codebases/internal/radar/doc/function-documentation.txt"))

(provide 'radar)
