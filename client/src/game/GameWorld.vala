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
	 * Klasse zur Verwaltung der Spielweltdaten
	 */
	public class GameWorld {

		/** Map-Manager */
		public MapManager mapMan = new MapManager();

		/** Aktuelle Map */
		public Map mapCurrent;

		/** Spielerentitaet */
		public Player player = new Player();

		/**
		 * Zeitvoranschreitung auf Welt anwenden.
		 *
		 * @param interval Zeitinterval seit der letzten voranschreitung in Sekunden
		 */
		public void tick (double interval)
		{
			player.move (interval);
		}

	}

}
