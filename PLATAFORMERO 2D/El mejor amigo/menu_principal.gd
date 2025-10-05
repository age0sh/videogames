extends Control

# Esta función se conectará al botón "Jugar"
func _on_boton_jugar_pressed():
	# ¡IMPORTANTE! Cambia "res://nivel_1.tscn" a la ruta de tu escena de juego.
	get_tree().change_scene_to_file("res://nivel.tscn")

# Esta función se conectará al botón "Salir"
func _on_boton_salir_pressed():
	get_tree().quit() # Cierra el juego


# Se ejecuta al presionar el botón "Opciones".
func _on_boton_opciones_pressed():
	# Oculta los botones del menú principal.
	$MainMenuButtons.visible = false
	# Muestra el panel del menú de opciones.
	$OptionsMenu.visible = true

	# Actualiza la posición del slider para que refleje el volumen actual.
	var current_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	$OptionsMenu/VBoxContainer/VolumeSlider.value = current_volume


# --- SEÑALES DEL PANEL DE OPCIONES ---

# Se ejecuta al presionar el botón "Volver" dentro de las opciones.
func _on_back_button_pressed():
	# Oculta el panel de opciones.
	$OptionsMenu.visible = false
	# Vuelve a mostrar los botones del menú principal.
	$MainMenuButtons.visible = true

# Se ejecuta cada vez que el valor del slider de volumen cambia.
func _on_volume_slider_value_changed(value):
	# Llama a la función global en nuestro Autoload "SoundManager" para
	# cambiar el volumen de todo el juego.
	SoundManager.set_master_volume(value)
