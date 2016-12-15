#|
 This file is a part of cl-k8055d
 (c) 2016 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:cl-user)
(asdf:defsystem cl-k8055d
  :version "1.0.0"
  :license "Artistic"
  :author "Nicolas Hafner <shinmera@tymoon.eu>"
  :maintainer "Nicolas Hafner <shinmera@tymoon.eu>"
  :description "Bindings to k8055d"
  :homepage "https://github.com/Shirakumo/cl-k8055d"
  :serial T
  :components ((:file "package")
               (:file "low-level"))
  :depends-on (:cffi
               :cl-ppcre
               :trivial-features
               :trivial-garbage
               :documentation-utils))
