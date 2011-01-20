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
	import com.falanxia.moderatrix.skin.meta.ImageButtonSkin;
	import com.falanxia.moderatrix.widgets.ButtonCore;
	import com.falanxia.moderatrix.widgets.ScaleButton;
	import com.falanxia.moderatrix.widgets.combos.ImageCombo;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObjectContainer;



	public class ImageButton extends MorphSprite implements IWidget {


		public var button:ScaleButton;
		public var imageCombo:ImageCombo;

		protected var _skin:ImageButtonSkin;

		private var _debugLevel:String;
		private var _debugColor:RGBA;



		public function ImageButton(skin:ImageButtonSkin, displayConfig:Object = null, displayParent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			button = new ScaleButton(skin.buttonSkin, {}, this);
			imageCombo = new ImageCombo(skin.imageComboSkin, {mouseEnabled:false, mouseChildren:false}, this);

			this.skin = skin;
			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.debugLevel = (debugLevel == null) ? DebugLevel.NONE : debugLevel;
			this.debugColor = DisplayUtils.RED;

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
		 * Destroys ImageButton instance and frees it for GC.
		 */
		override public function destroy():void {
			DisplayUtils.removeChildren(this, button, imageCombo);

			button.removeEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween);
			button.removeEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween);
			button.removeEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween);
			button.removeEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween);
			button.removeEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween);
			button.removeEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween);

			forceRelease();

			button.destroy();
			imageCombo.destroy();

			super.destroy();

			button = null;
			imageCombo = null;

			_skin = null;
			_debugLevel = null;
			_debugColor = null;
		}



		public function draw():void {
			button.draw();
			imageCombo.draw();
		}



		public function forceRelease():void {
			button.forceRelease();
		}



		public static function releaseAll():void {
			ButtonCore.releaseAll();
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
				_skin = ImageButtonSkin(value);

				button.skin = _skin.buttonSkin;

				if(_skin.imageComboSkin != null) {
					imageCombo.skin = _skin.imageComboSkin;
				}
			}
		}



		override public function get width():Number {
			return button.width;
		}



		override public function set width(value:Number):void {
			button.width = value;
			imageCombo.x = Math.round((value - imageCombo.width) / 2);
		}



		override public function get height():Number {
			return button.height;
		}



		override public function set height(value:Number):void {
			button.height = value;
			imageCombo.y = Math.round((value - imageCombo.height) / 2);
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
		}



		public function get debugColor():RGBA {
			return _debugColor;
		}



		public function set debugColor(value:RGBA):void {
			_debugColor = value;

			button.debugColor = value;
			button.debugColor = value;
			button.debugColor = value;
		}



		private function onButtonHoverInTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["hoverInDuration"];

				imageCombo.animateHoverIn(duration);
			}
		}



		private function onButtonHoverOutTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["hoverOutDuration"];

				imageCombo.animateHoverOut(duration);
			}
		}



		private function onButtonFocusInTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["focusInDuration"];

				imageCombo.animateFocusIn(duration);
			}
		}



		private function onButtonDragConfirmedTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["hoverInDuration"];

				imageCombo.animateHoverIn(duration);
			}
		}



		private function onButtonReleasedInsideTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["focusOutDuration"];

				imageCombo.animateHoverOut(duration);
			}
		}



		private function onButtonReleasedOutsideTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var duration:Number = _skin.buttonSkin.settings["focusOutDuration"];

				imageCombo.animateFocusOut(duration);
			}
		}
	}
}
