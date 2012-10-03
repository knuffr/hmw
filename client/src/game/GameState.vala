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

	/**
	 * Klasse fuer den Spielzustand.
	 */
	public class GameState {

		/** Spiel (Event- und Zeichenschleife) laeuft. */
		public bool running = false;

		/** Pausenflag */
		public bool paused = false;

		/** Debugmodus-Flag */
		public bool debug = false;

		/** Flag, ob sich die Fenstergroesse seit dem letzten Frame geaendert hat. */
		public bool windowHasChanged = true;

		/** Fensterbreite */
		public int windowWidth = WINDOW_DEFAULT_WIDTH;

		/** Fensterhoehe */
		public int windowHeight = WINDOW_DEFAULT_HEIGHT;

		/**
		 * Schaltet den Pausenmodus um
		 */
		public void toggle_paused() 
		{
			paused = !paused;
		}

		/**
		 * Schaltet den Debugmodus um
		 */
		public void toggle_debug() 
		{
			debug = !debug;
		}
	}
}
