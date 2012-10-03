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
	 * Hauptklasse fuer die IO mit glfw
	 */
	public class GLFWIOHandler {

		/** Fenster */
		public static GLFWWindow win;

		/** Video-Outputklasse */
		public static GLFWVideo video;

		/** Input-Klasse */
		public static GLFWInput input;

		/**
		 * Default-Konstruktor
		 * Initialisiert die Gesamte GLFW-io
		 */
		public GLFWIOHandler () throws Error 
		{
			init();
		}

		/**
		 * Hauptschleife des Spiels.
		 * Logik, IO pollen, zeichnen. repeat. 
		 */
		public void mainLoop () 
		{
			STATE.running = true;

			long fpsTimer = (long) time_t ();
			int fps = 0;
			double timer = glfwGetTime ();

			while (STATE.running) {
				/* Hier Logik */
				double newTime = glfwGetTime ();
				double difTime = newTime - timer;
				timer = newTime;
				WORLD.tick (difTime);
				/* Viewport und Projektion neu setzen, falls neue Fenstergroesse */
				if (STATE.windowHasChanged) {
					video.setViewport();
					video.setProjection();
					STATE.windowHasChanged = false;
				}
				/* Zeichnen */
				video.draw();
				/* Buffer swappen. Defaultmaessig ruft glfw hier auch automatisch PollEvents auf! */
				glfwSwapBuffers();
				/* fps zaehlen und ausgeben, wenn sekunde vergangen */
				++fps;
				if ((long) time_t () - fpsTimer >= 1) {
					print ("fps: %d\n", fps);
					fpsTimer = time_t ();
					fps = 0;
				}
			}
		}

		/**
		 * Initialisierung des GLFW-Renderings und Inputs.
		 */
		private void init () throws Error 
		{
			if ( !glfwInit() )
				throw new Error(42, 42, "Could not initialize GLFW!");

			win = new GLFWWindow ();
			video = new GLFWVideo ();
			input = new GLFWInput ();
		}



	}

}
