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

(ele:defpclass alerte ()
  ((titre :accessor alt-titre :initarg :titre)
   (type :accessor alt-type :initarg :type)
   (date-emission :accessor alt-emission :initarg :emis)
   (lieu :accessor alt-lieu :initarg :lieu)
   (personnes :accessor alt-pers :initarg :pers)))
