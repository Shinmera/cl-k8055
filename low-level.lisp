#|
 This file is a part of cl-k8055d
 (c) 2016 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:cl-k8055d-cffi)

(defvar *here* #.(or *compile-file-pathname* *load-pathname* *default-pathname-defaults*))
(defvar *static* (make-pathname :name NIL :type NIL :defaults (merge-pathnames "static/" *here*)))
(pushnew *static* cffi:*foreign-library-directories*)

(define-foreign-library libk8055d
  (:windows (:or "k8055d.dll"
                 #+X86 "win32-libk8055d.dll"
                 #+X86-64 "win64-libk8055d.dll"))
  (t (:default "k8055d")))

(use-foreign-library libk8055d)

(defmacro define-cfun (name return &body args)
  (flet ((convert-name (name)
           (format NIL "~{~:(~a~)~}" (cl-ppcre:split "-" (string name)))))
    `(defcfun (,(convert-name name) ,name
               :convention :stdcall
               :library libk8055d) ,return
       ,@args)))

(define-cfun open-device :int
  (card-address :int))

(define-cfun close-device :void)

(define-cfun search-devices :int)

(define-cfun set-current-device :int
  (lng-card-address :int))

(define-cfun version :int)

(define-cfun read-analog-channel :int
  (channel :int))

(define-cfun read-all-analog :void
  (data1 :pointer)
  (data2 :pointer))

(define-cfun output-analog-channel :void
  (channel :int)
  (data :int))

(define-cfun output-all-analog :void
  (data1 :int)
  (data2 :int))

(define-cfun clear-analog-channel :void
  (channel :int))

(define-cfun clear-all-analog :void)

(define-cfun set-analog-channel :void
  (channel :int))

(define-cfun set-all-analog :void)

(define-cfun write-all-digital :void
  (data :int))

(define-cfun clear-digital-channel :void
  (channel :int))

(define-cfun clear-all-digital :void)

(define-cfun set-digital-channel :void
  (channel :int))

(define-cfun set-all-digital :void)

(define-cfun read-digital-channel :bool
  (channel :int))

(define-cfun read-all-digital :int)

(define-cfun reset-counter :void
  (counter-nr :int))

(define-cfun read-counter :int
  (counter-nr :int))

(define-cfun set-counter-debounce-time :void
  (counter-nr :int)
  (debounce-time :int))

(define-cfun read-back-digital-out :int)

(define-cfun read-back-analog-out :void
  (buffer :pointer))
