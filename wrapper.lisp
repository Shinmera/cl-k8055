#|
 This file is a part of cl-k8055
 (c) 2016 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.k8055)

(defvar *default-max-attempts* 50)

(defun connect ()
  (cl-k8055-cffi:open-device 0))

(defun disconnect ()
  (cl-k8055-cffi:close-device))

(defun call-with-positive-return (function &optional max-attempts)
  (loop repeat (or max-attempts *default-max-attempts*)
        for result = (funcall function)
        do (when (<= 0 result)
             (return result))
        finally (error "Failed to perform device operation after ~d attempt~:p" max-attempts)))

(defmacro with-positive-return ((&optional max-attempts) &body body)
  `(call-with-positive-return (lambda () ,@body) ,max-attempts))

(defun digital (channel)
  (check-type channel (integer 1 5))
  (= 1 (with-positive-return ()
         (cl-k8055-cffi:read-digital-channel channel))))

(defun (setf digital) (value channel)
  (check-type channel (integer 1 8))
  (with-positive-return ()
    (if value
        (cl-k8055-cffi:set-digital-channel channel)
        (cl-k8055-cffi:clear-digital-channel channel))))

(defun analog (channel)
  (check-type channel (integer 1 2))
  (with-positive-return ()
    (cl-k8055-cffi:read-analog-channel channel)))

(defun (setf analog) (value channel)
  (check-type channel (integer 1 2))
  (check-type value (integer 0 255))
  (with-positive-return ()
    (cl-k8055-cffi:output-analog-channel channel value)))

(defun analogf (channel)
  (/ (analog channel) 255.0))

(defun (setf analogf) (value channel)
  (check-type value (float 0.0 1.0))
  (setf (analog channel) (round (* 255 value))))

(defun counter (counter)
  (with-positive-return ()
    (cl-k8055-cffi:read-counter counter)))

(defun reset-counter (counter)
  (with-positive-return ()
    (cl-k8055-cffi:reset-counter counter)))

(defun (setf counter-debounce-time) (value counter)
  (with-positive-retunr ()
    (cl-k8055-cffi:set-counter-debounce-time counter value)))
