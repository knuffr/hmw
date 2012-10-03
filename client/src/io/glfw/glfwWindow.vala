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
using GLFW;
using GL;

namespace HMP {

	/**
	 * Klasse fuer ein mit GLFW erzeugtes Fenster 
	 */
	public class GLFWWindow {

		/** Breite des Fensters */
		int width = STATE.windowWidth;

		/** Hoehe des Fensters */
		int height = STATE.windowHeight;

		/** Bits des Rotbuffers */
		int redbits = 8;

		/** Bits des Gruenbuffers */
		int greenbits = 8;

		/** Bits des Gruenbuffers */
		int bluebits = 8;

		/** Bits des Alphabuffers */
		int alphabits = 8;

		/** Bits des Tiefenbuffers */
		int depthbits = 8;

		/** Bits des Stencilbuffers */
		int stencilbits = 0;

		/** Modus. GLFW_WINDOW oder GLFW_FULLSCREEN */
		GLFW.Mode mode = GLFW.Mode.WINDOW;

		/** Fenstertitel */
		string title = WINDOW_TITLE;

		/**
		 * Default-Konstruktor
		 * Erzeugt ein neues Fenster
		 */
		public GLFWWindow () throws Error 
		{
			init();
		}

		/**
		 * Initialisierung.
		 * Erzeugen des Fensters und setzen des Fenstertitels
		 */
		void init () throws Error 
		{
			/* Fenster oeffnen. GL_TRUE wenn success, sonst GL_FALSE */
			if ( !glfwOpenWindow (width, height,
			                      redbits, greenbits, bluebits, alphabits,
			                      depthbits, stencilbits, mode) )
				throw new Error (42, 42, "Could not create Window.");
			glfwSetWindowTitle (title);
		}

	}

}
