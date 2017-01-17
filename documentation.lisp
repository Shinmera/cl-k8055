#|
 This file is a part of cl-k8055
 (c) 2016 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

;; low-level.lisp
(in-package #:org.shirakumo.k8055.cffi)
(docs:define-docs
  (variable *here*
    "Pathname pointing to the low-level.lisp file.")

  (variable *static*
    "Pathname pointing to the static/ directory in the source tree.

See *HERE*")

  (function define-cfun
    "Convenience wrapper for our C function definitions.

Sets the proper library, converts the name automatically,
and sets the convention to :stdcall as required by the lib.")

  (function open-device
    "Open the devices at the specified addresses. Card-addresses should be a two-bit mask.")

  (function close-device
    "Close the opened device.")

  (function search-devices
    "Return a two bit mask of the available devices on the system.")

  (function set-current-device
    "Change the current device address.")

  (function version
    "Return the library version.")

  (function read-analog-channel
    "Read the value from an analog channel.")

  (function read-all-analog
    "Read both analog channels at once.")

  (function output-analog-channel
    "Set the output value of an analog channel.")

  (function output-all-analog
    "Set the output values of both analog channels.")

  (function clear-analog-channel
    "Set the output value of an analog channel to 0.")

  (function clear-all-analog
    "Set the output value of both analog channels to 0.")

  (function set-analog-channel
    "Set the output value of an analog channel to 255.")

  (function set-all-analog
    "Set the output value of both analog channels to 255.")

  (function write-all-digital
    "Write all the digital outputs at once. Should be a bitmask.")

  (function clear-digital-channel
    "Turn off a digital channel.")

  (function clear-all-digital
    "Turn off all digital channels.")

  (function set-digital-channel
    "Turn on a digital channel.")

  (function set-all-digital
    "Turn on all digital channels.")

  (function read-digital-channel
    "Read the value of a digital channel.")

  (function read-all-digital
    "Read  the values of all digital channels.")

  (function reset-counter
    "Reset a counter.")

  (function read-counter
    "Read the value of a counter.")

  (function set-counter-debounce-time
    "Set the debouncing time of a counter to a specific value.")

  (function read-all-values
    "Read all inputs on the board at once.")

  (function set-all-values
    "Set all outpouts on the board at once."))

;; wrapper.lisp
(in-package #:org.shirakumo.k8055)
(docs:define-docs
  (variable *default-max-attempts*
    "The default maximum number of retries for a request to the board.")

  (variable *voltage-map*
    "A map of voltages for the analog inputs/outputs.")

  (function connect
    "Attempt to connect to both devices.

Signals an error if it was unsuccessful.")

  (function disconnect
    "Disconnect from the devices.")

  (function call-with-positive-return
    "Retries calling the function until it returns a positive value.

If MAX-ATTEMPTS is exceeded, an error is signalled.

See *DEFAULT-MAX-ATTEMPTS*")

  (function with-positive-return
    "Convenience wrapper around CALL-WITH-POSITIVE-RETURN, ensuring that the body returns a positive value.

See CALL-WITH-POSITIVE-RETURN")

  (function digital
    "Accessor to the digital inputs and outputs.

The values should be booleans.
The channel must be an integer in [1,8].")

  (function analog
    "Accessor to the analog inputs and outputs.

The values should be integers, which will be truncated to
the range [0,255].
The channel must be an integer in [1,2].")

  (function analogf
    "Accessor to the analog inputs and outputs.

The values should be floats, truncated to the range [0,1].

See ANALOG")

  (function analogv
    "Accessor to the analog inputs and outputs.

The values should be voltage floats, truncated to the
respective input/output voltages.

See VOLTAGE
See ANALOGF")

  (function voltage
    "Accessor to the voltage maps for the analog ouputs and inputs.

Direction should be one of :IN :OUT, and the value a
float designating the upper-bound voltage number.

See *VOLTAGE-MAP*")

  (function counter
    "Reads the value of a counter.")

  (function reset-counter
    "Resets a counter.")

  (function (setf counter-debounce-time)
    "Sets the debounce time of a counter."))
