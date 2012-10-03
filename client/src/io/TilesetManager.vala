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
using Gee;

namespace HMP {

	public class TilesetManager {

		/** Map von Filename auf Tileset */
		public Gee.Map<string, Tileset> tilesets;

		/**
		 * Default-Konstruktor fuer den Tilesetmanager
		 */
		public TilesetManager ()
		{
			tilesets = new Gee.HashMap<string, Tileset>();
		}

		
		/**
		 * Laedt ein neues Tileset, falls dieses noch nicht geladen
		 * wurde.
		 *
		 * @param filename Dateiname der TSX-Datei des Tilesets
		 */
		public void addFromTSXIfNotExists (string filename) throws Error
		{
			if (!tilesets.has_key(filename))
				addFromTSX (filename);
		}

		/**
		 * Laedt ein neues Tileset aus einer TSX-Datei
		 * und fuegt dieses dem Tilesetmanager hinzu.
		 *
		 * @param filename Dateiname der zu ladenden TSX-Datei
		 */
		private void addFromTSX (string filename) throws Error
		{
			tilesets.set (filename, new Tileset (filename));
		}

	}

}
