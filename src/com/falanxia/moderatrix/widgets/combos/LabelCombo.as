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
	import com.falanxia.moderatrix.skin.combos.LabelComboSkin;
	import com.falanxia.moderatrix.widgets.Label;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;

	import flash.display.DisplayObjectContainer;



	public class LabelCombo extends MorphSprite implements IWidget {


		public var labelOut:Label;
		public var labelHover:Label;
		public var labelFocus:Label;

		protected var _skin:LabelComboSkin;

		private var _debugLevel:String;
		private var _debugColor:RGBA;
		private var _text:String;



		public function LabelCombo(skin:LabelComboSkin, displayConfig:Object = null, text:String = "", displayParent:DisplayObjectContainer = null,
		                           debugLevel:String = null) {
			labelOut = new Label(skin.labelOutSkin, {mouseEnabled:false, mouseChildren:false}, "", this);
			labelHover = new Label(skin.labelHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, "", this);
			labelFocus = new Label(skin.labelFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, "", this);

			this.skin = skin;
			this.text = text;
			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.debugLevel = (debugLevel == null) ? DebugLevel.NONE : debugLevel;
			this.debugColor = DisplayUtils.RED;

			var c:Object = displayConfig == null ? new Object() : displayConfig;

			if(c.width == undefined) c.width = skin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.bitmapSize.height;

			super(c, displayParent);
		}



		/**
		 * Destroys StateLabel instance and frees it for GC.
		 */
		override public function destroy():void {
			DisplayUtils.removeChildren(this, labelOut, labelHover, labelFocus);

			labelOut.destroy();
			labelHover.destroy();
			labelFocus.destroy();

			super.destroy();

			labelOut = null;
			labelHover = null;
			labelFocus = null;

			_skin = null;
			_debugLevel = null;
			_debugColor = null;
			_text = null;
		}



		public function draw():void {
			labelOut.draw();
			labelHover.draw();
			labelFocus.draw();
		}



		public function animateHoverIn(duration:Number):void {
			new TweenMax(labelOut, duration, {alpha:0, ease:Cubic.easeIn});
			new TweenMax(labelHover, duration, {alpha:1, ease:Cubic.easeOut});
			new TweenMax(labelFocus, duration, {alpha:0, ease:Cubic.easeIn});
		}



		public function animateHoverOut(duration:Number):void {
			new TweenMax(labelOut, duration, {alpha:1, ease:Cubic.easeOut});
			new TweenMax(labelHover, duration, {alpha:0, ease:Cubic.easeIn});
			new TweenMax(labelFocus, duration, {alpha:0, ease:Cubic.easeIn});
		}



		public function animateFocusIn(duration:Number):void {
			new TweenMax(labelOut, duration, {alpha:0, ease:Cubic.easeIn});
			new TweenMax(labelHover, duration, {alpha:0, ease:Cubic.easeIn});
			new TweenMax(labelFocus, duration, {alpha:1, ease:Cubic.easeOut});
		}



		public function animateFocusOut(duration:Number):void {
			new TweenMax(labelOut, duration, {alpha:0, ease:Cubic.easeIn});
			new TweenMax(labelHover, duration, {alpha:1, ease:Cubic.easeOut});
			new TweenMax(labelFocus, duration, {alpha:0, ease:Cubic.easeIn});
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
				_skin = LabelComboSkin(value);

				labelOut.skin = _skin.labelOutSkin;
				labelHover.skin = _skin.labelHoverSkin;
				labelFocus.skin = _skin.labelFocusSkin;
			}
		}



		/**
		 * Get current text.
		 * @return Current text
		 */
		public function get text():String {
			return _text;
		}



		/**
		 * Set current text
		 * @param value Current text
		 */
		public function set text(value:String):void {
			_text = value;

			labelOut.text = _text;
			labelHover.text = _text;
			labelFocus.text = _text;
		}



		public function get currentLabel():Label {
			var out:Label;

			if(labelOut.alpha == 1.0) out = labelOut;
			if(labelHover.alpha == 1.0) out = labelHover;
			if(labelFocus.alpha == 1.0) out = labelFocus;

			return out;
		}



		public function get mouseStatus():String {
			var out:String;

			if(labelOut.alpha == 1.0) out = MouseStatus.OUT;
			if(labelHover.alpha == 1.0) out = MouseStatus.HOVER;
			if(labelFocus.alpha == 1.0) out = MouseStatus.FOCUS;

			return out;
		}



		public function set mouseStatus(value:String):void {
			labelOut.alpha = (value == MouseStatus.OUT) ? 1.0 : 0.0;
			labelHover.alpha = (value == MouseStatus.HOVER) ? 1.0 : 0.0;
			labelFocus.alpha = (value == MouseStatus.FOCUS) ? 1.0 : 0.0;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;

			labelOut.debugLevel = value;
			labelHover.debugLevel = value;
			labelFocus.debugLevel = value;
		}



		public function get debugColor():RGBA {
			return _debugColor;
		}



		public function set debugColor(value:RGBA):void {
			_debugColor = value;

			labelOut.debugColor = value;
			labelHover.debugColor = value;
			labelFocus.debugColor = value;
		}



		override public function set width(value:Number):void {
			labelOut.width = value;
			labelHover.width = value;
			labelFocus.width = value;
		}



		override public function set height(value:Number):void {
			labelOut.height = value;
			labelHover.height = value;
			labelFocus.height = value;
		}
	}
}
