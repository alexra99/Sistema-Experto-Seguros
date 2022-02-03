;;PLANTILLAS
(deftemplate cliente "Datos del cliente"
    (slot nombre (type SYMBOL))
    (slot dni (type SYMBOL)) 
    (slot edad (type INTEGER) (range 18 99))
    (slot residencia (type SYMBOL))
    (slot carnet (type INTEGER) (range 1 99))
    (slot potencia (type INTEGER) (range 49 1000))
    (slot antiguedad (type INTEGER) (range 0 50))
    (slot garaje (type INTEGER) (range 1 4)) 
    (slot uso (type SYMBOL)) 
    (slot km (type INTEGER) (range 0 5000000))
    (slot partes_5 (type INTEGER))
    (slot multas_5 (type INTEGER))
    (slot seguro (type INTEGER) (range 1 3)) 
)
(deftemplate poliza
        (slot riesgo_edad)
        (slot incremento_edad)
        (slot riesgo_carnet)
        (slot incremento_carnet)
        (slot riesgo_potencia)
        (slot incremento_potencia)
        (slot riesgo_antiguedad)
        (slot incremento_antiguedad)
        (slot riesgo_garaje)
        (slot incremento_garaje)
        (slot riesgo_partes_5)
        (slot incremento_partes_5)
        (slot riesgo_multas_5)
        (slot incremento_multas_5)
        (slot tipo_seguro)
        (slot precio_base)
        (slot cobertura1)
        (slot incremento_cobertura1)
        (slot cobertura2)
        (slot incremento_cobertura2)
        (slot cobertura3)
        (slot incremento_cobertura3)
        (slot cobertura4)
        (slot incremento_cobertura4)
        (slot cobertura5)
        (slot incremento_cobertura5)
        (slot cobertura6)
        (slot incremento_cobertura6)       
)
;;----------------------------------------HECHOS---------------------------------------------------------------------------------------
(deffacts conductores
(cliente (nombre Alejandro) (dni 0572294L) (edad 22) (residencia Almagro) (carnet 3)
(potencia 240) (antiguedad 4) (garaje 1) (uso trabajo) (km 3000000)
(partes_5 3) (multas_5 4) (seguro 1))
(cliente (nombre Juan) (dni 0576694L) (edad 42) (residencia Madrid) (carnet 3)
(potencia 90) (antiguedad 4) (garaje 2) (uso trabajo) (km 4000)
(partes_5 3) (multas_5 7) (seguro 3))
(cliente (nombre Pedro) (dni 02242294L) (edad 31) (residencia Barcelona) (carnet 9)
(potencia 120) (antiguedad 4) (garaje 3) (uso trabajo) (km 73000)
(partes_5 0) (multas_5 0) (seguro 2))
(iniciar)
)
;;-----------------------------------------------------------REGLAS------------------------------------------------------------------------
(defrule MENU
 (iniciar)
 =>
 (printout t "*************************************************** " crlf)
 (printout t " 1. REGISTRAR " crlf)
 (printout t " 2. MODIFICAR " crlf)
 (printout t " 3. ELIMINAR  " crlf)
 (printout t " 4. CALCULAR SEGURO " crlf)
 (printout t " 5. SALIR " crlf)
 (printout t " -----escriba la opcion (entre 1 y 5) y pulse enter " crlf)
 (printout t "*************************************************** " crlf)
 (printout t "¿QUE DESEAS HACER? " crlf)
 (assert (respuesta (read)))
)
(defrule REGISTRAR
 ?f<-(respuesta 1)
 =>
 (printout t "DATOS PERSONALES DEL CONDUCTOR" crlf)
 (printout t "NOMBRE: ?" crlf)
 (bind ?nombre (read))
 (printout t "DNI: ?" crlf)
 (bind ?dni (read))
 (printout t "EDAD: ?" crlf)
 (bind ?edad (read))
 (printout t "RESIDENCIA ?" crlf)
 (bind ?residencia (read))
 (printout t "ANYOS CARNET CONDUCIR ?" crlf)
 (bind ?carnet (read))
 (printout t "DATOS DEL VEHÍCULO A ASEGURAR: " crlf)
 (printout t "POTENCIA DEL VEHICULO (cV): ?" crlf)
 (bind ?potencia (read))
 (printout t "ANTIGUEDAD DEL VEHICULO: ?" crlf)
 (bind ?antiguedad (read))
 (printout t "GARAJE HABITUAL DEL VEHÍCULO: ?" crlf)
 (bind ?garaje (read))
 (printout t "USO DEL VEHICULO: ?" crlf)
 (bind ?uso (read))
 (printout t "KILOMETRO POR ANYO DEL VEHICULO: ?" crlf)
 (bind ?km (read))
 (printout t "DATOS DE SINIESTROS: " crlf)
 (printout t "Nº PARTES ULTIMOS 5 ANYOS: ?" crlf)
 (bind ?partes_5 (read)) 
 (printout t "Nº MULTAS ULTIMOS 5 ANYOS: ?" crlf)
 (bind ?multas_5 (read))
 (printout t "TIPO DE SEGURO: ?" crlf)
 (bind ?seguro (read))  
 (retract ?f)
 (assert (cliente (nombre ?nombre)(dni ?dni)(edad ?edad)(residencia ?residencia) (carnet ?carnet) 
 (potencia ?potencia)(antiguedad ?antiguedad)(garaje ?garaje)(uso ?uso) (km ?km)
 (partes_5 ?partes_5)(multas_5 ?multas_5)) (seguro ?seguro))
 (refresh MENU)
)

