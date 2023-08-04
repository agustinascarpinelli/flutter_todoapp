# Todos App

## Descripción
Todos App es una aplicación de Flutter que permite crear y gestionar tareas por hacer. La aplicación cuenta con un servidor desarrollado en Node.js y sockets, el cual se encuentra desplegado en Render. Puedes encontrar el repositorio del servidor en [este enlace](https://github.com/agustinascarpinelli/flutter-socket-server).

La aplicación muestra la fecha y hora actual en la parte superior de la pantalla, actualizándose en tiempo real. Además, cuenta con un botón flotante que permite agregar nuevas tareas a la lista. Cada tarea muestra la cantidad de horas dedicadas, la cual se puede incrementar o decrementar. También es posible eliminar una tarea de la lista. La aplicación incluye un gráfico circular (PieChart) que muestra el porcentaje de las tareas realizadas según la cantidad de horas.


## Funcionalidades principales
- Muestra la fecha y hora actual en tiempo real.
- Permite agregar nuevas tareas a la lista.
- Cada tarea muestra la cantidad de horas dedicadas, que se puede incrementar o decrementar.
- Permite eliminar tareas de la lista.
- Gráfico circular (PieChart) que muestra el porcentaje de las tareas realizadas según la cantidad de horas.

## Dependencias utilizadas
- `cupertino_icons: ^1.0.2`
- `socket_io_client: ^2.0.1`
- `provider: ^6.0.5`
- `pie_chart: ^5.3.2`
- `date_format: ^2.0.7`

## Configuración y ejecución del proyecto
1. Asegúrate de tener Flutter instalado en tu máquina.
2. Clona este repositorio en tu máquina local.
3. Navega hasta el directorio del proyecto en la línea de comandos.
4. Ejecuta el comando `flutter pub get` para instalar las dependencias.
5. Asegúrate de tener el servidor Node.js y sockets desplegado en Render.
6. Conecta tu dispositivo o inicia un emulador.
7. Ejecuta el comando `flutter run` para compilar y ejecutar la aplicación en tu dispositivo/emulador.

## Contribuciones
Las contribuciones son bienvenidas. Si encuentras algún problema o tienes alguna sugerencia de mejora, no dudes en abrir un issue o enviar un pull request.

## Licencia
Este proyecto está bajo la Licencia [MIT](https://opensource.org/licenses/MIT).

