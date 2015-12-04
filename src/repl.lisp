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


#| Text UI |#

(defgeneric tui-print (object))

(defun tui-list (objects)
  (dolist (object objects)
    (tui-print object)))

(defun tui-search (query objects)
  (tui-list (do-search query objects)))


(defun tui-shell-list (shell &optional path)
  (let@ rec ((object shell)
	     (path path))
    (format *query-io* "~:[~;~1:*~{/~a~}~]" path)
    (if (shell? object)
	(progn
	  (format *query-io* "/~%")
	  (%map-shell object (lambda (k v)
			       (rec v (append path (list k))))))
	(format *query-io* " = ~s~%" object))))

