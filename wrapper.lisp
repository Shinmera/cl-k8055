#|
 This file is a part of cl-k8055
 (c) 2016 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.k8055)

(defvar *default-max-attempts* 50)
(defvar *voltage-map* '(:in ((T 10.0))
                        :out ((T 4.6))))

(defun connect ()
  (if (<= 0 (cl-k8055-cffi:open-device 0))
      T
      (error "Failed to connect to the K8055 board.")))

(defun disconnect ()
  (cl-k8055-cffi:close-device)
  T)

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
        (cl-k8055-cffi:clear-digital-channel channel)))
  value)

(defun analog (channel)
  (check-type channel (integer 1 2))
  (with-positive-return ()
    (cl-k8055-cffi:read-analog-channel channel))
  (with-positive-return ()
    (cl-k8055-cffi:read-analog-channel channel)))

(defun (setf analog) (value channel)
  (check-type channel (integer 1 2))
  (check-type value integer)
  (with-positive-return ()
    (cl-k8055-cffi:output-analog-channel channel (min 255 (max 0 value))))
  value)

(defun analogf (channel)
  (/ (analog channel) 255.0))

(defun (setf analogf) (value channel)
  (check-type value float)
  (setf (analog channel) (round (* 255 value)))
  value)

(defun analogv (channel)
  (* (analogf channel) (voltage :in channel)))

(defun (setf analogv) (value channel)
  (setf (analogf channel) (/ value (voltage :out channel)))
  value)

(defun voltage (direction channel)
  (ecase direction
    (:in (or (cdr (assoc channel (getf *voltage-map* :in)))
             (cdr (assoc T (getf *voltage-map* :in)))))
    (:out (or (cdr (assoc channel (getf *voltage-map* :out)))
              (cdr (assoc T (getf *voltage-map* :out)))))))

(defun (setf voltage) (value direction channel)
  (ecase direction (:in) (:out))
  (setf (getf *voltage-map* direction)
        (cons (list channel value) (remove channel (getf *voltage-map* direction) :key #'car)))
  value)

(defun counter (counter)
  (with-positive-return ()
    (cl-k8055-cffi:read-counter counter)))

(defun reset-counter (counter)
  (with-positive-return ()
    (cl-k8055-cffi:reset-counter counter))
  T)

(defun (setf counter-debounce-time) (value counter)
  (with-positive-return ()
    (cl-k8055-cffi:set-counter-debounce-time counter value))
  T)
