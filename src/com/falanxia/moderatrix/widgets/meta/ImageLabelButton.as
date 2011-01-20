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
	import com.falanxia.moderatrix.skin.meta.ImageLabelButtonSkin;
	import com.falanxia.moderatrix.widgets.ButtonCore;
	import com.falanxia.moderatrix.widgets.ScaleButton;
	import com.falanxia.moderatrix.widgets.combos.ImageCombo;
	import com.falanxia.moderatrix.widgets.combos.LabelCombo;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.enums.Align;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;
	import com.falanxia.utilitaris.utils.ObjectUtils;

	import flash.display.DisplayObjectContainer;



	public class ImageLabelButton extends MorphSprite implements IWidget {


		public var button:ScaleButton;
		public var imageCombo:ImageCombo;
		public var labelCombo:LabelCombo;

		protected var _skin:ImageLabelButtonSkin;

		private var _debugLevel:String;
		private var _debugColor:RGBA;



		/**
		 * Create a new glyph label button instance.
		 * @param skin Skin to be used (use ImageLabelButtonSkin)
		 * @param displayConfig Configuration Object
		 * @param text Initial text
		 * @param displayParent Parent DisplayObjectContainer
		 * @param debugLevel Debug level ({@see DebugLevel})
		 * @throws Error if no skin defined
		 */
		public function ImageLabelButton(skin:ImageLabelButtonSkin, displayConfig:Object = null, text:String = "",
		                                 displayParent:DisplayObjectContainer = null, debugLevel:String = null) {
			button = new ScaleButton(skin.buttonSkin, {}, this);
			imageCombo = new ImageCombo(skin.imageComboSkin, {mouseEnabled:false, mouseChildren:false}, this);
			labelCombo = new LabelCombo(skin.labelComboSkin, {mouseEnabled:false, mouseChildren:false}, text, this);

			labelCombo.labelOut.textField.wordWrap = false;
			labelCombo.labelHover.textField.wordWrap = false;
			labelCombo.labelFocus.textField.wordWrap = false;

			this.skin = skin;
			this.focusRect = false;
			this.debugLevel = (debugLevel == null) ? DebugLevel.NONE : debugLevel;
			this.debugColor = DisplayUtils.RED;

			button.addEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween);
			button.addEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween);
			button.addEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween);
			button.addEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween);
			button.addEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween);
			button.addEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween);

			var c:Object = (displayConfig == null) ? new Object() : displayConfig;

			if(c.width == undefined) c.width = skin.buttonSkin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.buttonSkin.bitmapSize.height;

			super(c, displayParent);
		}



		/**
		 * Destroys ImageLabelButton instance and frees it for GC.
		 */
		override public function destroy():void {
			DisplayUtils.removeChildren(this, button, imageCombo, labelCombo);

			button.removeEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween);
			button.removeEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween);
			button.removeEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween);
			button.removeEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween);
			button.removeEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween);
			button.removeEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween);

			button.forceRelease();

			button.destroy();
			imageCombo.destroy();
			labelCombo.destroy();

			super.destroy();

			button = null;
			imageCombo = null;
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
			imageCombo.draw();
			labelCombo.draw();
		}



		/**
		 * Release all buttons.
		 * Useful when dragging outside the main Stage.
		 */
		public static function releaseAll():void {
			ButtonCore.releaseAll();
		}



		/**
		 * Automagically set width.
		 * @param padding Padding
		 * @param max Max width before button gets wrapped
		 * @param morph true to use morphing (see {@see MorphSprite})
		 * @param morphAddons Additional parameters for morphing (see {@see MorphSprite})
		 */
		public function autoWidth(padding:Number, max:Number = 500, morph:Boolean = false, morphAddons:Object = null):void {
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
				_skin = ImageLabelButtonSkin(value);

				if(_skin.labelComboSkin.labelOutSkin.settings != null) {
					_skin.labelComboSkin.labelOutSkin.settings["hAlign"] = Align.LEFT;
				}

				if(_skin.labelComboSkin.labelHoverSkin.settings != null) {
					_skin.labelComboSkin.labelHoverSkin.settings["hAlign"] = Align.LEFT;
				}

				if(_skin.labelComboSkin.labelFocusSkin.settings != null) {
					_skin.labelComboSkin.labelFocusSkin.settings["hAlign"] = Align.LEFT;
				}

				button.skin = _skin.buttonSkin;
				imageCombo.skin = _skin.imageComboSkin;
				labelCombo.skin = _skin.labelComboSkin;
			}
		}



		override public function get width():Number {
			return button.width;
		}



		override public function set width(value:Number):void {
			labelCombo.width = 2000;

			var w:Number = labelCombo.width + imageCombo.width;

			labelCombo.width = w;
			button.width = value;
			imageCombo.x = Math.round((value - w) / 2);
			labelCombo.x = imageCombo.x + imageCombo.width;
		}



		override public function get height():Number {
			return button.height;
		}



		override public function set height(value:Number):void {
			button.height = value;

			imageCombo.y = Math.round((value - imageCombo.height) / 2);
			labelCombo.y = Math.round((value - labelCombo.height) / 2);
		}



		public function set areEventsEnabled(value:Boolean):void {
			button.areEventsEnabled = value;

			this.buttonMode = value;
			this.useHandCursor = value;
		}



		public function get areEventsEnabled():Boolean {
			return button.areEventsEnabled;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;

			button.debugLevel = value;
			imageCombo.debugLevel = value;
			labelCombo.debugLevel = value;
		}



		public function get debugColor():RGBA {
			return _debugColor;
		}



		public function set debugColor(value:RGBA):void {
			_debugColor = value;

			button.debugColor = value;
			imageCombo.debugColor = value;
			labelCombo.debugColor = value;
		}



		private function onButtonHoverInTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["hoverInDuration"];

				imageCombo.animateHoverIn(duration);
				labelCombo.animateHoverIn(duration);
			}
		}



		private function onButtonHoverOutTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["hoverOutDuration"];

				imageCombo.animateHoverOut(duration);
				labelCombo.animateHoverOut(duration);
			}
		}



		private function onButtonFocusInTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["focusInDuration"];

				imageCombo.animateFocusIn(duration);
				labelCombo.animateFocusIn(duration);
			}
		}



		private function onButtonDragConfirmedTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["hoverInDuration"];

				imageCombo.animateHoverIn(duration);
				labelCombo.animateHoverIn(duration);
			}
		}



		private function onButtonReleasedInsideTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["focusOutDuration"];

				imageCombo.animateFocusOut(duration);
				labelCombo.animateFocusOut(duration);
			}
		}



		private function onButtonReleasedOutsideTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["focusOutDuration"];

				imageCombo.animateFocusOut(duration);
				labelCombo.animateFocusOut(duration);
			}
		}
	}
}
