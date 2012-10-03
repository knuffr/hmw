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

using Xml;
using Xml.XPath;
using HMP;

namespace HMP {

	/**
	 * Klasse fuer XML-Operationen
	 */
	public class XMLFile {

		protected static bool initialized = false;

		/**
		 * Hilsvariable mit Dateityp von libxml2, fuer weitere Informationen siehe
		 * [[http://xmlsoft.org/html/libxml-tree.html#xmlDoc|xmlsoft.org]]
		 * und [[http://valadoc.org/libxml-2.0/Xml.Doc.html|valadoc.org]]
		 */
		protected Xml.Doc* doc;

		/**
		 * Hilsvariable mit Dateityp von libxml2, fuer weitere Informationen siehe
		 * [[http://xmlsoft.org/html/libxml-xpath.html#xmlXPathContext|xmlsoft.org]]
		 * und [[http://valadoc.org/libxml-2.0/Xml.XPath.Context.html|valadoc.org]]
		 */
		protected Context ctx;

		/**
		 * Speichert den path der zu bearbeitenden Mapdatei
		 */
		string path;

		/**
		 * Konstruktor
		 */
		public XMLFile (string path) throws GLib.Error 
		{
			this.path = path;

			if (!initialized) {
				Parser.init();
				initialized = !initialized;
			}

			doc = Parser.parse_file (path);

			if (doc == null) 
				throw new GLib.Error (42, 42, "failed to parse XMLdoc");

			ctx = new Context(doc);

			if (ctx == null) 
				throw new GLib.Error (42, 42, "failed to create the xpath context for XMLdoc");
		}

		/**
		 * Hilsmethode fuer das Extrahieren eines Integerwertes mittels einer
		 * XPath-Expression.
		 *
		 * @param expression Auszufuehrende XPath-Expression
		 * @return Ergebnisinteger
		 */
		protected int getValueInt (string expression) 
		{
			return int.parse(evalExpression(expression)->get_content());
		}

		/**
		 * Hilsmethode fuer das Extrahieren eines Stringwertes mittels einer
		 * XPath-Expression.
		 *
		 * @param expression Auszufuehrende XPath-Expression
		 * @return Ergebnisstring
		 */
		protected string getValueString (string expression) 
		{
			return evalExpression(expression)->get_content();
		}

		/**
		 * Allgemeine Hilfsmethode fuer das Ausfuehren einer XPath-Expression 
		 * mit genau einem Knoten als Ergebnis.
		 *
		 * @param expression Auszufuehrende XPath-Expression als String.
		 * @return node mit dem Ergebnisknoten der Expression.
		 */
		protected Xml.Node* evalExpression (string expression) 
		{
			unowned Xml.XPath.Object obj = ctx.eval_expression(expression);

			if (obj == null) 
				print("failed to evaluate xpath expression\n");

			Xml.Node* node = null;

			if (obj.nodesetval != null && obj.nodesetval->item(0) != null) {
				node = obj.nodesetval->item(0);
			} else {
				print("failed to find the expected node"+expression+"\n");
			}

			return node;
		}

		/**
		 * Liefert mehrere Ergebnisse einer XPath-Expression als NodeSet
		 *
		 * @param expression Auszufuehrende XPath-Expression
		 * @return NodeSet mit den Ergebnisknoten
		 */
		protected NodeSet* evalExpressionMulti (string expression)
		{
			unowned Xml.XPath.Object obj = ctx.eval_expression(expression);

			if (obj == null) 
				print("failed to evaluate xpath expression\n");

			return obj.nodesetval;
		}

		/**
		 * Liefert die Anzahl der Ergebnisse einer XPath-Expression
		 *
		 * @param expression XPath-Expression
		 * @return Anzahl der Ergebnisknoten der Expression
		 */
		protected int evalExpressionCount (string expression)
		{
			unowned Xml.XPath.Object obj = ctx.eval_expression(expression);

			if (obj == null) 
				print("failed to evaluate xpath expression\n");

			return obj.nodesetval->length();
		}
	}
}
