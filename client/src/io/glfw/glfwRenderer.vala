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
using GL;
using GLU;

namespace HMP {

	/**
	 * Renderer zum Zeichnen von Objekten
	 */
	public class GLFWRenderer {

		/** Map ist aufwendig und lange statisch und sollte daher als Displayliste realisiert werden. (hier etwa +50% fps.) */
		public GLuint displayListMap = 0;

		/**
		 * Zeichnet ein Tile in den Ursprung
		 *
		 * @param tile index der tile in dem Tileset
		 * @param ts Tileset aus dem das Tile stammt
		 */
		private void drawTile (int tile, Tileset ts) 
		{
			int tilesPerLine = (ts.srcWidth / ts.tileWidth);
			int tilesPerColumn = (ts.srcHeight / ts.tileHeight);

			int tileXid = (tile - 1) % tilesPerLine; // mingid.
			int tileYid = (tile - 1) / tilesPerLine;

			/* Texturkoordinaten des Tiles ermitteln */
			double tileXmin = ((double) tileXid) / tilesPerLine;
			double tileXmax = ((double) tileXid+1) / tilesPerLine;
			double tileYmin = ((double) tileYid) / tilesPerColumn;
			double tileYmax = ((double) tileYid+1) / tilesPerColumn;

			/* Tile zeichnen */
			glBegin (GL_QUADS);
				glTexCoord2d (tileXmax, tileYmin);
				glVertex2d (ts.tileWidth, 0);
				glTexCoord2d (tileXmin, tileYmin);
				glVertex2d (0, 0);
				glTexCoord2d (tileXmin, tileYmax);
				glVertex2d (0, -ts.tileHeight);
				glTexCoord2d (tileXmax, tileYmax);
				glVertex2d (ts.tileWidth, -ts.tileHeight);
			glEnd ();
		}

		/**
		 * Zeichnet einen Layer einer Map
		 *
		 * @param l Layer
		 * @param ts tileset fuer den Layer
		 */
		private void drawMapLayer (MapLayer l, Tileset ts)
		{
			glPushMatrix ();
			for (int x = 0; x < l.width; ++x) {
				glPushMatrix ();
				for (int y = 0; y < l.height; ++y) {
					int tile = l.at (x, y);
					if (tile != 0)
						drawTile (tile, ts);
					glTranslated (0, -ts.tileHeight, 0);
				}
				glPopMatrix ();
				glTranslated (ts.tileWidth, 0, 0);
			}
			glPopMatrix ();
		}

		/**
		 * Zeichnet (den statischen Teil) einer Map
		 *
		 * @param m die zu zeichnende Map
		 */
		private void drawMap (Map m) 
		{
			/* Tilesettextur binden */
			Tileset ts = RESOURCES.tilesetMan.tilesets.get (m.tileset);
			ts.bindTexture ();

			/* Layer durchgehen und zeichnen */
			glPushMatrix ();
			foreach (MapLayer l in m.layer_under) {
				glTranslated (0, 0, -1);
				drawMapLayer (l, ts);
			}
			glPopMatrix ();
			foreach (MapLayer l in m.layer_same) {
				drawMapLayer (l, ts);
			}
			glPushMatrix ();
			foreach (MapLayer l in m.layer_over) {
				glTranslated (0, 0, 1);
				drawMapLayer (l, ts);
			}
			glPopMatrix ();
		}

