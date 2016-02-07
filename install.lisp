;;; -*- Common Lisp -*-
;;; Installs stumpwm and swank from quicklisp,
;;; which is also installed.
(load "quicklisp.lisp")
(quicklisp-quickstart:install)
(ql:quickload "stumpwm")
(ql:quickload "swank")
(quit)
