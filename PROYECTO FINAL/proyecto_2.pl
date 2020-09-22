% Proyecto  de Inteligencia Artificial
% Sistema experto

%Cargando libreria Grafica y estilo
:- use_module(library(pce)).
:- use_module(library(pce_style_item)).
:- dynamic color/2.
%Directorio de imagenes
:- pce_image_directory('./imagenes').
%PErmitimos acentos y caracteres especiales
:- encoding(utf8).

%Cargando recursos

resource(portada, image, image('streching_menu.jpg')).
%AGREGAR AQUI LAS IMAGENES DE LOS TRATAMIENTOS CON nombre
% dieta1,dieta2,dieta3...
resource(dieta1, image, image('Dieta1.jpg')).
resource(dieta2, image, image('Dieta2.jpg')).
resource(dieta3, image, image('Dieta3.jpg')).
resource(dieta4, image, image('Dieta4.jpg')).
resource(dieta5, image, image('Dieta5.jpg')).
resource(img_principal, image, image('streching_menu.jpg')).
resource(aerobics1, image, image('aerobics1.jpg')).
resource(aerobics2, image, image('aerobics2.jpg')).
resource(cycling, image, image('cycling.jpg')).
resource(natacion1, image, image('natacion1.jpg')).
resource(natacion2, image, image('natacion2.jpg')).
resource(estiramientos1, image, image('streching.jpg')).
resource(estiramientos_varios, image, image('streching_menu.jpg')).
resource(estiramientos2, image, image('streching2.jpg')).
resource(caminata1, image, image('walking.jpg')).
resource(caminata2, image, image('walking2.jpg')).
resource(articulaciones, image, image('articulaciones.jpg')).
resource(alto_impacto, image, image('alto_impacto.jpg')).
resource(hipertension, image, image('tension.jpg')).
resource(hipotension, image, image('tension.jpg')).
resource(presion, image, image('presion.jpg')).
resource(cerveza, image, image('cerveza.jpg')).
resource(covid, image, image('covid.jpg')).
resource(problemas_respiratorios, image, image('problemas_respiratorios.jpg')).
resource(chatarra, image, image('chatarra.jpg')).
resource(azucar, image, image('azucar.jpg')).
resource(bb_agua, image, image('bb_agua.jpg')).



mostrar_imagen(Pantalla, Imagen) :- new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(100,80)).

mostrar_imagen_tratamiento(Pantalla, Imagen) :-new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(20,100)).
 nueva_imagen(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(0,0)).
imagen_pregunta(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(500,60)).

botones:-borrado,
                send(@boton, free),
                send(@btntratamiento,free),
                mostrar_diagnostico(Enfermedad),
                send(@texto, selection('La Recomendacion a partir de los datos es:')),
                send(@resp1, selection(Enfermedad)),
                new(@boton, button('Iniciar consulta',
                message(@prolog, botones)
                )),

                new(@btntratamiento,button('Detalles y Rutina',
                message(@prolog, mostrar_tratamiento,Enfermedad)
                )),
                send(@main, display,@boton,point(20,450)),
                send(@main, display,@btntratamiento,point(138,450)).

mostrar_tratamiento(X):-new(@tratam, dialog('Recomendacion')),
                          send(@tratam, append, label(nombre, 'Explicacion: ')),
                          send(@tratam, display,@lblExp1,point(70,51)),
                          send(@tratam, display,@lblExp2,point(50,80)),
                          tratamiento(X),
                          send(@tratam, transient_for, @main),
                          send(@tratam, open_centered).

tratamiento(X):- send(@lblExp1,selection('De Acuerdo Al Diagnostico La Recomendacion Es:')),
                 mostrar_imagen_tratamiento(@tratam,X).

%Comportamiento, aqui se ciclan las preguntas al hacer return y almacenar en respuesta, se vuelve a enviar la funcion con los datos enviados
preguntar(Preg,Resp):-new(Di,dialog('Colsultar Datos:')),
                        new(L2,label(texto,'Responde las siguientes preguntas')),
                        id_imagen_preg(Preg,Imagen),
                        imagen_pregunta(Di,Imagen),
                        new(La,label(prob,Preg)),
                        new(B1,button(si,and(message(Di,return,si)))),
                        new(B2,button(no,and(message(Di,return,no)))),
                        send(Di, gap, size(25,25)),
                        send(Di,append(L2)),
                        send(Di,append(La)),
                        send(Di,append(B1)),
                        send(Di,append(B2)),
                        send(Di,default_button,'si'),
                        send(Di,open_centered),get(Di,confirm,Answer),
                        free(Di),
                        Resp=Answer.