		/**
		 * Zeichnet einen Spieler
		 *
		 * @param p Spielerentitaet
		 */
		private void drawPlayer (Player p)
		{
			Map m = WORLD.mapCurrent;
			glPushMatrix();
			/* Spieler zentriert ... */
			glTranslated (STATE.windowWidth / 2, STATE.windowHeight / 2, 0);
			/* ... es sei denn, er ist in Randbereichen (bzw. auf einer kleinen Map.) */
			if (p.pos.y * m.tileHeight < (STATE.windowHeight - p.size) / 2)                             // oben angestossen
				glTranslated (0, (STATE.windowHeight - p.size) / 2 - p.pos.y * m.tileHeight, 0);
			if (p.pos.x * m.tileWidth < (STATE.windowWidth - p.size) / 2)                               // links angestossen
				glTranslated (p.pos.x * m.tileWidth - (STATE.windowWidth - p.size) / 2, 0, 0);
			if (p.pos.y * m.tileHeight > m.height * m.tileHeight - (STATE.windowHeight + p.size) / 2)   // unten angestossen
				glTranslated (0, m.height * m.tileHeight - (STATE.windowHeight + p.size) / 2 - p.pos.y * m.tileHeight, 0);
			if (p.pos.x * m.tileWidth > m.width * m.tileWidth - (STATE.windowWidth + p.size) / 2)       // rechts angestossen
				glTranslated (p.pos.x * m.tileWidth - (m.width * m.tileWidth - (STATE.windowWidth + p.size) / 2), 0, 0);
			/* Hier muss dann auch eigentlich eher n Bildchen gezeichnet werden.. :) */
			glDisable (GL_TEXTURE_2D);
			Quadric q = new Quadric ();
			q.Disk (0, p.size/2, 10, 1);
			glEnable (GL_TEXTURE_2D);
			glPopMatrix();
		}

		/**
		 * Zeichnet die Map korrekt positioniert.
		 * Spieler bzw. Map sind je nach Situation so zentriert, dass
		 * der Platz optimal fuer die Map genutzt wird, aber der Spieler
		 * wenn möglich in den Mittelpunkt gerueckt wird.
		 */
		private void drawMapPositioned () 
		{
			Player p = WORLD.player;
			Map m = WORLD.mapCurrent;
			glPushMatrix();
			/* Tile mit dem Spieler ins Zentrum schieben */
			glTranslated (STATE.windowWidth / 2 - m.tileWidth / 2 - p.pos.x * m.tileWidth, 
			              STATE.windowHeight / 2 + m.tileHeight / 2 + p.pos.y * m.tileHeight, 0);
			/* Nachkorrigieren wenn Spieler in Randbereichen */
			if (p.pos.y * m.tileHeight < (STATE.windowHeight - p.size) / 2)                             // oben angestossen
				glTranslated (0, (STATE.windowHeight - p.size) / 2 - p.pos.y * m.tileHeight, 0);
			if (p.pos.x * m.tileWidth < (STATE.windowWidth - p.size) / 2)                               // links angestossen
				glTranslated (p.pos.x * m.tileWidth - (STATE.windowWidth - p.size) / 2, 0, 0);
			if (p.pos.y * m.tileHeight > m.height * m.tileHeight - (STATE.windowHeight + p.size) / 2)   // unten angestossen
				glTranslated (0, m.height * m.tileHeight - (STATE.windowHeight + p.size) / 2 - p.pos.y * m.tileHeight, 0);
			if (p.pos.x * m.tileWidth > m.width * m.tileWidth - (STATE.windowWidth + p.size) / 2)       // rechts angestossen
				glTranslated (p.pos.x * m.tileWidth - (m.width * m.tileWidth - (STATE.windowWidth + p.size) / 2), 0, 0);
			/* Map-Displayliste erzeugen, falls noch nicht da. Muss bei Mapwechel dann immer neu erzeugt werden. */
			if (displayListMap == 0) {
				displayListMap = glGenLists(1);
				glNewList (displayListMap, GL_COMPILE_AND_EXECUTE);
				drawMap (m);
				glEndList ();
			/* Map-Displayliste zeichnen, falls schon da */
			} else {
				glCallList (displayListMap);
			}
			glPopMatrix();
		}

		/**
		 * Zeichnen eines gesamten Frames
		 * Player soll zentriert, solange man nicht am Rand wandert...
		 */
		public void drawAll () 
		{
			drawMapPositioned ();
			drawPlayer (WORLD.player);
			/* Entities zeichnen, Menue/HUD zeichnen, ... */
		}
	}

}
