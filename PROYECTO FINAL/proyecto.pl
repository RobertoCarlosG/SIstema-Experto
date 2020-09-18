% Proyecto  de Inteligencia Artificial
% Sistema experto

%Cargando libreria Grafica y estilo
:- use_module(library(pce)).
:- use_module(library(pce_style_item)).
%Directorio de imagenes
:- pce_image_directory('./assets').
%PErmitimos acentos y caracteres especiales
:- encoding(utf8).

%Cargando recursos

resource(aerobics1,image,image('aerobics1.jpg')).
resource(aerobics2,image,image('aerobics2.jpg')).
resource(bicicleta,image,image('cycling.jpg')).
resource(natacion1,image,image('natacion1.jpg')).
resource(natacion2,image,image('natacion2.jpg')).
resource(estiramientos1,image,image('streching.jpg')).
resource(estiramientos_varios,image,image('streching_menu.jpg')).
resource(estiramientos2,image,image('streching2.jpg')).
resource(caminata1,image,image('walking.jpg')).
resource(caminata2,image,image('walking2.jpg')).

