Renderizando componentes de ReactJs con Ruby on Rails Usando React.js en el servidor con Rails


EL Desarrollo Web es a menudo visto como un mundo loco donde la forma de desarrollar el software es lanzar hacks en la parte superior de otros hacks. Creo que React rompe con este patrón y en su lugar ha sido diseñado desde el primer principio que le da una base sólida para construir (Christopher Chedeau  — Front-end Engineer at Facebook) .
React es una de esas pequeñas cosas de la vida que llega una vez cada 1000 años(es una pequeña exageración) para … , el uso de React aumenta la velocidad y la estabilidad en la que se desarrolla el software hoy en día, así como también cambia completamente la forma en la que se piensa en construir el software del lado del frontend. 
Hasta ahí todo cool, si vamos un poco mas allá descubriremos que una de las grandes ventajas de React es poder renderizar componentes desde el servidor lo cual suena realmente bien,  pero esto al final del túnel siempre nos conduce al gran amigo NodeJs, lo cual no es muy agradable si nuestro backend está desarrollado en otra tecnología y tener que migrar toda una plataforma a otra no es para nada sencillo.
Para nadie es un secreto que la relación entre Javascript y Rails no ha sido una de las mejores que digamos, pero todo eso se ha quedado en el pasado, la verdad es que ahora que el ki de Javascript se ha incrementado y está desatando su máximo poder especialmente con la llegada de ES6 y herramientas de manejo de paquetes y compilación como yarn y webpack, Rails ha reconsiderado todo esto y ha decidido adoptar estas soluciones bajo sus alas.
Las mejoras en Rails 5.1 se concentran en tres partes principales: 
Administrar dependencias de JavaScript desde Npm a través de Yarn.
Compilar Javascript con Webpack.
Dejar de lado a Jquery como dependencia predeterminada.

Para este post asumo que tienes instalado Rails 5.1 o una versión superior de no ser así visita está página donde te muestran como instalarlo, y también es necesario que tengas instalado Yarn, puedes leer las instrucciones de como hacerlo aquí.
Generando nuestra aplicación
Creamos un proyecto con React usando Webpacker de Rails con el siguiente comando:
$ rails new react-rails --webpack=react
Al ejecutar este comando podremos observar como se instalan las dependencias necesarias para trabajar con Rails y las dependencias de Javascript vía Yarn.
En este punto, Rails ha creado una aplicación para javascript agradable para nosotros. Si observamos la carpeta `app / javascript` veremos una nueva carpeta llamada packs con dos archivos en ella (application.jsx y hello_react.jsx). Esta carpeta de packs es una nueva cosa añadida en Rails 5.1.
app/javascript/
└── packs
    ├── application.js
    └── hello_react.jsx
1 directory, 2 files
Todo en el directorio de paquetes es compilado automáticamente por Webpack. La mejor práctica es colocar la lógica de la aplicación real en una estructura relevante dentro de app / javascript y sólo usar estos archivos de paquete para hacer referencia a ese código para que se compile. Echemos un vistazo a hello_react.js:
import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
const Hello = props => (
  <div>Hello {props.name}!</div>
)
Hello.defaultProps = {
  name: 'Conde'
}
Hello.propTypes = {
  name: PropTypes.string
}
document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Hello name="React" />,
    document.body.appendChild(document.createElement('div')),
  )
})
¡Es un componente reactivo! Rails nos ha generado una muestra reaccionar componente que podemos hacer en una vista siempre que queramos. Incluso podemos escribir jsx en ella. ¿¡Que podría ser mejor!?
Este componente reactivo sólo hace que `Hello React`, pero podemos hacer componentes complejos si necesitamos
El siguiente paso es hacer que nuestro componente utilice Rails. Vamos a crear un controlador Rails:
rails g controller Home index
Este comando creó un PagesController con un método de índice en él. También nos crea una plantilla de vista en app / views / pages / index.html.erb. Para procesar nuestro componente React, solo necesitamos reemplazar el contenido del archivo por: