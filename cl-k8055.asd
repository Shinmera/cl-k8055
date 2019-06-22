#|
 This file is a part of cl-k8055
 (c) 2016 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(asdf:defsystem cl-k8055
  :version "1.0.0"
  :license "zlib"
  :author "Nicolas Hafner <shinmera@tymoon.eu>"
  :maintainer "Nicolas Hafner <shinmera@tymoon.eu>"
  :description "Bindings to the k8055 DAQ hobby board."
  :homepage "https://Shinmera.github.io/cl-k8055/"
  :bug-tracker "https://github.com/Shinmera/cl-k8055/issues"
  :source-control (:git "https://github.com/Shinmera/cl-k8055.git")
  :serial T
  :components ((:file "package")
               (:file "low-level")
               (:file "wrapper")
               (:file "documentation"))
  :depends-on (:cffi
               :cl-ppcre
               :trivial-features
               :documentation-utils))
