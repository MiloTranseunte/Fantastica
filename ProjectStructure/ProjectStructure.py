# Listado de Escenas y sus dependencias
# Para Video Juego Fantástica Adventure
# Primer Template 11/05/2019

# Modificaciones 12/05/2019 7:20 pm


# Carpeta directorio principal con las escenas de los niveles, 
# donde tendrán las siguientes dependencias


# Cambiar estilo de estructura de esta parte de las entidades ya que no corresponde a 
# los datos de la estructura del proyecto sino a los nodos en "built-in" en Godot

NODO_GODOT Universo():
	SubCarpeta World_x():
		Player_x.tscn				# Escena del Jugador o jugadores
		Tilemap_x					# Basado en un Tilemap.tscn y un .tres
		Token_nextWorld_x			# Token Area2D con export variable File, str con dir de la escena siguiente
		Enemy_x.enemyType.tscn		# Escena con Nodo de enemigos. O puede ser una carpeta de enemigos con carpeta por enemigo
		Item_x.tscn					# Escena de Item/s
		PowerUps_x.tscn				# Escena con Tokens powerUps (could be as an item)

	
# Carpeta de las entidades tipo caracter que comparten comportamientos
CARPETA Entities():
	CARPETA Player(Player_x):				
		Player.tscn
		Player.gd
		x_Player.png				

	CARPETA Enemies(Enemy_x):
		x_enemy.tscn
		x_enemy.gd
		x_enemy.png
		
	Entity.tscn						# main scene of a generic Entity
	Entity.gd						# It's generic script

CARPETA Items():
	GenericItem.tscn				# main scene of a generic item
	GenericItem.gd					# script of the generic item
	SubCarpeta x_item():			# each instance of a particular item
		x_item.tscn					# With its propierty nodes attached on it
		x_item.gd					# gd script of the particular item
		Sprite/ AnimatedSprite

CARPETA Weapons():
	genericWeapon.tscn
	genericWeapon.gd
	SUBCARPETA x_weapon():
		x_weapon.tscn
		x_weapon.gd
		Sprite / AnimatedSprite

CARPETA Powers():
	genericPower.tscn
	genericWeapon.gd
	SUBCARPETA x_power() # Could Bullet, Fireball, Freeze, etc
		x_power.tscn
		x_power.gd
		Sprite / AnimatedSprite

CARPETA WORLDS():
	
	# Carpeta donde se alojan los mundos y lo necesario y único para su funcionamiento
	
	CARPETA World_x(main):
		SUBCARPETA Tilemap():
			Tilemap_x.tscn
			Tilemap_x.tres	
			parallaxbackground.tres

			# Carpeta donde se aloja la escena del Token_nextWorld			

			SUBCARPETA TokenNextWorld(Token_nextWorld): # Area2D, token to nextWorld
				TokenNextWorld.tscn
				TokenNextWorld.gd:

CARPETA HUD():
	SUBCARPETA Player_Interface():
		
	SUBCARPETA Main_Menu():
	
	SUBCARPETA Pause_Menu():
	
	SUBCARPETA Contextual_Menu():