(defrule BUSCAYMODIFICA
 ?f<-(respuesta 2)
 =>
 (printout t "CLIENTE A MODIFICAR: ?" crlf)
 (bind ?nombre (read))
 (retract ?f)
 (assert (Modificarhechos ?nombre))
)
(defrule MODIFICAR
 ?f1<-(Modificarhechos ?nombre)
 ?f<-(cliente (nombre ?nombre))
 =>
 (printout t "NUEVO NOMBRE: ?" crlf)
 (bind ?nombre (read))
 (modify ?f (nombre ?nombre))
 (retract ?f1)
 (refresh MENU) 
)
(defrule ELIMINAR
 ?f<-(respuesta 3)
 =>
 (printout t "CLIENTE A ELIMINAR: ?" crlf)
 (bind ?nombre (read))
 (retract ?f)
 (assert (ELIMINAR ?nombre))
)
(defrule BUSCAYELIMINA
 ?f1<-(ELIMINAR ?nombre)
 ?f <-(cliente (nombre ?nombre))
 =>
 (retract ?f1)
 (retract ?f)
 (refresh MENU);PARA ACTIVAR Y EJECUTAR LA REGLA MENU
)
(defrule BUSCACLIENTE
?f<-(respuesta 4)
=>
(printout t "SELECCIONA CLIENTE PARA CALCULAR SEGURO: ?" crlf)
 (bind ?nombre (read))
 (retract ?f)
 (assert (calcularpoliza ?nombre))
)
(defrule MUESTRACLIENTE
 ?f1<-(calcularpoliza ?nombre)
 ?f<-(cliente (nombre ?nombre))
 (cliente (nombre ?nombre)(dni ?dni)(edad ?edad)(residencia ?residencia) (carnet ?carnet) 
 (potencia ?potencia)(antiguedad ?antiguedad)(garaje ?garaje)(uso ?uso) (km ?km)
 (partes_5 ?partes_5)(multas_5 ?multas_5))
   =>
    (printout t "Cliente encontrado." crlf )
    (printout t "*************************************************** " crlf)
    (printout t "************DATOS PERSONALES DEL CLIENTE*********** " crlf)
    (printout t "NOMBRE: " ?nombre  crlf)
    (printout t "DNI: " ?dni  crlf)
    (printout t "EDAD: " ?edad  crlf)
    (printout t "LUGAR DE RESIDENCIA: " ?residencia  crlf)
    (printout t "ANTIGUEDAD CARNET DE CONDUCIR: " ?carnet  crlf)
    (printout t "*****************DATOS DEL VEHICULO***************** " crlf)
    (printout t "POTENCIA DEL VEHICULO: " ?potencia " CV" crlf )
    (printout t "ANTIGUEDAD DEL VEHICULO: " ?antiguedad " anyos" crlf )
    (printout t "GARAJE HABITUAL DEL VEHICULO: " ?garaje  crlf )
    (printout t "USO DEL VEHICULO: " ?uso  crlf) 
    (printout t "KILOMETROS POR ANYO: " ?km  crlf) 
    (printout t "**********************OTROS DATOS****************** " crlf)
    (printout t "PARTES EN LOS ULTIMOS 5 ANYOS: " ?partes_5 crlf) 
    (printout t "MULTAS EN LOS ULTIMOS 5 ANYOS: " ?multas_5  crlf) 
    (printout t "*************************************************** " crlf)
)
(defrule CALCULAR
 ?f1<-(calcularpoliza ?nombre)
 ?f<-(cliente (nombre ?nombre) (edad ?edad) (carnet ?carnet) (potencia ?potencia) (antiguedad ?antiguedad) (garaje ?garaje) 
 (partes_5 ?partes_5) (multas_5 ?multas_5) (seguro ?seguro))
 =>
 ;;reglas edad
 (if(and(>= ?edad 18)(<= ?edad 25))
 then
 (bind ?riesgo_edad 4)
 (bind ?incremento_edad 4)
 )
(if(and(>= ?edad 26)(<= ?edad 59))
 then
 (bind ?riesgo_edad 0) 
 (bind ?incremento_edad 0)
 )
 (if(>= ?edad 60)
 then
 (bind ?riesgo_edad 4) 
 (bind ?incremento_edad 4)
 )
 ;;reglas años carnet de conducir
(if(and(>= ?carnet 0)(<= ?carnet 4))
 then
(bind ?riesgo_carnet 4) 
(bind ?incremento_carnet 4)
 )
 (if(and(>= ?carnet 5)(<= ?carnet 9))
 then
 (bind ?riesgo_carnet 1) 
 (bind ?incremento_carnet 1)
 )
 (if(and(>= ?carnet 10)(<= ?carnet 39))
 then
 (bind ?riesgo_carnet 0) 
 (bind ?incremento_carnet 0)
 )
 (if(>= ?carnet 40)
 then
 (bind ?riesgo_carnet 4) 
 (bind ?incremento_carnet 4)
 )
 ;;reglas potencia motor del coche
 (if(< ?potencia 100)
 then
 (bind ?riesgo_potencia 0) 
 (bind ?incremento_potencia 0)
 )
 (if(and(>= ?potencia 100)(<= ?potencia 139))
 then
 (bind ?riesgo_potencia 1) 
 (bind ?incremento_potencia 1)
 )
 (if(and(>= ?potencia 140)(<= ?potencia 220))
 then
 (bind ?riesgo_potencia 2) 
 (bind ?incremento_potencia 2)
 )
 (if(>= ?potencia 220)
 then
 (bind ?riesgo_potencia 4) 
 (bind ?incremento_potencia 4)
 )
;;reglas antiguedad del vehiculo
(if(and(>= ?antiguedad 0)(<= ?antiguedad 4))
 then
 (bind ?riesgo_antiguedad 1) 
 (bind ?incremento_antiguedad 0)
 )
 (if(and(>= ?antiguedad 5)(<= ?antiguedad 9))
 then
 (bind ?riesgo_antiguedad 1) 
 (bind ?incremento_antiguedad 0)
 )
 (if(>= ?antiguedad 10)
 then
 (bind ?riesgo_antiguedad 1) 
 (bind ?incremento_antiguedad 2)
 )
 ;;reglas garaje vehiculo
(if(= ?garaje 1)
 then
 (bind ?riesgo_garaje 1) 
 (bind ?incremento_garaje 1)
 )
 (if(= ?garaje 2)
 then
 (bind ?riesgo_garaje 0) 
 (bind ?incremento_garaje 0)
 )
 (if(= ?garaje 3)
 then
 (bind ?riesgo_garaje 0) 
 (bind ?incremento_garaje 0)
 )
 (if(= ?garaje 4)
 then
 (bind ?riesgo_garaje 1) 
 (bind ?incremento_garaje 1)
 )
;;reglas partes 5 años
(if(and(>= ?partes_5 0)(<= ?partes_5 2))
 then
 (bind ?riesgo_partes_5 0) 
 (bind ?incremento_partes_5 0)
 )
 (if(and(>= ?partes_5 3)(<= ?partes_5 5))
 then
 (bind ?riesgo_partes_5 1) 
 (bind ?incremento_partes_5 1)
 )
 (if(>= ?partes_5 5)
 then
 (bind ?riesgo_partes_5 4) 
 (bind ?incremento_partes_5 4)
 )
;;reglas multas 5 años
(if(and(>= ?multas_5 0)(<= ?multas_5 2))
 then
 (bind ?riesgo_multas_5 0) 
 (bind ?incremento_multas_5 0)
 )
 (if(and(>= ?multas_5 3)(<= ?multas_5 5))
 then
 (bind ?riesgo_multas_5 1) 
 (bind ?incremento_multas_5 1)
 )
 (if(>= ?multas_5 5)
 then
 (bind ?riesgo_multas_5 4) 
 (bind ?incremento_multas_5 4)
 )
;;reglas seguros
 (if(= ?seguro 1)
 then
 (bind ?tipo_seguro 1)
 (bind ?precio_base 4) 
 (bind ?cobertura1 1 ) 
 (bind ?incremento_cobertura1 1 ) 
 (bind ?cobertura2 2 ) 
 (bind ?incremento_cobertura2 0) 
 (bind ?cobertura3 3) 
 (bind ?incremento_cobertura3 1)
 (bind ?cobertura4 4 ) 
 (bind ?incremento_cobertura4 2) 
 (bind ?cobertura5 5 )
 (bind ?incremento_cobertura5 2) 
 (bind ?cobertura6 6 ) 
 (bind ?incremento_cobertura6 3 )
 )
 
(if(= ?seguro 2)
 then
 (bind ?tipo_seguro 1)
 (bind ?precio_base 4) 
 (bind ?cobertura1 1 ) 
 (bind ?incremento_cobertura1 1 ) 
 (bind ?cobertura2 2 ) 
 (bind ?incremento_cobertura2 0) 
 (bind ?cobertura3 3) 
 (bind ?incremento_cobertura3 1)
 (bind ?cobertura4 4 ) 
 (bind ?incremento_cobertura4 2) 
 (bind ?cobertura5 5 )
 (bind ?incremento_cobertura5 2) 
 (bind ?cobertura6 6 ) 
 (bind ?incremento_cobertura6 3 )
 )

(if(= ?seguro 3)
 then
 (bind ?tipo_seguro 1)
 (bind ?precio_base 4) 
 (bind ?cobertura1 1 ) 
 (bind ?incremento_cobertura1 1 ) 
 (bind ?cobertura2 2 ) 
 (bind ?incremento_cobertura2 0) 
 (bind ?cobertura3 3) 
 (bind ?incremento_cobertura3 1)
 (bind ?cobertura4 4 ) 
 (bind ?incremento_cobertura4 2) 
 (bind ?cobertura5 5 )
 (bind ?incremento_cobertura5 2) 
 (bind ?cobertura6 6 ) 
 (bind ?incremento_cobertura6 3 )
)

(assert (poliza (riesgo_edad ?riesgo_edad) (incremento_edad ?incremento_edad)
(riesgo_carnet ?riesgo_carnet) (incremento_carnet ?incremento_carnet)
(riesgo_potencia ?riesgo_potencia) (incremento_potencia ?incremento_potencia)
(riesgo_antiguedad ?riesgo_antiguedad) (incremento_antiguedad ?incremento_antiguedad)
(riesgo_garaje ?riesgo_garaje) (incremento_garaje ?incremento_garaje)
(riesgo_partes_5 ?riesgo_partes_5) (incremento_partes_5 ?incremento_partes_5)
(riesgo_multas_5 ?riesgo_multas_5) (incremento_multas_5 ?incremento_multas_5)
(tipo_seguro ?tipo_seguro)
(cobertura1 ?cobertura1) (incremento_cobertura1 ?incremento_cobertura1)
(cobertura2 ?cobertura2) (incremento_cobertura2 ?incremento_cobertura2)
(cobertura3 ?cobertura3) (incremento_cobertura3 ?incremento_cobertura3)
(cobertura4 ?cobertura4) (incremento_cobertura4 ?incremento_cobertura4)
(cobertura5 ?cobertura5) (incremento_cobertura5 ?incremento_cobertura5)
(cobertura6 ?cobertura6) (incremento_cobertura6 ?incremento_cobertura6)
))
(printout t "---------------------------------------RESULTADO-------------------------------------------------" crlf)
(bind ?puntos_riesgo (+ ?riesgo_edad ?riesgo_carnet ?riesgo_potencia ?riesgo_antiguedad ?riesgo_garaje ?riesgo_partes_5 ?riesgo_multas_5))
(printout t " % RIESGO PARA LA ASEGURADORA: " (/ ?puntos_riesgo 0.24) "%"  crlf)
(bind ?puntos_poliza (+ ?incremento_edad ?incremento_carnet ?incremento_potencia ?incremento_antiguedad 
?incremento_garaje ?incremento_partes_5 ?incremento_multas_5))
(printout t " % INCREMENTO EN PRECIO DE POLIZA: " (/ ?puntos_poliza 0.24) "%"  crlf)
(printout t "-------------------------COBERTURAS LIBRES DE INCREMENTOS----------------------------" crlf)
(if(= ?incremento_cobertura1 0)
 then
 (printout t " COBERTURA DE LUNAS"  crlf)
 )
(if(= ?incremento_cobertura2 0)
 then
 (printout t "##COBERTURA DE LIBRE ELECCION DE TALLERES"  crlf)
 )
(if(= ?incremento_cobertura3 0)
 then
 (printout t "##COBERTURA DE TALLERES PREFERENTES"  crlf)
 )
 (if(= ?incremento_cobertura4 0)
 then
 (printout t "##COBERTURA DE TALLERES VEHICULO DE SUSTITUCION"  crlf)
 )
 (if(= ?incremento_cobertura5 0)
 then
 (printout t "##COBERTURA DE ATROPELLO DE ANIMALES"  crlf)
 )
 (if(= ?incremento_cobertura6 0)
 then
 (printout t "##COBERTURA DE GRANIZO Y PEDRISCO"  crlf)
 )
 (printout t "--------------------------COBERTURAS SOMETIDAS A INCREMENTOS---------------------------" crlf)
(if(!= ?incremento_cobertura1 0)
 then
 (printout t "##COBERTURA DE LUNAS CON INCREMENTO " (/ ?incremento_cobertura1 0.4) "% SOBRE PRECIO BASE"   crlf)
 )
(if(!= ?incremento_cobertura2 0)
 then
 (printout t "##COBERTURA DE LIBRE ELECCION DE TALLERES CON INCREMENTO " (/ ?incremento_cobertura2 0.4) "% SOBRE PRECIO BASE"  crlf)
 )
(if(!= ?incremento_cobertura3 0)
 then
 (printout t "##COBERTURA DE TALLERES PREFERENTES CON INCREMENTO " (/ ?incremento_cobertura3 0.4) "% SOBRE PRECIO BASE"    crlf)
 )
 (if(!= ?incremento_cobertura4 0)
 then
 (printout t "##COBERTURA DE TALLERES VEHICULO DE SUSTITUCION CON INCREMENTO " (/ ?incremento_cobertura4 0.4) "% SOBRE PRECIO BASE"    crlf)
 )
 (if(!= ?incremento_cobertura5 0)
 then
 (printout t "##COBERTURA DE ATROPELLO DE ANIMALES CON INCREMENTO " (/ ?incremento_cobertura5 0.4) "% SOBRE PRECIO BASE"  crlf)
 )
 (if(!= ?incremento_cobertura6 0)
 then
 (printout t "##COBERTURA DE GRANIZO Y PEDRISCO CON INCREMENTO " (/ ?incremento_cobertura6 0.4) "% SOBRE PRECIO BASE"    crlf)
 )
)
;;reglas de seguros

(defrule SALIR
 ?f<-(respuesta 5)
 =>
 (retract ?f)
 (halt)
)


