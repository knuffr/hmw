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
	 * Input-Provider
	 */
	public class GLFWInput {

		public const int KEY_UP = 0x57; // W
		public const int KEY_DOWN = 0x53; // S
		public const int KEY_LEFT = 0x41; // A
		public const int KEY_RIGHT = 0x44; // D

		/**
		 * Defaultkonstruktor
		 */
		public GLFWInput () 
		{
			registerCallbacks ();
		}

		/**
		 * Callbacks Registrieren
		 */
		private void registerCallbacks () 
		{
			/* Fenster-Callbacks */
			glfwSetWindowCloseCallback(cbWindowClose);
			glfwSetWindowSizeCallback(cbWindowResize);
			glfwSetWindowRefreshCallback(cbWindowRefresh);

			/* Input-Callbacks */
			glfwSetKeyCallback(cbKey);
			glfwSetCharCallback(cbChar);
			glfwSetMouseButtonCallback(cbMouseButton);
			glfwSetMousePosCallback(cbMousePos);
			glfwSetMouseWheelCallback(cbMouseWheel);
		}

		/* ---- Fenster-Callbacks ---- */

		/**
		 * Callback fuer das Schliessen des Fensters
		 */
		public static bool cbWindowClose () 
		{
			print("cbFensterschluss\n");
			STATE.running = false;
			return true;
		}

		/** 
		 * Callback fuer das Aendern der Fenstergroesse
		 * 
		 * @param width neue Fensterbreite
		 * @param height neue Fensterhoehe
		 */
		public static void cbWindowResize (int width, int height) 
		{
			print("cbWindowResize\n");
			STATE.windowWidth = width;
			STATE.windowHeight = height;
			STATE.windowHasChanged = true;
		}

		/** 
		 * Callback fuer das refreshen des Fensterinhaltes
		 */
		public static void cbWindowRefresh () 
		{
			print("cbWindowRefresh\n");
		}

		/* ---- Input-Callbacks ---- */

		/**
		 * Callback fuer einen Tastendruck
		 * 
		 * @param key gedrueckte Taste
		 * @param action true wenn gedrueckt, false wenn losgelassen
		 */
		public static void cbKey (int key, bool action) 
		{
			/* press */
			if (action) {
				print ("cbKey %x pressed\n", key);
				switch (key) {
					case KEY_UP:
						WORLD.player.setMotion (Direction.UP, true);
						break;
					case KEY_DOWN:
						WORLD.player.setMotion (Direction.DOWN, true);
						break;
					case KEY_LEFT:
						WORLD.player.setMotion (Direction.LEFT, true);
						break;
					case KEY_RIGHT:
						WORLD.player.setMotion (Direction.RIGHT, true);
						break;
				}
			/* release */
			} else {
				print ("cbKey %x released\n", key);
				switch (key) {
					case KEY_UP:
						WORLD.player.setMotion (Direction.UP, false);
						break;
					case KEY_DOWN:
						WORLD.player.setMotion (Direction.DOWN, false);
						break;
					case KEY_LEFT:
						WORLD.player.setMotion (Direction.LEFT, false);
						break;
					case KEY_RIGHT:
						WORLD.player.setMotion (Direction.RIGHT, false);
						break;
					/* ESC: Beenden */
					case Key.ESC:
						STATE.running = false;
						break;
				}
			}
		}

		/**
		 * Zeichencallback (Erfolgt zwischen Tastendruck und loslassen)
		 * 
		 * @param c empfangenes Zeichen
		 * @param action
		 */
		public static void cbChar (int c, bool action) 
		{
			print("cbChar\n");
		}

		/**
		 * Callback fuer Mausbuttons
		 *
		 * @param button gedrueckter Button
		 * @param action true wenn gedrueckt, false wenn losgelassen
		 */
		public static void cbMouseButton (int button, bool action) 
		{
			print("cbMouseButton\n");
		}

		/**
		 * Callback fur Mauspositionsveraenderung im Fenster
		 *
		 * @param x Neue x-Mauskoordinate
		 * @param y Neue y-Mauskoordinate
		 */
		public static void cbMousePos (int x, int y) 
		{
			/*print("cbMousePos\n");*/
		}

		/**
		 * Callback fuer das Mausrad
		 *
		 * @param pos Neue Mausradposition
		 */
		public static void cbMouseWheel (int pos) 
		{
			print("cbMouseWheel\n");
		}
	}
}
