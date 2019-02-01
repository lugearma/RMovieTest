# RMovieTest

## Capas de la app
- La capa de **vistas** que esta confomada por los controladores(subclases de UIViewController) y las vistas 
customizadas como las celdas(subclases de UITableViewCell) asi como sus respectivos archivos .xib
- La logica de **negocio** se encuentra en los ViewModel, en este caso algunos archivos serian: MovieDetailListViewModel
MovieCellViewModel
- La capa de **red** esta conformada por los archivos ApiClient, ApiClientRouter, Result, etc... esta capa se encarga de hacer 
los request al servidor, es una "interfaz" para la comunicacion con el server.
- La capa de **modelo** contiene las entidades que seran utilizadas para representar la informacion en la app, algunas son: 
Movie, MovieRequest
- La capa de **navegación** la defino con la clase Navigator, esta se encarga de coordinar el flujo de la app.

## Pregunta
- Principio de responsabilidad unica: Es un pricipio que dicta que cada entidad del sistema(clase, structura, modulo, etc...) tiene que cumplir una sola tarea, 
sólo debe tener una única responsabilidad.
- Buen Codigo: Considero un buen codigo aquel que sea facil de leer, que al agregar una nueva funcionalidad sea facil de hacerlo,
que haga uso de los patrones de diseño, que se sigan "buenas practias" cuando se escribe, que el codigo se exprese por 
sí mismo (pocos comentarios), que tenga bien definidas las capas(vista, negocio, red, etc...)
