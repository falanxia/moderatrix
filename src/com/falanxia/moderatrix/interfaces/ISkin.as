/*
 * Falanxia Moderatrix.
 *
 * Copyright (c) 2011 Falanxia (http://falanxia.com)
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
	import com.falanxia.utilitaris.types.Size;

	import flash.utils.Dictionary;



	/**
	 * Skinnable interface.
	 *
	 * All widget skins must implement this interface.
	 *
	 * @author Vaclav Vancura / Falanxia a.s.
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public interface ISkin {


		/**
		 * Parse config.
		 * @param value Config Object
		 */
		function parseConfig(value:Object):void;



		/**
		 * Revert config to the last known state.
		 */
		function revertConfig():void;



		/**
		 * Get skin ID.
		 * @return Skin ID
		 */
		function get id():String;



		/**
		 * Get skin type.
		 * @return Skin type
		 * @see SkinType
		 */
		function get type():String;



		/**
		 * Get bitmap size.
		 * @return Bitmap size
		 * @see Size
		 */
		function get bitmapSize():Size;



		/**
		 * Get config Object.
		 * @return Config Object
		 */
		function get config():Object;



		/**
		 * Get current settings.
		 * @return Current settings
		 */
		function get settings():Dictionary;
	}
}
