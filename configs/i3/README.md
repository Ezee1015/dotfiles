# I3

## CheatSheet (in Spanish)

> MOD --> Alt
> SMOD --> Super

### Ventanas

|            Atajo            | Función                                                                                   |
|:---------------------------:|-------------------------------------------------------------------------------------------|
|      **`MOD + [hjkl]`**     | Seleccionar la ventana de la izquierda, abajo, arriba o derecha                           |
|  **`MOD + Shift + [hjkl]`** | Mover la ventana a la izquierda, abajo, arriba o derecha                                  |
|       **`MOD + Tab`**       | Seleccionar la ventana de la derecha                                                      |
|   **`MOD + Shift + Tab`**   | Seleccionar la ventana de la izquierda                                                    |
|        **`MOD + r`**        | Cambia el tamaño de las ventanas. Se puede usar [hjkl] para mover                         |
|        **`MOD + f`**        | Convierte la ventana en *fullscreen*. Presione de vuelta para volver a la normalidad      |
|        **`MOD + v`**        | Indica que la próxima ventana se creará verticalmente                                     |
|    **`MOD + Shift + v`**    | Especifica que se crea una ventana de manera horizontal                                   |
|        **`MOD + s`**        | *Stack* (apila) toda las ventanas                                                         |
|        **`MOD + w`**        | Convierte las ventanas en *Tabs*                                                          |
|        **`MOD + e`**        | Vuelve al modo *Tiling*                                                                   |
| **`Mod + Shift + Espacio`** | Convierte una ventana tiling en flotante y viceversa                                      |
|     **`Mod + Espacio`**     | Permite navegar por ventanas flotante, y si se presiona de vuelta, vuelve al modo tailing |
|        **`Mod + a`**        | Selecciona el grupo de ventanas al que forma parte la ventana seleccionada actualmente    |
|    **`Mod + Shift + a`**    | Selecciona la ventana "hija" del grupo de ventanas seleccionado                           |

### Espacios de Trabajo

|                Atajo                | Función                                                      |
|:-----------------------------------:|--------------------------------------------------------------|
|     **`MOD + [01234567890]`**     | Va al espacio de trabajo seleccionado                        |
| **`MOD + Shift + [01234567890]`** | Mueve la ventana seleccionada al espacio de trabajo indicado |

### Layout

|     Atajo     | Función                                      |
|:-------------:|----------------------------------------------|
| **`MOD + e`** | Modo layout: Tiling                          |
| **`MOD + s`** | Modo layout: Pila de ventanas (superpuestos) |
| **`MOD + w`** | Modo layout: en Tabs                         |

### Integrado

|         Atajo         | Función                                      |
|:---------------------:|----------------------------------------------|
| **`MOD + Shift + c`** | Recargar I3                                  |
| **`MOD + Shift + r`** | Reiniciar I3                                 |
| **`MOD + Shift + e`** | Salir de I3                                  |
|   **`MOD + Enter`**   | Abrir terminal (Alacritty)                   |

### Dunst (notificaciones)

|                Atajo                | Función                                                         |
|:-----------------------------------:|-----------------------------------------------------------------|
|       **`Control + Espacio`**       | Cierra la notificación                                          |
|   **`Control + Shift + Espacio`**   | Cierra todas las notificaciones                                 |
|      **`Control + Shift + .`**      | Abre la última notificación                                     |
|          **`Control + .`**          | Abre el menú de acciones                                        |
|            **`MOD + n`**            | Habilita y Deshabilita (silencia y suspende) las notificaciones |
| **`Click - Mouse botón izquierdo`** | Abre el menú de acciones                                        |
|    **`Click - Rueda del mouse`**    | Ejecuta la accion por default                                   |
|  **`Click - Mouse botón derecho`**  | Cierra notificación                                             |

### Rofi

|         Atajo         | Función                                      |
|:---------------------:|----------------------------------------------|
|     **`MOD + d`**     | Abre `rofi` en busca de comandos de terminal |
| **`MOD + Shift + d`** | Abre `rofi` en busca de archivos .desktop    |
|     **`MOD + -`**     | Abre `rofi` en en modo calculadora           |
| **`MOD + Shift + f`** | Abre `rofi` en modo *file browser*           |

#### Atajos internos

|                                      Atajo                                     | Función                                                                          |
|:------------------------------------------------------------------------------:|----------------------------------------------------------------------------------|
| **`Control + [hl]`**, **`Shift + [Izquierda/Derecha]`**, **`Control + [Tab]`** | Cambia entre modos                                                               |
|             **`Control + [jk]`**, **`[Arriba/Abajo]`**, **`[Tab]`**            | Sube/baja entre los resultado                                                    |
|                              **`Shift + [Enter]`**                             | Permite seleccionar un archivo con el que abrir la aplicación (en modo run/drun) |

### Custom

|                Atajo                | Función                                   |
|:-----------------------------------:|-------------------------------------------|
|        **`MOD + Shift + x`**        | Bloquea la pantalla                       |
|            **`MOD + c`**            | Abre el historial del portapapeles        |
|          **`PrintScreen`**          | Screenshot de la pantalla enter           |
|      **`Shift + PrintScreen`**      | Screenshot de una región seleccionada     |
| **`Control + Shift + PrintScreen`** | Screenshot de la ventana activa           |
|     **`Control + PrintScreen`**     | Abre la carpeta ~/Imágenes                |
|        **`MOD + 0 (numpad)`**       | *Screen magnifier*                        |
|            **`MOD + z`**            | Abre ZoomMe                               |
|        **`MOD + Shift + z`**        | *Custom Screen magnifier* con feh y scrot |
|            **`MOD + b`**            | Abre los *bookmarks* de Firefox           |
|          **`MOD + Av Pag`**         | Sube el volumen                           |
|          **`MOD + Re Pag`**         | Baja el volumen                           |
|          **`MOD + Inicio`**         | Sube el brillo                            |
|           **`MOD + Fin`**           | Baja el brillo                            |
|           **`MOD + o`**           | Change the output (headphones-speaker)      |

## Para asociar una aplicación a un workspace:
1. Abrir la aplicación
2. Ejecutar `xprop`
3. Clickear la ventana
4. Copiar el valor XXX de la linea...
``
WM_CLASS(STRING) = "YYY", "XXX"
``
5. Poner en el config de i3: `assign [class="XXX"] $workspace10`

## Para cambiar la apariencia de las Apps Qt
> Cuando haga el cambio KDE a **Qt 6**, cambiar `qt5ct` a `qt6ct` en `/etc/enviroment` (Y actualizar cuando *setea* la variable en el Makefile. Por si las dudas, el makefile ya instala qt6ct)

1. Entrar en I3WM
2. Ejecutar `qt5ct` o `qt6ct`
3. Cambiar las configuraciones a gusto
4. Cerrar sesión
5. Iniciar en KDE Plasma
6. Repetir la configuración
7. Cerrar sesión e Iniciar en I3WM

## Dependencias incluidas en este repo (agradecimientos)
Fuentes:
- <https://invent.kde.org/plasma/ocean-sound-theme> (audios)
- <https://gitlab.manjaro.org/packages/community/i3/i3-scrot> (i3-scrot)
- <https://www.debian.org/logos/hexagonal.png>
