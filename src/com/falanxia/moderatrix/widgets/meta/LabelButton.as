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


		public var button:ScaleButton;
		public var labelOut:Label;
		public var labelHover:Label;
		public var labelFocus:Label;

		protected var _skin:LabelButtonSkin;

		private var _debugLevel:String;



		public function LabelButton(skin:LabelButtonSkin, displayConfig:Object = null, text:String = "", displayParent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			var c:Object = displayConfig == null ? new Object() : displayConfig;
			var dl:String = (debugLevel == null) ? DebugLevel.NONE : debugLevel;
			var dc:RGBA = DisplayUtils.RED;

			button = new ScaleButton(skin.buttonSkin, {}, this, dl);
			labelOut = new Label(skin.labelOutSkin, {mouseEnabled:false, mouseChildren:false}, "", this, dl);
			labelHover = new Label(skin.labelHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, "", this, dl);
			labelFocus = new Label(skin.labelFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, "", this, dl);

			button.debugColor = dc;
			labelOut.debugColor = dc;
			labelHover.debugColor = dc;
			labelFocus.debugColor = dc;

			this.skin = skin;
			this.text = text;
			this.focusRect = false;

			button.addEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween);
			button.addEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween);
			button.addEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween);
			button.addEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween);
			button.addEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween);
			button.addEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween);

			if(c.width == undefined) c.width = skin.buttonSkin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.buttonSkin.bitmapSize.height;

			super(c, displayParent);

			_skin = skin;
		}



		/**
		 * Destroys LabelButton instance and frees it for GC.
		 */
		override public function destroy():void {
			button.removeEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween);
			button.removeEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween);
			button.removeEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween);
			button.removeEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween);
			button.removeEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween);
			button.removeEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween);

			DisplayUtils.removeChildren(this, button, labelOut, labelHover, labelFocus);

			forceRelease();

			button.destroy();
			labelOut.destroy();
			labelHover.destroy();
			labelFocus.destroy();

			super.destroy();

			button = null;
			labelOut = null;
			labelHover = null;
			labelFocus = null;

			_skin = null;
			_debugLevel = null;
		}



		public function draw():void {
			button.draw();
			labelOut.draw();
			labelHover.draw();
			labelFocus.draw();
		}



		public function forceRelease():void {
			button.forceRelease();
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
			}

			else {
				this.width = w;
			}
		}



		override public function get tabEnabled():Boolean {
			return button.tabEnabled;
		}



		override public function set tabEnabled(enabled:Boolean):void {
			button.tabEnabled = enabled;
		}



		override public function get tabIndex():int {
			return button.tabIndex;
		}



		override public function set tabIndex(index:int):void {
			button.tabIndex = index;
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

				button.skin = _skin.buttonSkin;
				labelOut.skin = _skin.labelOutSkin;
				labelHover.skin = _skin.labelHoverSkin;
				labelFocus.skin = _skin.labelFocusSkin;
			}
		}



		override public function get width():Number {
			return button.width;
		}



		override public function set width(value:Number):void {
			button.width = value;
			labelOut.width = value;
			labelHover.width = value;
			labelFocus.width = value;
		}



		override public function get height():Number {
			return button.height;
		}



		override public function set height(value:Number):void {
			button.height = value;

			labelOut.y = Math.round((value - labelOut.height) / 2);
			labelHover.y = Math.round((value - labelHover.height) / 2);
			labelFocus.y = Math.round((value - labelFocus.height) / 2);
		}



		public function set areEventsEnabled(value:Boolean):void {
			button.areEventsEnabled = value;
			this.buttonMode = value;
			this.useHandCursor = value;
		}



		public function get areEventsEnabled():Boolean {
			return button.areEventsEnabled;
		}



		public function get mouseStatus():String {
			return button.mouseStatus;
		}



		public function set mouseStatus(value:String):void {
			button.mouseStatus = value;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;

			button.debugLevel = value;
			labelOut.debugLevel = value;
			labelHover.debugLevel = value;
			labelFocus.debugLevel = value;
		}



		public function get text():String {
			return labelOut.text;
		}



		public function set text(value:String):void {
			labelOut.text = value;
			labelHover.text = value;
			labelFocus.text = value;
		}



		public function get label():Label {
			var out:Label;

			if(button.mouseStatus == MouseStatus.OUT) out = labelOut;
			if(button.mouseStatus == MouseStatus.HOVER) out = labelHover;
			if(button.mouseStatus == MouseStatus.FOCUS) out = labelFocus;

			return out;
		}



		private function onButtonHoverInTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var hoverInDuration:Number = _skin.buttonSkin.settings["hoverInDuration"];

				new TweenMax(labelOut, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(labelHover, hoverInDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(labelFocus, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonHoverOutTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var hoverOutDuration:Number = _skin.buttonSkin.settings["hoverOutDuration"];

				new TweenMax(labelOut, hoverOutDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(labelHover, hoverOutDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(labelFocus, hoverOutDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonFocusInTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var focusInDuration:Number = _skin.buttonSkin.settings["focusInDuration"];

				new TweenMax(labelOut, focusInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(labelHover, focusInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(labelFocus, focusInDuration, {alpha:1, ease:Cubic.easeOut});
			}
		}



		private function onButtonDragConfirmedTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var hoverInDuration:Number = _skin.buttonSkin.settings["hoverInDuration"];

				new TweenMax(labelOut, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(labelHover, hoverInDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(labelFocus, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonReleasedInsideTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var focusOutDuration:Number = _skin.buttonSkin.settings["focusOutDuration"];

				new TweenMax(labelOut, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(labelHover, focusOutDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(labelFocus, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonReleasedOutsideTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var focusOutDuration:Number = _skin.buttonSkin.settings["focusOutDuration"];

				new TweenMax(labelOut, focusOutDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(labelHover, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(labelFocus, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}
	}
}
