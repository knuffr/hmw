/* Copyright (C) 2012  Pascal Garber
 * Copyright (C) 2012  Ole Lorenzen
 * Copyright (C) 2012  Patrick König
 *
 * This software is free software; you can redistribute it and/or
 * modify it under the terms of the Creative Commons licenses CC BY-SA 3.0.
 * License as published by the Creative Commons organisation; either
 * version 3.0 of the License, or (at your option) any later version.
 * More informations on: http://creativecommons.org/licenses/by-sa/3.0/ 
 *
 * Author:
 *	Pascal Garber <pascal.garber@gmail.com>
 *	Ole Lorenzen <ole.lorenzen@gmx.net>
 *	Patrick König <knuffi@gmail.com>
 */

using HMP;

namespace HMP {

	GameState STATE;
	GameWorld WORLD;
	ResourceManager RESOURCES;

	/**
	 * Hauptklasse des Spielclients
	 */
	public class Game {

		/**
		 * Programmeinstiegsfunktion
		 * 
		 * @args Kommandozeilenparameter
		 * @return 0 wenn Erfolgreich, 1 im Fehlerfall.
		 */
		public static int main (string[] args) 
		{
			try {
				STATE = new GameState ();
				GLFWIOHandler io = new GLFWIOHandler ();
				/* Resourcen erst laden wenn GL-context da ist!11... */
				RESOURCES = new ResourceManager ();
				WORLD = new GameWorld ();
				WORLD.mapMan.addFromTSX ("data/map/testmap.tmx");
				WORLD.mapCurrent = WORLD.mapMan.maps.get("data/map/testmap.tmx");
				print ("map geladen\n");
				io.mainLoop();
			} catch (Error e) {
				print(e.message + "\n");
			}

			return 0;
		}
	}
}
