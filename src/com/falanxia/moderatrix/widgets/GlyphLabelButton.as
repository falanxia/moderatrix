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
	import com.falanxia.moderatrix.skin.*;
	import com.falanxia.utilitaris.display.*;
	import com.falanxia.utilitaris.enums.*;
	import com.falanxia.utilitaris.utils.*;
	import com.greensock.*;
	import com.greensock.easing.*;

	import flash.display.*;



	public class GlyphLabelButton extends MorphSprite {


		protected var _skin:GlyphLabelButtonSkin;
		protected var _button:ScaleButton;
		protected var _glyphOut:Image;
		protected var _glyphHover:Image;
		protected var _glyphFocus:Image;
		protected var _labelOut:Label;
		protected var _labelHover:Label;
		protected var _labelFocus:Label;

		private var _debugLevel:String;



		/**
		 * Create a new glyph label button instance.
		 * @param skin Skin to be used (use {@code GlyphLabelButtonSkin})
		 * @param config Configuration {@code Object}
		 * @param text Initial text
		 * @param parent Parent {@code DisplayObjectContainer}
		 * @param debugLevel Debug level ({@see DebugLevel})
		 * @throws Error if no skin defined
		 */
		public function GlyphLabelButton(skin:GlyphLabelButtonSkin, config:Object = null, text:String = "",
		                                 parent:DisplayObjectContainer = null, debugLevel:String = null) {
			var conf:Object = (config == null) ? new Object() : config;
			var dlev:String = (debugLevel == null) ? SkinManager.debugLevel : debugLevel;

			_button = new ScaleButton(skin.buttonSkin, {}, this, dlev);

			_glyphOut = new Image(skin.glyphSkin.glyphOutSkin, {mouseEnabled:false, mouseChildren:false}, this, dlev);
			_glyphHover = new Image(skin.glyphSkin.glyphHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dlev);
			_glyphFocus = new Image(skin.glyphSkin.glyphFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dlev);

			_labelOut = new Label(skin.labelOutSkin, {mouseEnabled:false, mouseChildren:false}, "", this, dlev);
			_labelHover = new Label(skin.labelHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, "", this, dlev);
			_labelFocus = new Label(skin.labelFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, "", this, dlev);

			_labelOut.textField.wordWrap = false;
			_labelHover.textField.wordWrap = false;
			_labelFocus.textField.wordWrap = false;

			_button.debugColor = SkinManager.debugColor;
			_glyphOut.debugColor = SkinManager.debugColor;
			_glyphHover.debugColor = SkinManager.debugColor;
			_glyphFocus.debugColor = SkinManager.debugColor;
			_labelOut.debugColor = SkinManager.debugColor;
			_labelHover.debugColor = SkinManager.debugColor;
			_labelFocus.debugColor = SkinManager.debugColor;

			this.skin = skin;
			this.text = text;
			this.focusRect = false;

			_button.addEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween, false, 0, true);
			_button.addEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween, false, 0, true);
			_button.addEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween, false, 0, true);
			_button.addEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween, false, 0, true);
			_button.addEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween, false, 0, true);
			_button.addEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween, false, 0, true);

			if(conf.width == undefined) conf.width = skin.buttonSkin.assetSize.width;
			if(conf.height == undefined) conf.height = skin.buttonSkin.assetSize.height;

			//noinspection NegatedIfStatementJS
			if(skin != null) {
				super(conf, parent);
			}
			else {
				throw new Error("No skin defined");
			}

			_skin = skin;
		}



		/**
		 * Destroys {@code GlyphLabelButton} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_button.forceRelease();

			_button.removeEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween);
			_button.removeEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween);
			_button.removeEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween);
			_button.removeEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween);
			_button.removeEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween);
			_button.removeEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween);

			DisplayUtils.removeChildren(this, _button, _glyphOut, _glyphHover, _glyphFocus, _labelOut, _labelHover, _labelFocus);

			_button.destroy();
			_glyphOut.destroy();
			_glyphHover.destroy();
			_glyphFocus.destroy();
			_labelOut.destroy();
			_labelHover.destroy();
			_labelFocus.destroy();

			_skin = null;
			_button = null;
			_glyphOut = null;
			_glyphHover = null;
			_glyphFocus = null;
			_labelOut = null;
			_labelHover = null;
			_labelFocus = null;
			_debugLevel = null;
		}



		/**
		 * Draw the widget.
		 */
		public function draw():void {
			_button.draw();
			_glyphOut.draw();
			_glyphHover.draw();
			_glyphFocus.draw();
			_labelOut.draw();
			_labelHover.draw();
			_labelFocus.draw();
		}



		/**
		 * Release all buttons.
		 * Useful when dragging outside the main {@code Stage}.
		 */
		public static function releaseAll():void {
			ButtonCore.releaseAll();
		}



		/**
		 * Automagically set width.
		 * @param padding Padding
		 * @param max Max width before button gets wrapped
		 * @param morph {@code true} to use morphing (see {@see MorphSprite})
		 * @param morphAddons Additional parameters for morphing (see {@see MorphSprite})
		 */
		public function autoWidth(padding:Number, max:Number = 500, morph:Boolean = false, morphAddons:Object = null):void {
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



		public function get skin():GlyphLabelButtonSkin {
			return _skin;
		}



		public function set skin(value:GlyphLabelButtonSkin):void {
			_skin = value;

			_skin.labelOutSkin.hAlign = Align.LEFT;
			_skin.labelHoverSkin.hAlign = Align.LEFT;
			_skin.labelFocusSkin.hAlign = Align.LEFT;

			_button.skin = _skin.buttonSkin;
			_glyphOut.skin = _skin.glyphSkin.glyphOutSkin;
			_glyphHover.skin = _skin.glyphSkin.glyphHoverSkin;
			_glyphFocus.skin = _skin.glyphSkin.glyphFocusSkin;
			_labelOut.skin = _skin.labelOutSkin;
			_labelHover.skin = _skin.labelHoverSkin;
			_labelFocus.skin = _skin.labelFocusSkin;
		}



		override public function get width():Number {
			return _button.width;
		}



		override public function set width(value:Number):void {
			_labelOut.width = 2000;
			_labelHover.width = 2000;
			_labelFocus.width = 2000;

			var labelOutWidth:Number = _labelOut.width;
			var labelHoverWidth:Number = _labelHover.width;
			var labelFocusWidth:Number = _labelFocus.width;
			var outWidth:Number = _glyphOut.width + labelOutWidth;
			var hoverWidth:Number = _glyphHover.width + labelHoverWidth;
			var focusWidth:Number = _glyphFocus.width + labelFocusWidth;
			var maxWidth:Number = Math.max(outWidth, hoverWidth, focusWidth);
			var labelWidth:Number = Math.max(labelOutWidth, labelHoverWidth, labelFocusWidth) + 10;

			_labelOut.width = labelWidth;
			_labelHover.width = labelWidth;
			_labelFocus.width = labelWidth;

			_button.width = value;

			_glyphOut.x = int((value - maxWidth) / 2);
			_glyphHover.x = int((value - maxWidth) / 2);
			_glyphFocus.x = int((value - maxWidth) / 2);

			_labelOut.x = _glyphOut.x + _glyphOut.width;
			_labelHover.x = _glyphHover.x + _glyphHover.width;
			_labelFocus.x = _glyphFocus.x + _glyphFocus.width;
		}



		override public function get height():Number {
			return _button.height;
		}



		override public function set height(value:Number):void {
			_button.height = value;

			_glyphOut.y = int((value - _glyphOut.height) / 2);
			_glyphHover.y = int((value - _glyphHover.height) / 2);
			_glyphFocus.y = int((value - _glyphFocus.height) / 2);

			_labelOut.y = int((value - _labelOut.height) / 2);
			_labelHover.y = int((value - _labelHover.height) / 2);
			_labelFocus.y = int((value - _labelFocus.height) / 2);
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
			new TweenLite(_glyphOut, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphHover, _skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_glyphFocus, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			new TweenLite(_labelOut, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelHover, _skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_labelFocus, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function onButtonHoverOutTween(e:ButtonEvent):void {
			new TweenLite(_glyphOut, _skin.buttonSkin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_glyphHover, _skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphFocus, _skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});

			new TweenLite(_labelOut, _skin.buttonSkin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_labelHover, _skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelFocus, _skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function onButtonFocusInTween(e:ButtonEvent):void {
			new TweenLite(_glyphOut, _skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphHover, _skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphFocus, _skin.buttonSkin.focusInDuration, {alpha:1, ease:Sine.easeOut});

			new TweenLite(_labelOut, _skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelHover, _skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelFocus, _skin.buttonSkin.focusInDuration, {alpha:1, ease:Sine.easeOut});
		}



		private function onButtonDragConfirmedTween(e:ButtonEvent):void {
			new TweenLite(_glyphOut, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphHover, _skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_glyphFocus, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			new TweenLite(_labelOut, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelHover, _skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_labelFocus, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function onButtonReleasedInsideTween(e:ButtonEvent):void {
			new TweenLite(_glyphOut, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphHover, _skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_glyphFocus, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			new TweenLite(_labelOut, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelHover, _skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_labelFocus, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function onButtonReleasedOutsideTween(e:ButtonEvent):void {
			new TweenLite(_glyphOut, _skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_glyphHover, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphFocus, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			new TweenLite(_labelOut, _skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_labelHover, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelFocus, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}
	}
}
