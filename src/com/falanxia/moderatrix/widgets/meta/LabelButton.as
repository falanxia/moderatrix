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

package com.falanxia.moderatrix.widgets.meta {
	import com.falanxia.moderatrix.enums.DebugLevel;
	import com.falanxia.moderatrix.enums.MouseStatus;
	import com.falanxia.moderatrix.events.ButtonEvent;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.meta.LabelButtonSkin;
	import com.falanxia.moderatrix.widgets.ButtonCore;
	import com.falanxia.moderatrix.widgets.Label;
	import com.falanxia.moderatrix.widgets.ScaleButton;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.enums.Align;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;
	import com.falanxia.utilitaris.utils.ObjectUtils;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;

	import flash.display.DisplayObjectContainer;



	public class LabelButton extends MorphSprite implements IWidget {


		protected var _skin:LabelButtonSkin;
		protected var _button:ScaleButton;
		protected var _labelOut:Label;
		protected var _labelHover:Label;
		protected var _labelFocus:Label;

		private var _debugLevel:String;



		public function LabelButton(skin:LabelButtonSkin, displayConfig:Object = null, text:String = "", displayParent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			var c:Object = displayConfig == null ? new Object() : displayConfig;
			var dl:String = (debugLevel == null) ? DebugLevel.NONE : debugLevel;
			var dc:RGBA = DisplayUtils.RED;

			_button = new ScaleButton(skin.buttonSkin, {}, this, dl);
			_labelOut = new Label(skin.labelOutSkin, {mouseEnabled:false, mouseChildren:false}, "", this, dl);
			_labelHover = new Label(skin.labelHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, "", this, dl);
			_labelFocus = new Label(skin.labelFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, "", this, dl);
			_button.debugColor = dc;
			_labelOut.debugColor = dc;
			_labelHover.debugColor = dc;
			_labelFocus.debugColor = dc;

			this.skin = skin;
			this.text = text;
			this.focusRect = false;

			_button.addEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween);
			_button.addEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween);
			_button.addEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween);
			_button.addEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween);
			_button.addEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween);
			_button.addEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween);

			if(c.width == undefined) c.width = skin.buttonSkin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.buttonSkin.bitmapSize.height;

			super(c, displayParent);

			_skin = skin;
		}



		/**
		 * Destroys LabelButton instance and frees it for GC.
		 */
		override public function destroy():void {
			_button.removeEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween);
			_button.removeEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween);
			_button.removeEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween);
			_button.removeEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween);
			_button.removeEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween);
			_button.removeEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween);

			DisplayUtils.removeChildren(this, _button, _labelOut, _labelHover, _labelFocus);

			forceRelease();

			_button.destroy();
			_labelOut.destroy();
			_labelHover.destroy();
			_labelFocus.destroy();

			super.destroy();

			_skin = null;
			_button = null;
			_labelOut = null;
			_labelHover = null;
			_labelFocus = null;
			_debugLevel = null;
		}



		public function draw():void {
			_button.draw();
			_labelOut.draw();
			_labelHover.draw();
			_labelFocus.draw();
		}



		public function forceRelease():void {
			_button.forceRelease();
		}



		public static function releaseAll():void {
			ButtonCore.releaseAll();
		}



		/**
		 * Automatically set width of the button.
		 * @param padding Padding
		 * @param max Maximal width (then text will be split in more lines)
		 */
		public function autoWidth(padding:Number = 0, max:Number = 500, morph:Boolean = false, morphAddons:Object = null):void {
			var s:Number = this.width;

			this.width = 2000;

			var w:Number = label.width + padding;
			if(w > max) w = max;

			if(morph) {
				if(morphAddons == null) morphAddons = new Object();
				ObjectUtils.assign(morphAddons, {width:w});
				this.width = s;
				this.morph(morphAddons);
			} else {
				this.width = w;
			}
		}



		override public function get tabEnabled():Boolean {
			return _button.tabEnabled;
		}



		override public function set tabEnabled(enabled:Boolean):void {
			_button.tabEnabled = enabled;
		}



		override public function get tabIndex():int {
			return _button.tabIndex;
		}



		override public function set tabIndex(index:int):void {
			_button.tabIndex = index;
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
				_skin = LabelButtonSkin(value);

				if(_skin.labelOutSkin.settings != null) {
					_skin.labelOutSkin.settings["hAlign"] = Align.CENTER;
				}

				if(_skin.labelHoverSkin.settings != null) {
					_skin.labelHoverSkin.settings["hAlign"] = Align.CENTER;
				}

				if(_skin.labelFocusSkin.settings != null) {
					_skin.labelFocusSkin.settings["hAlign"] = Align.CENTER;
				}

				_button.skin = _skin.buttonSkin;
				_labelOut.skin = _skin.labelOutSkin;
				_labelHover.skin = _skin.labelHoverSkin;
				_labelFocus.skin = _skin.labelFocusSkin;
			}
		}



		override public function get width():Number {
			return _button.width;
		}



		override public function set width(value:Number):void {
			_button.width = value;
			_labelOut.width = value;
			_labelHover.width = value;
			_labelFocus.width = value;
		}



		override public function get height():Number {
			return _button.height;
		}



		override public function set height(value:Number):void {
			_button.height = value;
			_labelOut.y = Math.round((value - _labelOut.height) / 2);
			_labelHover.y = Math.round((value - _labelHover.height) / 2);
			_labelFocus.y = Math.round((value - _labelFocus.height) / 2);
		}



		public function set areEventsEnabled(value:Boolean):void {
			_button.areEventsEnabled = value;
			this.buttonMode = value;
			this.useHandCursor = value;
		}



		public function get areEventsEnabled():Boolean {
			return _button.areEventsEnabled;
		}



		public function get mouseStatus():String {
			return _button.mouseStatus;
		}



		public function set mouseStatus(value:String):void {
			_button.mouseStatus = value;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;
			_button.debugLevel = value;
			_labelOut.debugLevel = value;
			_labelHover.debugLevel = value;
			_labelFocus.debugLevel = value;
		}



		public function get text():String {
			return _labelOut.text;
		}



		public function set text(value:String):void {
			_labelOut.text = value;
			_labelHover.text = value;
			_labelFocus.text = value;
		}



		public function get label():Label {
			var out:Label;

			if(_button.mouseStatus == MouseStatus.OUT) out = _labelOut;
			if(_button.mouseStatus == MouseStatus.HOVER) out = _labelHover;
			if(_button.mouseStatus == MouseStatus.FOCUS) out = _labelFocus;

			return out;
		}



		public function get labelOut():Label {
			return _labelOut;
		}



		public function get labelHover():Label {
			return _labelHover;
		}



		public function get labelFocus():Label {
			return _labelFocus;
		}



		public function get button():ScaleButton {
			return _button;
		}



		private function onButtonHoverInTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var hoverInDuration:Number = _skin.buttonSkin.settings["hoverInDuration"];

				new TweenMax(_labelOut, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(_labelHover, hoverInDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(_labelFocus, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonHoverOutTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var hoverOutDuration:Number = _skin.buttonSkin.settings["hoverOutDuration"];

				new TweenMax(_labelOut, hoverOutDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(_labelHover, hoverOutDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(_labelFocus, hoverOutDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonFocusInTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var focusInDuration:Number = _skin.buttonSkin.settings["focusInDuration"];

				new TweenMax(_labelOut, focusInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(_labelHover, focusInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(_labelFocus, focusInDuration, {alpha:1, ease:Cubic.easeOut});
			}
		}



		private function onButtonDragConfirmedTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var hoverInDuration:Number = _skin.buttonSkin.settings["hoverInDuration"];

				new TweenMax(_labelOut, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(_labelHover, hoverInDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(_labelFocus, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonReleasedInsideTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var focusOutDuration:Number = _skin.buttonSkin.settings["focusOutDuration"];

				new TweenMax(_labelOut, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(_labelHover, focusOutDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(_labelFocus, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonReleasedOutsideTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var focusOutDuration:Number = _skin.buttonSkin.settings["focusOutDuration"];

				new TweenMax(_labelOut, focusOutDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(_labelHover, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(_labelFocus, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}
	}
}
