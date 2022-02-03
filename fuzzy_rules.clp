;----------------------------------PLANTILLAS-----------------------------------------------------------------------
(deftemplate tiempo_carnet
    0 52 ;define el universo del discurso tiempo_min y tiempo_max
    (
        (bajo (0 1) (9 0))
        (medio (10 0) (20 1) (39 0))
        (alto (40 0)(52 1))
    )
)

(deftemplate riesgo
    0 100 ;define el universo del discurso riesgo_min y riesgo_max
    (
        (bajo (0 1) (49 0))
        (medio (50 0) (65 1) (89 0))
        (alto (90 0)(100 1))
    )
)

(deftemplate edad
    18 70 ;define el universo del discurso riesgo_min y riesgo_max
    (
        (baja (18 1) (29 0))
        (media (30 0) (45 1) (59 0))
        (alta (60 0) (70 1))
    )
)
;-------------------------------------------------REGLAS-------------------------------------------------------
(defrule regla_1
    (tiempo_carnet bajo)
    (edad baja)
=>
    (assert (riesgo alto))
)

(defrule regla_2
    (tiempo_carnet bajo)
    (edad media)
=>
    (assert (riesgo alto))
)

(defrule regla_3
    (tiempo_carnet bajo)
    (edad alta)
=>
    (assert (riesgo alto))
)
(defrule regla_4
    (tiempo_carnet medio)
    (edad baja)
=>
    (assert (riesgo alto))
)

(defrule regla_5
    (tiempo_carnet medio)
    (edad media)
=>
    (assert (riesgo bajo))
)

(defrule regla_6
    (tiempo_carnet medio)
    (edad alta)
=>
    (assert (riesgo alto))
)
(defrule regla_7
    (tiempo_carnet alto)
    (edad baja)
=>
    (assert (riesgo medio))
)

(defrule regla_8
    (tiempo_carnet alto)
    (edad media)
=>
    (assert (riesgo bajo))
)

(defrule regla_9
    (tiempo_carnet alto)
    (edad alta)
=>
    (assert (riesgo alto))
)

