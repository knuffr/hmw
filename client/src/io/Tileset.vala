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
using Cairo;
using GL;
using GLU;

namespace HMP {

	public class Tileset {

		/** Tilesetname */
		public string name;

		/** Tilebreite */
		public int tileWidth;

		/** Tilehoehe */
		public int tileHeight;

		/** Quellbild */
		public string srcPath;

		/** Breite des Quellbildes */
		public int srcWidth;

		/** Hoehe des Quellbildes */
		public int srcHeight;

		/** Bilddaten des Tilesets */
		public ImageSurface img;

		/** Textur-ID des Tilesets */
		public GLuint texID;

		/**
		 * Default-Konstruktor fuer ein Tileset
		 *
		 * @param filename Dateiname der zugehoerigen TSX-Datei
		 */
		public Tileset (string filename) throws Error
		{
			loadTSXMetadata (filename);
			loadPNGImagedata (srcPath);
			loadOpenGLTexture ();
		}


		/**
		 * Laedt die Metadaten aus der TSX-Datei
		 *
		 * @param filename Dateiname der TSX-Datei
		 */
		private void loadTSXMetadata (string filename) throws Error
		{
			TSXFile file = new TSXFile (filename);
			this.name = file.getName();
			this.tileWidth = file.getTileWidth();
			this.tileHeight = file.getTileHeight();
			/* Uebernehme Pfad aus tsx */
			this.srcPath = filename.substring(0, filename.last_index_of("/")+1).concat(file.getSource());
			this.srcWidth = file.getWidth();
			this.srcHeight = file.getHeight();
		}

		/**
		 * Laedt die Bilddaten aus einer PNG-Datei
		 *
		 * @param filename Dateiname der PNG-Datei
		 */
		private void loadPNGImagedata (string filename) 
		{
			img = new ImageSurface.from_png (filename);
		}

		/**
		 * Laedt das Tileset in den Texturspeicher.
		 */
		private void loadOpenGLTexture ()
		{
			glGenTextures (1, &texID);
			glBindTexture (GL_TEXTURE_2D, texID);

			/* 1 Byte in der Textur meint eine Komponente */
			glPixelStorei (GL_UNPACK_ALIGNMENT, 1);

			/* Keine Texturwiederholung ausserhalb der Texelkoordinaten [0,1] */
			glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP);
			glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP);

			/* Nearest Neighbor interpolation um nicht zu entpixeln. */
			glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
			glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

			glTexImage2D (GL_TEXTURE_2D, 0, GL_RGBA, (GLsizei) srcWidth, (GLsizei) srcHeight, 0, GL_BGRA, GL_UNSIGNED_BYTE, img.get_data());
		}

		/**
		 * Bindet an dieses Tileset als Textur
		 */
		public void bindTexture ()
		{
			glBindTexture (GL_TEXTURE_2D, texID);
		}

	}

}
