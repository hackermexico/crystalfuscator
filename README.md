# crystalfuscator
Herramienta en crystal para obfuscar código HTML - versión cli y versión web en el 8080

Crystalfuscator Web es una herramienta ligera escrita en Crystal, diseñada para ofuscar HTML y sus atributos de id y class. Permite proteger tu código visualmente, evitando que sea fácilmente legible, sin romper su funcionalidad.

Características

Ofuscación rápida de IDs y clases en HTML.

Mantiene el HTML funcional y cualquier JS/CSS incluido.

Interfaz Web simple con visualización Antes/DCrystalfuscator Web Final es una herramienta ligera escrita en Crystal, diseñada para ofuscar HTML y sus atributos de id y class. Permite proteger tu código visualmente, evitando que sea fácilmente legible, sin romper su funcionalidad.

Características

Ofuscación rápida de IDs y clases en HTML.

Mantiene el HTML funcional y cualquier JS/CSS incluido.

Interfaz Web simple con visualización Antes/Después.

Permite copiar/pegar HTML o subir archivos .html.

Descarga directa del archivo ofuscado.

Ultra simple, sin dependencias externas ni heredocs problemáticos.

Instalación

Instalar Crystal si no lo tienes:

# Para Debian/Ubuntu
curl -sSL https://crystal-lang.org/install.sh | sudo bash


Clonar o copiar web_final_cr.cr en tu proyecto.

Compilar el binario:

crystal build --release web_final_cr.cr -o fuscatorweb


Ejecutar:

./fuscatorweb


Abrir navegador en http://localhost:8080

Uso
Interfaz Web

Copiar y pegar HTML:

Pega tu código en el textarea izquierdo.

Haz click en Procesar.

Verás el HTML ofuscado en el textarea derecho.

Puedes descargarlo con Descargar HTML ofuscado.

Subir archivo HTML:

Selecciona un archivo .html.

Haz click en Procesar.

Visualiza el resultado y descarga si quieres.espués.

Permite copiar/pegar HTML o subir archivos .html.

Descarga directa del archivo ofuscado.

Ultra simple, sin dependencias externas ni heredocs problemáticos.

Instalación

Instalar Crystal si no lo tienes:

# Para Debian/Ubuntu
curl -sSL https://crystal-lang.org/install.sh | sudo bash


Clonar o copiar web_final_cr.cr en tu proyecto.

Compilar el binario:

crystal build --release web_final_cr.cr -o fuscatorweb


Ejecutar:

./fuscatorweb


Abrir navegador en http://localhost:8080

Uso
Interfaz Web

Copiar y pegar HTML:

Pega tu código en el textarea izquierdo.

Haz click en Procesar.

Verás el HTML ofuscado en el textarea derecho.

Puedes descargarlo con Descargar HTML ofuscado.

Subir archivo HTML:

Selecciona un archivo .html.

Haz click en Procesar.

Visualiza el resultado y descarga si quieres.
