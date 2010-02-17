// Falanxia Moderatrix.
//
// Copyright (c) 2010 Falanxia (http://falanxia.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

package com.falanxia.moderatrix.widgets {
	import com.falanxia.moderatrix.constants.DebugLevel;
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.skin.ImageSkin;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;



	/** @todo Comment */
	public class Image extends Widget {


		protected var _skin:ImageSkin;
		protected var _imageBM:Bitmap;



		/** @todo Comment */
		public function Image(skin:ImageSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			if(c.width == undefined) {
				c.width = skin.assetSize.width;
			}

			if(c.height == undefined) {
				c.height = skin.assetSize.height;
			}

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

			if(_skin != null) {
				var rect:Rectangle = new Rectangle(_skin.paddingLeft, _skin.paddingTop, _size.width - _skin.paddingLeft, _size.height - _skin.paddingTop);

				_imageBM.x = rect.x;
				_imageBM.y = rect.y;

				if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) {
					if(!_size.isEmpty()) DisplayUtils.strokeBounds(_debugSpr, rect, _debugColor, 5);
				}
			}
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		public function get skin():ImageSkin {
			return _skin;
		}



		/** @todo Comment */
		public function set skin(skin:ImageSkin):void {
			_skin = skin;

			if(_size.width == 0) _size.width = _skin.assetSize.width;
			if(_size.height == 0) _size.height = _skin.assetSize.height;

			_imageBM.bitmapData = _skin.imageBD;
			_imageBM.smoothing = true;

			draw();
		}



		/** @todo Comment */
		public function get bitmap():Bitmap {
			return _imageBM;
		}



		/* ★ PROTECTED METHODS ★ */


		/** @todo Comment */
		override protected function _init():void {
			super._init();

			isMorphWidthEnabled = false;
			isMorphHeightEnabled = false;
			isChangeWidthEnabled = false;
			isChangeHeightEnabled = false;
		}



		/** @todo Comment */
		override protected function _addChildren():void {
			super._addChildren();

			_imageBM = new Bitmap();

			DisplayUtils.addChildren(_contentSpr, _imageBM);
		}



		/** @todo Comment */
		override protected function _removeChildren():void {
			super._removeChildren();

			DisplayUtils.removeChildren(_contentSpr, _imageBM);
		}
	}
}
