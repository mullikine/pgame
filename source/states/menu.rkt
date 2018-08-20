#lang racket

(require racket/list syntax/parse/define
         (for-syntax racket/base racket/list racket/string
                     threading)
         ffi/vector finalizer math/matrix opengl opengl/util threading
         glfw3 logger memo nested-hash spipe
         "../breakpoint.rkt" "../drawing.rkt" "../impure.rkt" "../initialization.rkt" "../pure.rkt" "../shutdown.rkt" "../state.rkt")

(require "../visualizer.rkt")

(provide (all-defined-out))

(state menu
  (enter
    (show-visualization)  ; Blocks by using a subprogram
    ;; We need to reset the keys due to sticky keys,
    ;; if we didn't, we'd return to this function again.
    (get-keys   (io.window) (ae.keys))
    (set-false  ae.keys.escape)
    )
  (pre)
  (pure
    ;; Finally, indicate that we no longer want to loop here,
    ;; return from whence we came.
    (pop-fsm    fsm)
    )
  (post)
  (exit)
  )