%Pantalla 1
interfaz_principal:-new(@main,dialog('Sistema Experto (Rutinas para gente con diabetes)',
        size(1000,1000))),
        new(@texto, label(nombre,'El Diagnostico a partir de los datos es:',font('times','roman',18))),
        new(@resp1, label(nombre,'',font('times','roman',22))),
        new(@lblExp1, label(nombre,'',font('times','roman',14))),
        new(@lblExp2, label(nombre,'',font('times','roman',14))),
        new(@salir,button('SALIR',and(message(@main,destroy),message(@main,free)))),
        new(@boton, button('Iniciar consulta',message(@prolog, botones))),

        new(@btntratamiento,button('¿Tratamiento?')),

        nueva_imagen(@main, img_principal),
        send(@main, display,@boton,point(138,450)),
        send(@main, display,@texto,point(20,350)),
        send(@main, display,@salir,point(300,450)),
        send(@main, display,@resp1,point(20,390)),
        send(@main,open_centered).

       borrado:- send(@resp1, selection('')).

%PAntalla bienvenida
crea_interfaz_inicio:- new(@interfaz,dialog('Bienvenido al Sistema Experto Diagnosticador',
  size(1000,1000))),

  mostrar_imagen(@interfaz, portada),

  new(BotonComenzar,button('COMENZAR',and(message(@prolog,interfaz_principal) ,
  and(message(@interfaz,destroy),message(@interfaz,free)) ))),
  new(BotonSalir,button('SALIDA',and(message(@interfaz,destroy),message(@interfaz,free)))),
  send(@interfaz,append(BotonComenzar)),
  send(@interfaz,append(BotonSalir)),
  send(@interfaz,open_centered).

  :-crea_interfaz_inicio.

/* BASE DE CONOCIMIENTOS: Sintomas y Enfermedades del Pez Goldfish, contiente ademas
el identificador de imagenes de acuerdo al  sintoma
*/

conocimiento('dieta1',
['¿Practicas algún deporte o alguna actividad física?', '¿Deportes o actividad de contacto?',
'¿Sufres problemas con tus articulaciones?','¿sufres de hipertensión?']).

conocimiento('dieta2',
['¿sufre alguna enfermedad cardiaca?', '¿sufres de hipertensión?',
'¿sufres de hipotensión?']).

conocimiento('dieta3',['¿consumes alcohol?',
'¿bebes 2 o mas litros de agua al día?']).

conocimiento('dieta4',
['¿Alguna vez tuvo COVID-19?', '¿Sufre problemas para respirar?']).

conocimiento('dieta5',
['¿Comes comida chatarra más de tres veces a la semana?', '¿Consumes bebidas con altos niveles de azúcar?']).

id_imagen_preg('¿Practicas algún deporte o alguna actividad física?','cycling').
id_imagen_preg('¿Sufres problemas con tus articulaciones?','articulaciones').
id_imagen_preg('¿Deportes o actividad de contacto?','alto_impacto').
id_imagen_preg('¿sufres de hipertensión?','hipertension').
id_imagen_preg('¿sufre alguna enfermedad cardiaca?','presion').
id_imagen_preg('¿sufres de hipotensión?','hipotension').
id_imagen_preg('¿consumes alcohol?','cerveza').
id_imagen_preg('¿Alguna vez tuvo COVID-19?','covid').
id_imagen_preg('¿Sufre problemas para respirar?','problemas_respiratorios').
id_imagen_preg('¿Comes comida chatarra más de tres veces a la semana?','chatarra').
id_imagen_preg('¿Consumes bebidas con altos niveles de azúcar?','azucar').
id_imagen_preg('¿bebes 2 o mas litros de agua al día?','bb_agua').


 /* MOTOR DE INFERENCIA: Esta parte del sistema experto se encarga de
 inferir cual es el diagnostico a partir de las preguntas realizadas
 */
:- dynamic conocido/1.

mostrar_diagnostico(X):-haz_diagnostico(X),clean_scratchpad.
  mostrar_diagnostico(lo_siento_diagnostico_desconocido):-clean_scratchpad .

  haz_diagnostico(Diagnosis):-
                            obten_hipotesis_y_sintomas(Diagnosis, ListaDeSintomas),
                            prueba_presencia_de(Diagnosis, ListaDeSintomas).


obten_hipotesis_y_sintomas(Diagnosis, ListaDeSintomas):-
                            conocimiento(Diagnosis, ListaDeSintomas).


prueba_presencia_de(_Diagnosis, []).
prueba_presencia_de(Diagnosis, [Head | Tail]):- prueba_verdad_de(Diagnosis, Head),
                                              prueba_presencia_de(Diagnosis, Tail).


prueba_verdad_de(_Diagnosis, Sintoma):- conocido(Sintoma).
prueba_verdad_de(Diagnosis, Sintoma):- not(conocido(is_false(Sintoma))),
pregunta_sobre(Diagnosis, Sintoma, Reply), Reply = 'si'.


pregunta_sobre(Diagnosis, Sintoma, Reply):- preguntar(Sintoma,Respuesta),
                          process(Diagnosis, Sintoma, Respuesta, Reply).


process(_Diagnosis, Sintoma, si, si):- asserta(conocido(Sintoma)).
process(_Diagnosis, Sintoma, no, no):- asserta(conocido(is_false(Sintoma))).


clean_scratchpad:- retract(conocido(_X)), fail.
clean_scratchpad.


conocido(_):- fail.

not(X):- X,!,fail.
not(_).


