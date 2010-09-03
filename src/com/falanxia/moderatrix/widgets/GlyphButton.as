/*
 * Falanxia Moderatrix.
 *
 * Copyright (c) 2010 Falanxia (http://falanxia.com)
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
	import com.falanxia.moderatrix.enums.*;
	import com.falanxia.moderatrix.events.*;
	import com.falanxia.moderatrix.globals.*;
	import com.falanxia.moderatrix.interfaces.*;
	import com.falanxia.moderatrix.skin.meta.*;
	import com.falanxia.utilitaris.display.*;
	import com.falanxia.utilitaris.utils.*;
	import com.greensock.*;
	import com.greensock.easing.*;

	import flash.display.*;



	public class GlyphButton extends MorphSprite implements IWidget {


		protected var _skin:GlyphButtonSkin;
		protected var _button:ScaleButton;
		protected var _glyphOut:Image;
		protected var _glyphHover:Image;
		protected var _glyphFocus:Image;

		private var _debugLevel:String;



		public function GlyphButton(skin:GlyphButtonSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object;

			if(config == null) {
				c = new Object();
			}
			else {
				c = config;
			}

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

			_button.addEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween, false, 0, true);
			_button.addEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween, false, 0, true);
			_button.addEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween, false, 0, true);
			_button.addEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween, false, 0, true);
			_button.addEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween, false, 0, true);
			_button.addEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween, false, 0, true);

			if(c.width == undefined) c.width = skin.buttonSkin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.buttonSkin.bitmapSize.height;

			//noinspection NegatedIfStatementJS
			if(skin != null) {
				super(c, parent);
			}
			else {
				throw new Error("No skin defined");
			}

			_skin = skin;
		}



		/**
		 * Destroys GlyphButton instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			forceRelease();

			// removeChildren();
			// was removed due to multiple item removal
			// TODO: Test if it's needed

			_button.destroy();
			_glyphOut.destroy();
			_glyphHover.destroy();
			_glyphFocus.destroy();

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



		public function get skin():GlyphButtonSkin {
			return _skin;
		}



		public function set skin(skin:GlyphButtonSkin):void {
			_skin = skin;

			_button.skin = _skin.buttonSkin;
			_glyphOut.skin = _skin.glyphSkin.glyphOutSkin;
			_glyphHover.skin = _skin.glyphSkin.glyphHoverSkin;
			_glyphFocus.skin = _skin.glyphSkin.glyphFocusSkin;
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



		private function removeChildren():void {
			_button.removeEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween);
			_button.removeEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween);
			_button.removeEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween);
			_button.removeEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween);
			_button.removeEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween);
			_button.removeEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween);

			DisplayUtils.removeChildren(this, _button, _glyphOut, _glyphHover, _glyphFocus);
		}



		private function onButtonHoverInTween(e:ButtonEvent):void {
			var hoverInDuration:Number = _skin.buttonSkin.settings["hoverInDuration"];

			new TweenLite(_glyphOut, hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphHover, hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_glyphFocus, hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function onButtonHoverOutTween(e:ButtonEvent):void {
			var hoverOutDuration:Number = _skin.buttonSkin.settings["hoverOutDuration"];

			new TweenLite(_glyphOut, hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_glyphHover, hoverOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphFocus, hoverOutDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function onButtonFocusInTween(e:ButtonEvent):void {
			var focusInDuration:Number = _skin.buttonSkin.settings["focusInDuration"];

			new TweenLite(_glyphOut, focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphHover, focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphFocus, focusInDuration, {alpha:1, ease:Sine.easeOut});
		}



		private function onButtonDragConfirmedTween(e:ButtonEvent):void {
			var hoverInDuration:Number = _skin.buttonSkin.settings["hoverInDuration"];

			new TweenLite(_glyphOut, hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphHover, hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_glyphFocus, hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function onButtonReleasedInsideTween(e:ButtonEvent):void {
			var focusOutDuration:Number = _skin.buttonSkin.settings["focusOutDuration"];

			new TweenLite(_glyphOut, focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphHover, focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_glyphFocus, focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function onButtonReleasedOutsideTween(e:ButtonEvent):void {
			var focusOutDuration:Number = _skin.buttonSkin.settings["focusOutDuration"];

			new TweenLite(_glyphOut, focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_glyphHover, focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphFocus, focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}
	}
}
