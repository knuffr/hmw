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
	 * Allgemeine Entityklasse.
	 * hiervon erben Spieler, NPCs und andere Dynamische Objekte.
	 */
	public abstract class Entity {

		/** Schrittweite pro Sekunde in Tiles */
		public double speed = 7.5;

		/** Name der Entitaet */
		public string name;

		/** Bewegung der Entitaet */
		public bool[] movement = new bool[4];

		/** Position der Entitaet */
		public Position2d pos = new Position2d();

		/** Groesse der Entitaet in Pixeln (vorerst mal eine Kantenlaenge fuer Quadratisch.)*/
		public int size = 16;

		/**
		 * Defaultkonstruktor
		 */
		public Entity () 
		{
			movement[Direction.UP] = false;
			movement[Direction.DOWN] = false;
			movement[Direction.LEFT] = false;
			movement[Direction.RIGHT] = false;
		}

		/**
		 * Setzt die Bewegung der Entitaet
		 *
		 * @param dir Richtung der Bewegung
		 * @param val Wert (true: bewegen, false: stillstand)
		 */
		public void setMotion (Direction dir, bool val)
		{
			movement[dir] = val;
		}

		/**
		 * Prueft auf Kollision mit der Mapbegrenzung (und vermeidet bzw korrigiert diese)
		 *
		 * @param m Karte mit der auf Kollison geprueft werden soll
		 */
		private void moveCollideMap (Map m)
		{
			if (pos.x < 0)
				pos.x = 0;
			if (pos.y < 0)
				pos.y = 0;
			if (pos.x > m.width - 1)
				pos.x = m.width - 1;
			if (pos.y > m.height - 1)
				pos.y = m.height - 1;
		}

		/**
		 * Fuehrt Bewegung ueber interval Sekunden durch
		 *
		 * @param interval Bewegungsintervall in Sekunden
		 */
		public void move (double interval)
		{
			if (movement[Direction.UP]) {
				pos.y -= speed * interval;
			}
			if (movement[Direction.DOWN]) {
				pos.y += speed * interval;
			}
			if (movement[Direction.LEFT]) {
				pos.x -= speed * interval;
			}
			if (movement[Direction.RIGHT]) {
				pos.x += speed * interval;
			}
			moveCollideMap (WORLD.mapCurrent);
		}

	}

}
