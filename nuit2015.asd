(defpackage :nothos.net/2015.12.nuit-system
  (:use :common-lisp :asdf))

(in-package :nothos.net/2015.12.nuit-system)

(defsystem "nuit2015"
  :description "Nuit de l'info 2015"
  :version "0.0.1"
  :author "WeGROKLC <wegroklc@gmail.com>"
  :licence "AGPL"
  :depends-on ("scheme" "alexandria" "cl-fad" "cl-ppcre" "split-sequence" "metabang-bind"
			"do-urlencode" "cl-who" "drakma" "cl-emb" "uuid"
			"hu.dwim.stefil" "clack" "caveman2" "elephant" "cl-json")
  :components ((:module	"src"
	        :components ((:file "package")
			     (:file "config")
			     (:file "misc")
			     (:module "model"
			      :components ((:file "model")
					   (:file "shell")))
			     (:module "web"
			      :components ((:file "bootstrap")
					   (:file "web")
					   (:file "json")))
			     (:file "test")
			     (:file "repl"))))
  :serial t)
