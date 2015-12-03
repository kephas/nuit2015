 #| Nuit de l'info 2015
    Copyright (C) 2015 WeGROKLC <wegroklc@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>. |#

(in-package :nothos.net/2015.12.nuit)


(defclass <nuit> (caveman2:<app>)())
(defparameter *app* (make-instance '<nuit>))


(defun get-parsed (name parsed)
  (cdr (assoc name parsed :test #'string=)))


(defmacro {setf-angular} (var value &optional (string? t))
  "Create an element that will set a variable in AngularJS"
  `(htm
    (:span :style "display:none"
	   :ng-init ,(if string?
			 `(format nil "~a=\"~a\"" ,var ,value)
			 `(format nil "~a=~a" ,var ,value)))))

(defvar *root-shell*)

(defun open-storage ()
  (ele:open-store (config* :ele-store))
  (let ((shell (ele:get-from-root "root-shell")))
    (unless shell
      (setf shell (ele:make-btree))
      (ele:add-to-root "root-shell" shell))
    (setf *root-shell* shell)))

(defun clackup (port &optional config-file)
  (read-configuration! config-file)
  (open-storage)
  (shell-ensure-hierarchy! *root-shell* '(("alertes")))
  (setf drakma:*drakma-default-external-format* :UTF-8)
  (clack:clackup
   (lack.builder:builder
    (:static
     :path "/static/"
     :root (merge-pathnames #p"static/" (asdf:system-source-directory "nuit2015")))
    *app*) :port port :debug (config* :debug) :server (config* :server)))
