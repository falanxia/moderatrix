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

package com.falanxia.moderatrix.widgets {
	import com.falanxia.moderatrix.enums.DebugLevel;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.ImageSkin;
	import com.falanxia.utilitaris.display.QBitmap;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;



	/**
	 * Image.
	 *
	 * Image is an image :]
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class Image extends Widget implements IWidget {


		protected var imageBM:QBitmap;



		/**
		 * Constructor.
		 * @param skin Initial skin
		 * @param displayConfig Config Object
		 * @param displayParent Parent DisplayObjectContainer
		 * @param debugLevel Initial debug level
		 * @see DebugLevel
		 */
		public function Image(skin:ImageSkin, displayConfig:Object = null, displayParent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object = displayConfig == null ? new Object() : displayConfig;
			var dl:String = (debugLevel == null) ? DebugLevel.NONE : debugLevel;

			if(c.width == undefined) c.width = skin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.bitmapSize.height;

			super(c, displayParent, dl);

			this.skin = skin;
		}



		/**
		 * Destroys Image instance and frees it for GC.
		 */
		override public function destroy():void {
			removeChildren();

			imageBM.destroy();

			super.destroy();

			_skin = null;
			imageBM = null;
		}



		/**
		 * Draw widget.
		 */
		override public function draw():void {
			super.draw();

			if(_skin != null && _skin.settings != null && _size != null) {
				var settings:Dictionary = _skin.settings;
				var rect:Rectangle = new Rectangle(settings["paddingLeft"], settings["paddingTop"], _size.width - settings["paddingLeft"], _size.height - settings["paddingTop"]);

				imageBM.positionAndSize = rect;

				if(_debugLevel != DebugLevel.NONE) {
					DisplayUtils.strokeBounds(debugSpr, rect, _debugColor, 5);
				}
			}
		}



		/**
		 * Set skin.
		 * @param value Skin
		 */
		override public function set skin(value:ISkin):void {
			if(value != null) {
				super.skin = value;

				if(_skin.bitmapSize != null) {
					if(_size.width == 0) _size.width = _skin.bitmapSize.width;
					if(_size.height == 0) _size.height = _skin.bitmapSize.height;
				}

				var skin:ImageSkin = ImageSkin(_skin);

				if(skin.bitmapSources != null) {
					imageBM.bitmapData = skin.bitmapSources[ImageSkin.IMAGE_BITMAP];
					imageBM.smoothing = true;
				}
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
