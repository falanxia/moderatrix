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
	import com.falanxia.moderatrix.enums.MouseStatus;
	import com.falanxia.moderatrix.events.ButtonEvent;
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.meta.GlyphButtonSkin;
	import com.falanxia.moderatrix.widgets.ButtonCore;
	import com.falanxia.moderatrix.widgets.Image;
	import com.falanxia.moderatrix.widgets.ScaleButton;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.utils.DisplayUtils;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;

	import flash.display.DisplayObjectContainer;



	public class GlyphButton extends MorphSprite implements IWidget {


		protected var _skin:GlyphButtonSkin;
		protected var _button:ScaleButton;
		protected var _glyphOut:Image;
		protected var _glyphHover:Image;
		protected var _glyphFocus:Image;

		private var _debugLevel:String;



		public function GlyphButton(skin:GlyphButtonSkin, displayConfig:Object = null, displayParent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			var c:Object = displayConfig == null ? new Object() : displayConfig;
			var dl:String = (debugLevel == null) ? SkinManager.defaultDebugLevel : debugLevel;

			_button = new ScaleButton(skin.buttonSkin, {}, this, dl);
			_glyphOut = new Image(skin.glyphSkin.glyphOutSkin, {mouseEnabled:false, mouseChildren:false}, this, dl);
			_glyphHover = new Image(skin.glyphSkin.glyphHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dl);
			_glyphFocus = new Image(skin.glyphSkin.glyphFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dl);
			_button.debugColor = SkinManager.defaultDebugColor;
			_glyphOut.debugColor = SkinManager.defaultDebugColor;
			_glyphHover.debugColor = SkinManager.defaultDebugColor;
			_glyphFocus.debugColor = SkinManager.defaultDebugColor;

			this.skin = skin;
			this.buttonMode = true;
			this.useHandCursor = true;
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
		 * Destroys GlyphButton instance and frees it for GC.
		 */
		override public function destroy():void {
			_button.removeEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween);
			_button.removeEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween);
			_button.removeEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween);
			_button.removeEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween);
			_button.removeEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween);
			_button.removeEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween);

			DisplayUtils.removeChildren(this, _button, _glyphOut, _glyphHover, _glyphFocus);

			forceRelease();

			_button.destroy();
			_glyphOut.destroy();
			_glyphHover.destroy();
			_glyphFocus.destroy();

			super.destroy();

			_skin = null;
			_button = null;
			_glyphOut = null;
			_glyphHover = null;
			_glyphFocus = null;
		}



		public function draw():void {
			_button.draw();
			_glyphOut.draw();
			_glyphHover.draw();
			_glyphFocus.draw();
		}



		public function forceRelease():void {
			_button.forceRelease();
		}



		public static function releaseAll():void {
			ButtonCore.releaseAll();
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
				_skin = GlyphButtonSkin(value);

				_button.skin = _skin.buttonSkin;

				if(_skin.glyphSkin != null) {
					_glyphOut.skin = _skin.glyphSkin.glyphOutSkin;
					_glyphHover.skin = _skin.glyphSkin.glyphHoverSkin;
					_glyphFocus.skin = _skin.glyphSkin.glyphFocusSkin;
				}
			}
		}



		override public function get width():Number {
			return _button.width;
		}



		override public function set width(value:Number):void {
			_button.width = value;
			_glyphOut.x = Math.round((value - _glyphOut.width) / 2);
			_glyphHover.x = Math.round((value - _glyphHover.width) / 2);
			_glyphFocus.x = Math.round((value - _glyphFocus.width) / 2);
		}



		override public function get height():Number {
			return _button.height;
		}



		override public function set height(value:Number):void {
			_button.height = value;
			_glyphOut.y = Math.round((value - _glyphOut.height) / 2);
			_glyphHover.y = Math.round((value - _glyphHover.height) / 2);
			_glyphFocus.y = Math.round((value - _glyphFocus.height) / 2);
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
			_glyphOut.debugLevel = value;
			_glyphHover.debugLevel = value;
			_glyphFocus.debugLevel = value;
		}



		public function get glyph():Image {
			var out:Image;

			if(_button.mouseStatus == MouseStatus.OUT) out = _glyphOut;
			if(_button.mouseStatus == MouseStatus.HOVER) out = _glyphHover;
			if(_button.mouseStatus == MouseStatus.FOCUS) out = _glyphFocus;

			return out;
		}



		public function get glyphOut():Image {
			return _glyphOut;
		}



		public function get glyphHover():Image {
			return _glyphHover;
		}



		public function get glyphFocus():Image {
			return _glyphFocus;
		}



		public function get button():ScaleButton {
			return _button;
		}



		private function onButtonHoverInTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var hoverInDuration:Number = _skin.buttonSkin.settings["hoverInDuration"];

				new TweenMax(_glyphOut, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(_glyphHover, hoverInDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(_glyphFocus, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonHoverOutTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var hoverOutDuration:Number = _skin.buttonSkin.settings["hoverOutDuration"];

				new TweenMax(_glyphOut, hoverOutDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(_glyphHover, hoverOutDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(_glyphFocus, hoverOutDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonFocusInTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var focusInDuration:Number = _skin.buttonSkin.settings["focusInDuration"];

				new TweenMax(_glyphOut, focusInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(_glyphHover, focusInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(_glyphFocus, focusInDuration, {alpha:1, ease:Cubic.easeOut});
			}
		}



		private function onButtonDragConfirmedTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var hoverInDuration:Number = _skin.buttonSkin.settings["hoverInDuration"];

				new TweenMax(_glyphOut, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(_glyphHover, hoverInDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(_glyphFocus, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonReleasedInsideTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var focusOutDuration:Number = _skin.buttonSkin.settings["focusOutDuration"];

				new TweenMax(_glyphOut, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(_glyphHover, focusOutDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(_glyphFocus, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonReleasedOutsideTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var focusOutDuration:Number = _skin.buttonSkin.settings["focusOutDuration"];

				new TweenMax(_glyphOut, focusOutDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(_glyphHover, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(_glyphFocus, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}
	}
}
