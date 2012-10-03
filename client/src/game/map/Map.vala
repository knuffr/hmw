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

	/**
	 * Klasse fuer eine Map.
	 */
	public class Map {
		/** Verwendetes Tileset */
		public string tileset;
		/** Name der Map */
		public string name;
		/** Version der Map */
		public string version;
		/** Breite der Map in Tiles */
		public int width;
		/** Hoehe der Map in Tiles */
		public int height;
		/** Breite der Tiles der Map */
		public int tileWidth;
		/** Hoehe der Tiles der Map */
		public int tileHeight;

		/** Layer unter dem Charakter */
		public Gee.List<MapLayer> layer_under;
		/** Gleicher Layer wie Char. Macht nicht wirklich Sinn. Durch einen "Kollisionslayer" tauschen ggf */
		public Gee.List<MapLayer> layer_same;
		/** Layer ueber dem Charakter */
		public Gee.List<MapLayer> layer_over;

		/**
		 * Default-Konstruktor.
		 * Liest eine Map aus einer TMX-Datei aus.
		 *
		 * @param filename Dateiname der TMX-Map.
		 */
		public Map (string filename) throws Error
		{
			loadFromTMX (filename);
		}

		/**
		 * Ermittelt die Mapdaten aus einer TMX-Datei
		 * mit Hilfe des TMX-Readers
		 *
		 * @param filename Dateiname der TMX-Map.
		 */
		private void loadFromTMX (string filename) throws Error
		{
			layer_over = new ArrayList<MapLayer>();
			layer_under = new ArrayList<MapLayer>();
			layer_same = new ArrayList<MapLayer>();
			/* Mapdaten laden */
			TMXFile tmx = new TMXFile (filename);
			this.tileset = tmx.getTileset();
			this.tileset = FOLDER_TILESET+tileset.substring(tileset.last_index_of("/")+1);
			this.name = filename;
			this.version = tmx.getVersion();
			this.width = tmx.getWidth();
			this.height = tmx.getHeight();
			this.tileWidth = tmx.getTileWidth();
			this.tileHeight = tmx.getTileHeight();

			/* Layerdaten laden */
			int layerCount = tmx.getLayerCount();

			for (int i = 1; i <= layerCount; ++i) 
			{
				int lwidth = tmx.getLayerWidth(i);
				int lheight = tmx.getLayerHeight(i);
				string lname = tmx.getLayerName(i);
				int[] ltiles = tmx.getLayerTiles(i);

				switch (tmx.getLayerAlign(i))
				{
					case "over":
						layer_over.add (new MapLayer (lname, lwidth, lheight, ltiles));
						break;
					case "under":
						layer_under.add (new MapLayer (lname, lwidth, lheight, ltiles));
						break;
					case "same":
						layer_same.add (new MapLayer (lname, lwidth, lheight, ltiles));
						break;
					default:
						print ("wat nein!\n");
						break;
				}
			}

			/* Zugehoeriges Tileset laden, falls noch nicht geladen */
			RESOURCES.tilesetMan.addFromTSXIfNotExists (tileset);
		}
	}

}
