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
	import com.falanxia.moderatrix.skin.BarSkin;
	import com.falanxia.utilitaris.display.ScaleBitmapSprite;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;



	/** @todo Comment */
	public class Bar extends Widget {


		protected var _skin:BarSkin;

		protected var bodySBS:ScaleBitmapSprite;



		/** @todo Comment */
		public function Bar(skin:BarSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {
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

			if(_skin != null) {
				var rect:Rectangle = new Rectangle(_skin.paddingLeft, _skin.paddingTop, _size.width - _skin.paddingLeft - _skin.paddingRight, _size.height - _skin.paddingTop - _skin.paddingBottom);

				if(_size.width != 0 && !isNaN(_size.width)) {
					bodySBS.width = rect.width;
					bodySBS.x = rect.x;
				}
				if(_size.height != 0 && !isNaN(_size.height)) {
					bodySBS.height = rect.height;
					bodySBS.y = rect.y;
				}

				if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) {
					if(!_size.isEmpty()) DisplayUtils.strokeBounds(debugSpr, rect, _debugColor, 5);
				}
			}
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		public function get skin():BarSkin {
			return _skin;
		}



		/** @todo Comment */
		public function set skin(skin:BarSkin):void {
			_skin = skin;

			if(_size.width == 0) _size.width = _skin.assetSize.width;
			if(_size.height == 0) _size.height = _skin.assetSize.height;

			bodySBS.setData()(_skin.backBD, _skin.guideBD.getColorBoundsRect(0x00FF0000, 0x00000000, false));

			draw();
		}



		/** @todo Comment */
		override public function get width():Number {
			return _size.width + _skin.paddingLeft + _skin.paddingRight;
		}



		/** @todo Comment */
		override public function get height():Number {
			return _size.height + _skin.paddingTop + _skin.paddingBottom;
		}



		/* ★ PROTECTED METHODS ★ */


		/** @todo Comment */
		override protected function init():void {
			super.init();

			isMorphWidthEnabled = true;
			isMorphHeightEnabled = true;
			isChangeWidthEnabled = true;
			isChangeHeightEnabled = true;
		}



		/** @todo Comment */
		override protected function addChildren():void {
			super.addChildren();

			bodySBS = new ScaleBitmapSprite();

			DisplayUtils.addChildren(contentSpr, bodySBS);
		}



		/** @todo Comment */
		override protected function removeChildren():void {
			super.removeChildren();

			DisplayUtils.removeChildren(contentSpr, bodySBS);
		}
	}
}
