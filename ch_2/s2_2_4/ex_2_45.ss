#lang scheme

(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

; SICP 2.44 & 2.45: A Picture Language

(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))

(define (split dir1 dir2)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller ((split dir1 dir2) painter (- n 1))))
          (dir1 painter (dir2 smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))