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
	import com.falanxia.moderatrix.enums.*;
	import com.falanxia.moderatrix.globals.*;
	import com.falanxia.moderatrix.interfaces.*;
	import com.falanxia.moderatrix.skin.*;
	import com.falanxia.utilitaris.display.*;
	import com.falanxia.utilitaris.utils.*;

	import flash.display.*;
	import flash.geom.*;
	import flash.utils.*;



	public class Image extends Widget implements IWidget {


		protected var _skin:ImageSkin;

		protected var imageBM:QBitmap;



		public function Image(skin:ImageSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object;

			if(config == null) {
				c = new Object();
			}
			else {
				c = config;
			}

			if(c.width == undefined) {
				c.width = skin.assetSize.width;
			}

			if(c.height == undefined) {
				c.height = skin.assetSize.height;
			}

			//noinspection NegatedIfStatementJS
			if(skin != null) {
				super(c, parent, (debugLevel == null) ? SkinManager.defaultDebugLevel : debugLevel);
			}
			else {
				throw new Error("No skin defined");
			}

			this.skin = skin;
		}



		/**
		 * Destroys Image instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			removeChildren();

			imageBM.destroy();

			_skin = null;
			imageBM = null;
		}



		override public function draw():void {
			super.draw();

			if(_skin != null && _size != null) {
				var settings:Dictionary = _skin.settings;
				var rect:Rectangle = new Rectangle(settings["paddingLeft"], settings["paddingTop"], _size.width - settings["paddingLeft"],
				                                   _size.height - settings["paddingTop"]);

				imageBM.positionAndSize = rect;

				if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) {
					DisplayUtils.strokeBounds(debugSpr, rect, _debugColor, 5);
				}
			}
		}



		public function get skin():ImageSkin {
			return _skin;
		}



		public function set skin(skin:ImageSkin):void {
			if(_size != null) {
				_skin = skin;

				if(_size.width == 0) _size.width = _skin.assetSize.width;
				if(_size.height == 0) _size.height = _skin.assetSize.height;

				imageBM.bitmapData = _skin.assetSources[0];
				imageBM.smoothing = true;

				invalidate();
			}
		}



		public function get bitmap():QBitmap {
			return imageBM;
		}



		override protected function init():void {
			super.init();

			isMorphWidthEnabled = false;
			isMorphHeightEnabled = false;
			isChangeWidthEnabled = false;
			isChangeHeightEnabled = false;
		}



		override protected function addChildren():void {
			super.addChildren();

			imageBM = new QBitmap();

			DisplayUtils.addChildren(contentSpr, imageBM);
		}
	}
}
