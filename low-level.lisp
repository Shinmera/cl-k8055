(in-package #:org.shirakumo.k8055.cffi)

(defvar *here* #.(or *compile-file-pathname* *load-pathname* *default-pathname-defaults*))
(defvar *static* (make-pathname :name NIL :type NIL :defaults (merge-pathnames "static/" *here*)))
(pushnew *static* cffi:*foreign-library-directories*)

(define-foreign-library libk8055
  (:linux (:or "k8055.so"
               #+X86 "lin32-libk8055.so"
               #+X86-64 "lin64-libk8055.so"
               #+ARM "linarm-libk8055.so"))
  (t (:default "k8055d")))

(use-foreign-library libk8055)

(defmacro define-cfun (name return &body args)
  (flet ((convert-name (name)
           (format NIL "~{~:(~a~)~}" (cl-ppcre:split "-" (string name)))))
    `(defcfun (,(convert-name name) ,name
               :convention :stdcall
               :library libk8055) ,return
       ,@args)))

(define-cfun open-device :int
  (card-address :long))

(define-cfun close-device :void)

(define-cfun search-devices :long)

(define-cfun set-current-device :long
  (lng-card-address :long))

(define-cfun version :pointer)

(define-cfun read-analog-channel :long
  (channel :long))

(define-cfun read-all-analog :int
  (data1 :pointer)
  (data2 :pointer))

(define-cfun output-analog-channel :int
  (channel :long)
  (data :long))

(define-cfun output-all-analog :int
  (data1 :long)
  (data2 :long))

(define-cfun clear-analog-channel :int
  (channel :long))

(define-cfun clear-all-analog :int)

(define-cfun set-analog-channel :int
  (channel :long))

(define-cfun set-all-analog :int)

(define-cfun write-all-digital :int
  (data :long))

(define-cfun clear-digital-channel :int
  (channel :long))

(define-cfun clear-all-digital :int)

(define-cfun set-digital-channel :int
  (channel :long))

(define-cfun set-all-digital :int)

(define-cfun read-digital-channel :int
  (channel :long))

(define-cfun read-all-digital :int)

(define-cfun reset-counter :int
  (counter-nr :long))

(define-cfun read-counter :int
  (counter-nr :long))

(define-cfun set-counter-debounce-time :int
  (counter-nr :long)
  (debounce-time :long))

(define-cfun read-all-values :int
  (data1 :pointer)
  (data2 :pointer)
  (data3 :pointer)
  (data4 :pointer)
  (data5 :pointer))

(define-cfun set-all-values :int
  (digital :int)
  (analog1 :int)
  (analog2 :int))
