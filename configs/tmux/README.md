# Comandos

## TERMINAL
* `tmux new -S nombreSesion`    --> Crea una nueva sesión
* `tmux ls`                     --> Lista de sesiones creadas
* `tmux attach -t nombreSesion` --> Ingresa en la sesión
* `tmux detach`                 --> Sale de la sesión

# BASICOS
* `PREFIX` = Ctrl + a
* `PREFIX + H`        --> Divide horizontalmente
* `PREFIX + V`        --> Divide verticalmente
* `PREFIX + r`        --> Recarga configuración de tmux
* `PREFIX + :`        --> Accede a la linea de comandos de tmux
* `PREFIX + l`        --> Limpia la terminal (como con `clear` o `Ctrl+l`)
* `PREFIX + Ctrl + s` --> Guarda el estado de Tmux actual (autoguardado cada 15 minutos)
* `PREFIX + Ctrl + r` --> Restaura el último estado de Tmux guardado

## PLUGINS
* `PREFIX + I`        --> Instala Plugins
* `PREFIX + U`        --> Actualiza Plugins
* `PREFIX + alt + u`  --> Elimina Plugins comentados o eliminados

## VENTANAS
* `PREFIX + c`        --> Crea una nueva ventana
* `PREFIX + 1`        --> Abre la primer ventana
* `PREFIX + 5`        --> Abre la quinta ventana
* `PREFIX + ,`        --> Cambia el nombre de una ventana
* `PREFIX + n`        --> Abre la siguiente ventana
* `PREFIX + p`        --> Abre la anterior ventana
* `PREFIX + &`        --> Cerrar ventana
* `PREFIX + w`        --> Abre una ventana con las sesiones y ventanas abiertas
    * `t` --> Selecciona
    * `X` --> Kill
* `PREFIX + :swap-window -t 1` --> Intercambia la ventana actual con la ventana 1

## SESIONES
* `PREFIX + :new`                 --> Crea nueva sesión
* `PREFIX + :new -s nombreSesion` --> Crea nueva sesión con nombre

* `PREFIX + s`        --> Lista de sesiones
    * `t` --> Selecciona
    * `X` --> Kill
* `PREFIX + $`        --> Cambia el nombre de la sesión
* `PREFIX + (`        --> Cambia hacia la anterior sesión
* `PREFIX + )`        --> Cambia hacia la siguiente sesión
* `PREFIX + d`        --> Sale de la sesión (tmux detach)

## MODO COPIAR
* `PREFIX + [`        --> Permite hacer scroll por la terminal y copiar texto (Modo copiar)
    * `v`             --> Modo seleccionar
    * `Shift + v`     --> Modo seleccionar linea/s
    * `Ctrl + v`      --> Modo seleccionar región rectangular
    * `y`             --> Copiar
    * `Ctrl + c`      --> Sale del Modo Copiar
* `PREFIX + ]`        --> Pega lo copiado dentro del modo copiar
* `h/k/j/l`           --> Baja/Sube por la pantalla
* `K/J`               --> Baja/Sube por la pantalla con el cursor centrado
* `D/U`               --> Baja/Sube por la pantalla (media pantalla a la vez)
* `Ctrl + c`          --> Sale del modo copiar/scroll

## PANELES
* `PREFIX + V`        --> Crea un panel vertical
* `PREFIX + H`        --> Crea un panel horizontal
* `PREFIX + h`        --> Agranda el panel hacia la izquierda
* `PREFIX + j`        --> Agranda el panel hacia abajo
* `PREFIX + k`        --> Agranda el panel hacia arriba
* `PREFIX + l`        --> Agranda el panel hacia la derecha
* `PREFIX + x`        --> Cerrar panel
* `PREFIX + q`        --> Muestra el numero de panel
* `PREFIX + q + 2`    --> Mueve al panel 2
* `PREFIX + m`        --> Maximiza un panel
* `PREFIX + !`        --> Convierte el panel en ventana
* `PREFIX + {`        --> Mueve el panel hacia la izquierda
* `PREFIX + }`        --> Mueve el panel hacia la derecha
* `PREFIX + M`        --> Marca un panel para juntarlo en un futuro
* `PREFIX + J`        --> Junta un panel en una ventana
* `PREFIX + espacio`  --> Cambia de layout de los paneles

## Ayuda
* `PREFIX + ?`        --> Muestra ayuda de Tmux
