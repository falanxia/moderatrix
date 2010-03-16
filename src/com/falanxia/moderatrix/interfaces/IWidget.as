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
	import flash.geom.Rectangle;



	/** @todo Comment */
	public interface IWidget {


		/** @todo Comment */
		function draw():void;



		/** @todo Comment */
		function set debugLevel(value:String):void;



		/** @todo Comment */
		function get debugLevel():String;



		/** @todo Comment */
		function get x():Number;



		/** @todo Comment */
		function set x(value:Number):void;



		/** @todo Comment */
		function get y():Number;



		/** @todo Comment */
		function set y(value:Number):void;



		/** @todo Comment */
		function get width():Number;



		/** @todo Comment */
		function set width(value:Number):void;



		/** @todo Comment */
		function get height():Number;



		/** @todo Comment */
		function set height(value:Number):void;



		/** @todo Comment */
		function get size():Rectangle;



		/** @todo Comment */
		function set size(rect:Rectangle):void;
	}
}
