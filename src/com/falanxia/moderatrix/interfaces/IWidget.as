/*
 * Falanxia Moderatrix.
 *
 * Copyright (c) 2010 Falanxia (http://falanxia.com)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.falanxia.moderatrix.interfaces {
	import flash.geom.*;



	/**
	 * Widget interface.
	 *
	 * All widgets need to implement this interface.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public interface IWidget {


		/**
		 * Draw the widget.
		 */
		function draw():void;



		/**
		 * Set debug level.
		 * @param value Debug level
		 * @see DebugLevel
		 */
		function set debugLevel(value:String):void;



		/**
		 * Get current debug level.
		 * @return Current debug level
		 * @see DebugLevel
		 */
		function get debugLevel():String;



		/**
		 * Get X position.
		 * @return X position
		 */
		function get x():Number;



		/**
		 * Set X position.
		 * @param value X position
		 */
		function set x(value:Number):void;



		/**
		 * Get Y position.
		 * @return Y position
		 */
		function get y():Number;



		/**
		 * Set Y position.
		 * @param value Y position
		 */
		function set y(value:Number):void;



		/**
		 * Get width.
		 * @return Width
		 */
		function get width():Number;



		/**
		 * Set width.
		 * @param value Width
		 */
		function set width(value:Number):void;



		/**
		 * Get height.
		 * @return Height
		 */
		function get height():Number;



		/**
		 * Set height.
		 * @param value Height
		 */
		function set height(value:Number):void;



		/**
		 * Get size.
		 * @return Size
		 */
		function get size():Rectangle;



		/**
		 * Set size.
		 * @param value Size
		 */
		function set size(value:Rectangle):void;



		/**
		 * Get position.
		 * @return Position
		 */
		function get position():Point;



		/**
		 * Set position.
		 * @param value Position
		 */
		function set position(value:Point):void;


	}
}
