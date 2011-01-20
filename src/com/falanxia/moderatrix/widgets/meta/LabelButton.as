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
	import com.falanxia.moderatrix.events.ButtonEvent;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.meta.LabelButtonSkin;
	import com.falanxia.moderatrix.widgets.ButtonCore;
	import com.falanxia.moderatrix.widgets.ScaleButton;
	import com.falanxia.moderatrix.widgets.combos.LabelCombo;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.enums.Align;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;
	import com.falanxia.utilitaris.utils.ObjectUtils;

	import flash.display.DisplayObjectContainer;



	/**
	 * Label button.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class LabelButton extends MorphSprite implements IWidget {


		public var button:ScaleButton;
		public var labelCombo:LabelCombo;

		protected var _skin:LabelButtonSkin;

		private var _debugLevel:String;
		private var _debugColor:RGBA;



		/**
		 * Constructor.
		 * @param skin Widget skin
		 * @param displayConfig (optional) Display config
		 * @param text (optional) Text
		 * @param displayParent (optional) Display parent
		 * @param debugLevel (optional) Debug level
		 * @see ISkin
		 * @see DebugLevel
		 */
		public function LabelButton(skin:LabelButtonSkin, displayConfig:Object = null, text:String = "", displayParent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			button = new ScaleButton(skin.buttonSkin, {}, this);
			labelCombo = new LabelCombo(skin.labelComboSkin, {mouseEnabled:false, mouseChildren:false}, text, this);

			this.skin = skin;
			this.focusRect = false;
			this.debugLevel = (debugLevel == null) ? DebugLevel.NONE : debugLevel;
			this.debugColor = DisplayUtils.DEBUG_BLUE;

			button.addEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween);
			button.addEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween);
			button.addEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween);
			button.addEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween);
			button.addEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween);
			button.addEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween);

			var c:Object = displayConfig == null ? new Object() : displayConfig;

			if(c.width == undefined) c.width = skin.buttonSkin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.buttonSkin.bitmapSize.height;

			super(c, displayParent);

			draw();
		}



		/**
		 * Destroys LabelButton instance and frees it for GC.
		 */
		override public function destroy():void {
			DisplayUtils.removeChildren(this, button, labelCombo);

			button.removeEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween);
			button.removeEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween);
			button.removeEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween);
			button.removeEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween);
			button.removeEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween);
			button.removeEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween);

			forceRelease();

			button.destroy();
			labelCombo.destroy();

			super.destroy();

			button = null;
			labelCombo = null;

			_skin = null;
			_debugLevel = null;
			_debugColor = null;
		}



		/**
		 * Draw the widget.
		 */
		public function draw():void {
			button.draw();
			labelCombo.draw();
		}



		/**
		 * Force release the button.
		 */
		public function forceRelease():void {
			button.forceRelease();
		}



		/**
		 * Release all buttons everywhere.
		 */
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

			var w:Number = labelCombo.width + padding;
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

				if(_skin.labelComboSkin.labelOutSkin.settings != null) {
					_skin.labelComboSkin.labelOutSkin.settings["hAlign"] = Align.CENTER;
				}

				if(_skin.labelComboSkin.labelHoverSkin.settings != null) {
					_skin.labelComboSkin.labelHoverSkin.settings["hAlign"] = Align.CENTER;
				}

				if(_skin.labelComboSkin.labelFocusSkin.settings != null) {
					_skin.labelComboSkin.labelFocusSkin.settings["hAlign"] = Align.CENTER;
				}

				button.skin = _skin.buttonSkin;
				labelCombo.skin = _skin.labelComboSkin;
			}
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;

			button.debugLevel = value;
			labelCombo.debugLevel = value;
		}



		public function get debugColor():RGBA {
			return _debugColor;
		}



		public function set debugColor(value:RGBA):void {
			_debugColor = value;

			button.debugColor = value;
			labelCombo.debugColor = value;
		}



		override public function get width():Number {
			return button.width;
		}



		override public function set width(value:Number):void {
			button.width = value;
			labelCombo.width = value;
		}



		override public function get height():Number {
			return button.height;
		}



		override public function set height(value:Number):void {
			button.height = value;

			labelCombo.y = Math.round((value - labelCombo.height) / 2);
		}



		private function onButtonHoverInTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["hoverInDuration"];

				labelCombo.animateHoverIn(duration);
			}
		}



		private function onButtonHoverOutTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["hoverOutDuration"];

				labelCombo.animateHoverOut(duration);
			}
		}



		private function onButtonFocusInTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["focusInDuration"];

				labelCombo.animateFocusIn(duration);
			}
		}



		private function onButtonDragConfirmedTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["hoverInDuration"];

				labelCombo.animateHoverIn(duration);
			}
		}



		private function onButtonReleasedInsideTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["focusOutDuration"];

				labelCombo.animateFocusOut(duration);
			}
		}



		private function onButtonReleasedOutsideTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["focusOutDuration"];

				labelCombo.animateFocusOut(duration);
			}
		}
	}
}
