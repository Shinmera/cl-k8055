## About cl-k8055d
Interface for the [Velleman K8055 USB kit](https://www.velleman.eu/products/view/?id=351346) through the [K8055](https://github.com/rm-hull/k8055) linux driver. The driver library is included for x86-64 and ARM.

## How To
Connect to the board/s.

```
(k8055:connect)
```

Read out or set some values to the inputs/outputs.

```
;; Inputs
(k8055:digital 0)
(k8055:analog 0)
(k8055:analogf 0)
(k8055:analogv 0)
;; Outputs
(setf (k8055:digital 1) T)
(setf (k8055:analog 0) 120)
(setf (k8055:analogf 0) 0.25)
(setf (k8055:analogv 0) 5.0)
;; Counters
(k8055:counter 0)
(k8055:reset-counter 0)
```

If the voltage mapping that is provided by default (4.7V for outputs, 10V for inputs) is not correct, you can adjust it with the `voltage` accessor.

Once you're done, you should probably disconnect again.

```
(k8055:disconnect)
```
