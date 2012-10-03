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
	 * Klasse fuer das Auslesen von Tileset-XML Dateien
	 */
	public class TSXFile : XMLFile {

		/**
		 * Konstuktor
		 * Erzeugen des XML-Dokumentbaums
		 */
		public TSXFile (string path) throws GLib.Error {
			base (path);
		}

		/**
		 * Ermittelt den Tilesetnamen aus dem XML-Dokument.
		 *
		 * @return Name des Tilesets
		 */
		public string getName () {
			return getValueString("/tileset/@name");
		}

		/**
		 * Ermittelt die Tile-Breite des Tilesets aus dem
		 * XML-Dokument.
		 *
		 * @return Breite der Tiles des Tilesets
		 */
		public int getTileWidth () {
			return getValueInt("/tileset/@tilewidth");
		}

		/**
		 * Ermittelt die Tile-Hoehe des Tilesets aus dem
		 * XML-Dokument.
		 *
		 * @return Hoehe der Tiles des Tilesets
		 */
		public int getTileHeight () {
			return getValueInt("/tileset/@tileheight");
		}

		/**
		 * Ermittelt den Quelldateinamen des Bildes des
		 * Tilesets aus dem XML-Dokument.
		 *
		 * @return Quelldateiname des Tilesetbildes
		 */
		public string getSource () {
			return getValueString("/tileset/image/@source");
		}

		/**
		 * Ermittelt irgendwas des Tilesetbildes aus dem
		 * XML-Dokument.
		 *
		 * @return irgendwas des Tilesetbildes
		 */
		public string getTrans () {
			return getValueString("/tileset/image/@trans");
		}

		/**
		 * Ermittelt die Gesamtbreite des Tilesetbildes aus dem
		 * XML-Dokument.
		 *
		 * @return Gesamtbreite des Tilesetbildes
		 */
		public int getWidth () {
			return getValueInt("/tileset/image/@width");
		}

		/**
		 * Ermittelt die Gesamthoehe des Tilesetbildes aus dem
		 * XML-Dokument.
		 *
		 * @return die Gesamthoehe des Tilesetbildes
		 */
		public int getHeight () {
			return getValueInt("/tileset/image/@height");
		}

	}
}
