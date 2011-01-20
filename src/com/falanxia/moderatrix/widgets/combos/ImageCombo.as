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

package com.falanxia.moderatrix.widgets.combos {
	import com.falanxia.moderatrix.enums.DebugLevel;
	import com.falanxia.moderatrix.enums.MouseStatus;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.combos.ImageComboSkin;
	import com.falanxia.moderatrix.widgets.Image;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;

	import flash.display.DisplayObjectContainer;



	public class ImageCombo extends MorphSprite implements IWidget {


		public var imageOut:Image;
		public var imageHover:Image;
		public var imageFocus:Image;

		protected var _skin:ImageComboSkin;

		private var _debugLevel:String;
		private var _debugColor:RGBA;



		public function ImageCombo(skin:ImageComboSkin, displayConfig:Object = null, displayParent:DisplayObjectContainer = null,
		                           debugLevel:String = null) {
			imageOut = new Image(skin.imageOutSkin, {mouseEnabled:false, mouseChildren:false}, this);
			imageHover = new Image(skin.imageHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this);
			imageFocus = new Image(skin.imageFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this);

			this.skin = skin;
			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.debugLevel = (debugLevel == null) ? DebugLevel.NONE : debugLevel;
			this.debugColor = DisplayUtils.RED;
			this.mouseStatus = MouseStatus.OUT;

			var c:Object = displayConfig == null ? new Object() : displayConfig;

			if(c.width == undefined) c.width = skin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.bitmapSize.height;

			super(c, displayParent);
		}



		/**
		 * Destroys StateImage instance and frees it for GC.
		 */
		override public function destroy():void {
			DisplayUtils.removeChildren(this, imageOut, imageHover, imageFocus);

			imageOut.destroy();
			imageHover.destroy();
			imageFocus.destroy();

			super.destroy();

			imageOut = null;
			imageHover = null;
			imageFocus = null;

			_skin = null;
			_debugLevel = null;
			_debugColor = null;
		}



		public function draw():void {
			imageOut.draw();
			imageHover.draw();
			imageFocus.draw();
		}



		public function animateHoverIn(duration:Number):void {
			new TweenMax(imageOut, duration, {alpha:0, ease:Cubic.easeIn});
			new TweenMax(imageHover, duration, {alpha:1, ease:Cubic.easeOut});
			new TweenMax(imageFocus, duration, {alpha:0, ease:Cubic.easeIn});
		}



		public function animateHoverOut(duration:Number):void {
			new TweenMax(imageOut, duration, {alpha:1, ease:Cubic.easeOut});
			new TweenMax(imageHover, duration, {alpha:0, ease:Cubic.easeIn});
			new TweenMax(imageFocus, duration, {alpha:0, ease:Cubic.easeIn});
		}



		public function animateFocusIn(duration:Number):void {
			new TweenMax(imageOut, duration, {alpha:0, ease:Cubic.easeIn});
			new TweenMax(imageHover, duration, {alpha:0, ease:Cubic.easeIn});
			new TweenMax(imageFocus, duration, {alpha:1, ease:Cubic.easeOut});
		}



		public function animateFocusOut(duration:Number):void {
			new TweenMax(imageOut, duration, {alpha:0, ease:Cubic.easeIn});
			new TweenMax(imageHover, duration, {alpha:1, ease:Cubic.easeOut});
			new TweenMax(imageFocus, duration, {alpha:0, ease:Cubic.easeIn});
		}



		/**
		 * Get current skin.
		 * @return Current skin
		 */
		public function get skin():ISkin {
			return _skin;
		}



		/**
		 * Set skin.
		 * @param value Skin
		 */
		public function set skin(value:ISkin):void {
			if(value != null) {
				_skin = ImageComboSkin(value);

				imageOut.skin = _skin.imageOutSkin;
				imageHover.skin = _skin.imageHoverSkin;
				imageFocus.skin = _skin.imageFocusSkin;
			}
		}



		public function get currentImage():Image {
			var out:Image;

			if(imageOut.alpha == 1.0) out = imageOut;
			if(imageHover.alpha == 1.0) out = imageHover;
			if(imageFocus.alpha == 1.0) out = imageFocus;

			return out;
		}



		public function get mouseStatus():String {
			var out:String;

			if(imageOut.alpha == 1.0) out = MouseStatus.OUT;
			if(imageHover.alpha == 1.0) out = MouseStatus.HOVER;
			if(imageFocus.alpha == 1.0) out = MouseStatus.FOCUS;

			return out;
		}



		public function set mouseStatus(value:String):void {
			imageOut.alpha = (value == MouseStatus.OUT) ? 1.0 : 0.0;
			imageHover.alpha = (value == MouseStatus.HOVER) ? 1.0 : 0.0;
			imageFocus.alpha = (value == MouseStatus.FOCUS) ? 1.0 : 0.0;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;

			imageOut.debugLevel = value;
			imageHover.debugLevel = value;
			imageFocus.debugLevel = value;
		}



		public function get debugColor():RGBA {
			return _debugColor;
		}



		public function set debugColor(value:RGBA):void {
			_debugColor = value;

			imageOut.debugColor = value;
			imageHover.debugColor = value;
			imageFocus.debugColor = value;
		}



		override public function set width(value:Number):void {
		}



		override public function set height(value:Number):void {
		}
	}
}
