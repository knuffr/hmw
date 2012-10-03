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
	 * Klasse fuer den Layer einer Map
	 */
	public class MapLayer 
	{
		/** Name des Layers */
		public string name;
		/** Breite des Layers in Tiles */
		public int width;
		/** Hoehe des Layers in Tiles */
		public int height;
		/** Tiledaten */
		public int[] tiles;

		/**
		 * Default-Konstruktor
		 *
		 * @param name Name des Maplayers
		 * @param width Breite des Layers in Tiles
		 * @param height Hoehe des Layers in Tiles
		 * @param tiles Integerarray mit den Tile-IDs
		 */
		public MapLayer (string name, int width, int height, int[] tiles)
		{
			this.name = name;
			this.width = width;
			this.height = height;
			this.tiles = tiles;
		}

		/**
		 * Hilfsfunktion
		 * Liefert die Tiledaten an den jeweiligen x- und y-Tilekoordinaten
		 *
		 * @param x Tilekoordinate in x
		 * @param y Tilekoordinate in y
		 * @return Tiledaten an Koordinate (x,y)
		 */
		public int at (int x, int y)
		{
			return tiles[y*width+x];
		}
	}

}
