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
   #:libk8055d
   #:open-device
   #:close-device
   #:search-devices
   #:set-current-device
   #:version
   #:read-analog-channel
   #:read-all-analog
   #:output-analog-channel
   #:output-all-analog
   #:clear-analog-channel
   #:clear-all-analog
   #:set-analog-channel
   #:set-all-analog
   #:write-all-digital
   #:clear-digital-channel
   #:clear-all-digital
   #:set-digital-channel
   #:set-all-digital
   #:read-digitial-channel
   #:read-all-digital
   #:reset-counter
   #:read-counter
   #:set-counter-debounce-time
   #:read-back-digital-out
   #:read-back-analog-out))
