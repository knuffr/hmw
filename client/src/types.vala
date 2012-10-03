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

	/* Einfache Typen */

	/** Bewegungsrichtung */
	public enum Direction {
		/** Nach oben */
		UP = 0,
		/** Nach unten */
		DOWN = 1,
		/** Nach links */
		LEFT = 2, 
		/** Nach rechts */
		RIGHT = 3
	}

	/** 2d-Positionskoordinaten */
	public class Position2d {
		/** x-Koordinate */
		public double x = 0;
		/** y-Koordinate */
		public double y = 0;
	}

}
