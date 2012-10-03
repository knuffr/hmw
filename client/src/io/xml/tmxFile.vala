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
using Xml;

namespace HMP {

	/**
	 * Klasse zum laden von Kartendaten im TMX-Format.
	 */
	public class TMXFile : XMLFile {

		/**
		 * Konstruktor
		 *
		 * @param filename Dateiname der Mapdatei
		 */
		public TMXFile (string filename) throws GLib.Error 
		{
			base (filename);
		}

		/**
		 * Liefert den Versionsstring der Mapdatei
		 *
		 * @return Version der Map
		 */
		public string getVersion ()
		{
			return getValueString ("/map/@version");
		}

		/**
		 * Liefert das der Map zugehoerige Tileset (pfad zur tsx-Datei,
		 * relativ zum Pfad der Map-Datei)
		 *
		 * @return Verwendetes Tileset
		 */
		public string getTileset ()
		{
			return getValueString ("/map/tileset/@source");
		}

		/**
		 * Liefert die Breite der Map (in Tiles)
		 *
		 * @return Breite der Map
		 */
		public int getWidth ()
		{
			return getValueInt ("/map/@width");
		}

		/**
		 * Liefert die Hoehe der Map (in Tiles)
		 *
		 * @return Hoehe der Map
		 */
		public int getHeight ()
		{
			return getValueInt ("/map/@height");
		}

		/**
		 * Liefert die Tilebreite der Map
		 *
		 * @return Tilebreite
		 */
		public int getTileWidth ()
		{
			return getValueInt ("/map/@tilewidth");
		}

		/**
		 * Liefert die Tilehoehe der Map
		 *
		 * @return Tilehoehe
		 */
		public int getTileHeight ()
		{
			return getValueInt ("/map/@tileheight");
		}

		/**
		 * Liefert die Anzahl der Layer
		 *
		 * @return Anzahl der Layer der Map
		 */
		public int getLayerCount ()
		{
			return evalExpressionCount ("/map/layer");
		}

		/**
		 * Liefert die Ausrichtung des Layers
		 * (unter, ueber Charakter, Kollisionslayer)
		 *
		 * @param i index des Layers
		 * @return Ausrichtung des Layers
		 */
		public string getLayerAlign (int i)
		{
			return getValueString ("/map/layer["+i.to_string()+"]/properties/property[@name='drawlayer']/@value");
		}

		/**
		 * Liefert den Namen eines Layers
		 *
		 * @param i index des Layers
		 * @return Name von Layer i
		 */
		public string getLayerName (int i)
		{
			return getValueString ("/map/layer["+i.to_string()+"]/@name");
		}

		/**
		 * Liefert die Breite eines Layers in Tiles
		 *
		 * @param i index des Layers
		 * @return Breite des Layers
		 */
		public int getLayerWidth (int i)
		{
			return getValueInt ("/map/layer["+i.to_string()+"]/@width");
		}

		/**
		 * Liefert die Hoehe eines Layers in Tiles
		 *
		 * @param i index des Layers
		 * @return Hoehe des Layers
		 */
		public int getLayerHeight (int i)
		{
			return getValueInt ("/map/layer["+i.to_string()+"]/@height");
		}

		/**
		 * Liefert die Tiledaten eines Layers
		 *
		 * @param i Index des Layers
		 * @return Integerarray mit den Tiledaten des Layers
		 */
		public int[] getLayerTiles (int i)
		{
			XPath.NodeSet* nodes = evalExpressionMulti ("/map/layer["+i.to_string()+"]/data/tile/@gid");

			int[] result = new int[nodes->length()];

			for (i = 0; i < nodes->length(); ++i)
				result[i] = int.parse(nodes->item(i)->get_content());

			return result;
		}

	}

}
