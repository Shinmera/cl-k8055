#|
 This file is a part of cl-k8055d
 (c) 2016 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:cl-user)
(defpackage #:cl-k8055d-cffi
  (:nicknames #:org.shirakumo.k8055d.cffi)
  (:use #:cl #:cffi)
  ;; low-level.lisp
  (:export
   #:*static*
   #:libk8055d))
