# Depurando en Visual Studio

## Setup de ambiente de desarrollo
1. Instalar Visual Studio 2019 o 2022 siguiendo las instrucciones de [este link](https://www.wikihow.com/Use-MASM-in-Visual-Studio-2022)
2. Instalar extensión ASMdude para Visual Studio [2019](https://marketplace.visualstudio.com/items?itemName=Henk-JanLebbink.AsmDude) o [2022](https://github.com/HJLebbink/asm-dude/files/7822110/AsmDude-vs2022.zip)
3. Usar template proveida en la carpeta recursos

## Ejecución de programas
- **Ctrl + F5** para ejecutar el programa sin depurar
- **F5** para ejecutar el programa en modo depuración
- **F10** para ejecutar la siguiente instrucción
- **F11** para ejecutar la siguiente instrucción y entrar a la función si es necesario
- **F9** para establecer un breakpoint en la línea actual
## Visualización de variables
- **Debug -> Windows**(en el menú superior, al haber iniciado la depuración)
Este menú da para establecer ventanas de variables, registros, codigo desensamblado, etc. que se pueden mostrar en la parte inferior de la ventana de Visual Studio. Las variables se pueden agregar a la ventana haciendo click derecho sobre ellas y seleccionando "Add Watch", o bien abriendo un watch window y escribiendo el nombre de la variable.
