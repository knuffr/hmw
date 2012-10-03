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
	 * Klasse fuer Videooutput mit GLFW.
	 */
	public class GLFWVideo {

		/** Renderer des Videomoduls */
		public GLFWRenderer renderer;

		/**
		 * Default-Konstruktor
		 * Initialisiert wichtige OpenGL-Optionen, setzt Viewport 
		 * und Projektion und erzeugt einen Renderer.
		 */
		public GLFWVideo ()
		{
			init ();
			setViewport ();
			setProjection ();
			renderer = new GLFWRenderer();
		}

		/**
		 * Setzt den Viewport neu anhand der Fenstergroesse
		 * (Viewport bedeckt volle Fenstergroesse)
		 */
		public void setViewport () 
		{
			int w, h;
			glfwGetWindowSize (out w, out h);
			glViewport (0, 0, w, h);
		}

		/**
		 * Setzt die Projektion neu anhand der Fenstergroesse
		 * (Orthogonale Projektion von 0 bis Breite bzw Hoehe)
		 */
		public void setProjection () 
		{
			int w, h;
			glfwGetWindowSize (out w, out h);
			glMatrixMode (GL_PROJECTION);
			glLoadIdentity ();
			glOrtho (0, w, 0, h, -42, 42);
		}

		/**
		 * Zeichnen eines Frames 
		 */
		public void draw () 
		{
			/* Buffer leeren */
			glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
			/* Modelviewmodus und zuruecksetzen */
			glMatrixMode (GL_MODELVIEW);
			glLoadIdentity ();
			/* Zeichnen der Welt */
			renderer.drawAll ();
		}

		/**
		 * Initialisierung wichtiger OpenGL-Einstellungen
		 */
		public bool init () 
		{
			/* Hintergrundfarbe setzen */
			glClearColor (0.0f, 0.0f, 0.0f, 1.0f);

			/* Zeichenfarbe */
			glColor3f (1.0f, 1.0f, 1.0f);

			/* Vorderseite ist CCW */
			glFrontFace (GL_CCW);

			/* Poligonrueckseitenculling */
			glEnable (GL_CULL_FACE);
			glCullFace (GL_BACK);

			/* Texturierung an */
			glEnable (GL_TEXTURE_2D);

			/* Alphakanal an */
			glEnable (GL_ALPHA_TEST);
			glAlphaFunc (GL_GREATER, (GL.GLclampf) 0.1);

			/* Blending an */
			glEnable (GL_BLEND);

			return (glGetError() == GL_NO_ERROR);
		}
	}

}
