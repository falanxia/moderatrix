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

package com.falanxia.moderatrix.widgets {
	import com.falanxia.moderatrix.constants.DebugLevel;
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.skin.AtlasSkin;
	import com.falanxia.utilitaris.display.QBitmap;
	import com.falanxia.utilitaris.helpers.printf;
	import com.falanxia.utilitaris.utils.BitmapUtils;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import de.dev_lab.logging.Logger;

	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;



	/** @todo Comment */
	public class Atlas extends Widget {


		protected var _skin:AtlasSkin;

		protected var imageBM:QBitmap;
		protected var _index:uint = 0;



		/** @todo Comment */
		public function Atlas(skin:AtlasSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			if(c.width == undefined) c.width = skin.assetSize.width;
			if(c.height == undefined) c.height = skin.assetSize.height;

			//noinspection NegatedIfStatementJS
			if(skin != null) super(c, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
			else throw new Error("No skin defined");

			this.skin = skin;
		}



		/**
		 * @todo Comment
		 * @todo Optimize
		 */
		override public function draw():void {
			super.draw();

			var w:uint = _skin.assetSize.width;
			var h:uint = _skin.assetSize.height;
			var rect:Rectangle = new Rectangle(_index * w, 0, w, h);
			imageBM.bitmapData = BitmapUtils.crop(_skin.imageBD, rect);

			if(_skin != null) {
				if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) {
					if(!_size.isEmpty()) DisplayUtils.strokeBounds(debugSpr, rect, _debugColor, 5);
				}
			}
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		public function get skin():AtlasSkin {
			return _skin;
		}



		/** @todo Comment */
		public function set skin(skin:AtlasSkin):void {
			_skin = skin;

			if(_size.width == 0) _size.width = _skin.assetSize.width;
			if(_size.height == 0) _size.height = _skin.assetSize.height;

			imageBM.bitmapData = _skin.imageBD;
			imageBM.smoothing = true;

			draw();
		}



		/** @todo Comment */
		public function get bitmap():QBitmap {
			return imageBM;
		}



		/** @todo Comment */
		public function set index(value:uint):void {
			if(value > this.length) {
				throw new Error(printf('Atlas index too high (%d), only %d indexes available', value, this.length));
			}
			else {
				_index = value;
				draw();
			}
		}



		/** @todo Comment */
		public function get index():uint {
			return _index;
		}



		/** @todo Comment */
		public function get length():uint {
			return (_skin.imageBD == null) ? 0 : _skin.imageBD.width / _skin.assetSize.width;
		}



		/* ★ PROTECTED METHODS ★ */


		/** @todo Comment */
		override protected function init():void {
			super.init();

			isMorphWidthEnabled = false;
			isMorphHeightEnabled = false;
			isChangeWidthEnabled = false;
			isChangeHeightEnabled = false;
		}



		/** @todo Comment */
		override protected function addChildren():void {
			super.addChildren();

			imageBM = new QBitmap();

			DisplayUtils.addChildren(contentSpr, imageBM);
		}



		/** @todo Comment */
		override protected function removeChildren():void {
			super.removeChildren();

			DisplayUtils.removeChildren(contentSpr, imageBM);
		}
	}
}
