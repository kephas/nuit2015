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


(defmethod encode-json ((object (eql :false)) &optional stream)
  (princ "false" stream))


(defun serve-json (json &key (status 200))
  `(,status
    (:content-type "application/json; charset=utf-8" :access-control-allow-origin "*")
    (,json)))

(defun serve-json* (object)
  (serve-json (encode-json-to-string object)))

(defmacro with-json-error (&body body)
  `(handler-case
       (progn ,@body)
     (not-shell () (serve-json "{}" :status 404))
     (error () (serve-json "{}" :status 501))))

(defroute "/alertes" ()
  (with-json-error
    (if-let (alertes (mapcar #'second (shell-list *root-shell* "alertes")))
      (serve-json* alertes)
      (serve-json "[]"))))

(defun body-param (name)
  (cdr (assoc name (lack.request:request-body-parameters *request*) :test #'string=)))

(defvar *times* '(("med" 30 :minute)("evac" 4 :hour)("assist" 1 :day)("zombie" 10 :minute)))

(defroute ("/alertes" :method :POST) ()
  (with-json-error
    (setf (shell-object *root-shell* "alertes" (make-oid))
	  (make-instance 'alerte
			 :titre (body-param "titre")
			 :type (body-param "type")
			 :emis (local-time:format-rfc3339-timestring nil (local-time:now))
			 :inter (local-time:format-rfc3339-timestring
				 nil (apply #'local-time:timestamp+ (local-time:now)
					    (cdr (assoc (body-param "type") *times* :test #'string=))))
			 :lieu (body-param "lieu")
			 :pers (body-param "personnes")))
    (serve-json (encode-json-plist-to-string (list :sucess t)))))
