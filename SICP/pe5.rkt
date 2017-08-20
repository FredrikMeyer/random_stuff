#lang racket

(apply lcm (build-list 20 (lambda (x) (+ x 1))))