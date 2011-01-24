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
	import com.falanxia.moderatrix.skin.meta.CheckButtonSkin;
	import com.falanxia.moderatrix.widgets.ButtonCore;
	import com.falanxia.moderatrix.widgets.StaticButton;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;



	public class CheckButton extends MorphSprite implements IWidget {


		public var buttonOff:StaticButton;
		public var buttonOn:StaticButton;

		protected var _skin:CheckButtonSkin;

		private var _debugLevel:String;
		private var _debugColor:RGBA;
		private var _isChecked:Boolean;



		public function CheckButton(skin:CheckButtonSkin, displayConfig:Object = null, displayParent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			_skin = skin;

			buttonOff = new StaticButton(skin.buttonOffSkin, {}, this);
			buttonOn = new StaticButton(skin.buttonOnSkin, {visible:false}, this);

			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.isMorphHeightEnabled = false;
			this.isMorphWidthEnabled = false;
			this.debugLevel = (debugLevel == null) ? DebugLevel.NONE : debugLevel;
			this.debugColor = DisplayUtils.DEBUG_BLUE;

			buttonOff.addEventListener(ButtonEvent.RELEASE_INSIDE, onToggle);
			buttonOn.addEventListener(ButtonEvent.RELEASE_INSIDE, onToggle);

			var c:Object = displayConfig == null ? new Object() : displayConfig;

			if(c.width == undefined) c.width = skin.buttonOffSkin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.buttonOffSkin.bitmapSize.height;

			super(c, displayParent);

			draw();
		}



		/**
		 * Destroys CheckButton instance and frees it for GC.
		 */
		override public function destroy():void {
			DisplayUtils.removeChildren(this, buttonOff, buttonOn);

			buttonOff.removeEventListener(ButtonEvent.RELEASE_INSIDE, onToggle);
			buttonOn.removeEventListener(ButtonEvent.RELEASE_INSIDE, onToggle);
			removeEventListener(Event.ENTER_FRAME, onInvalidate);

			forceRelease();

			buttonOff.destroy();
			buttonOn.destroy();

			super.destroy();

			buttonOff = null;
			buttonOn = null;

			_skin = null;
			_debugLevel = null;
			_debugColor = null;
		}



		public function draw():void {
			buttonOff.visible = !_isChecked;
			buttonOn.visible = _isChecked;

			buttonOff.draw();
			buttonOn.draw();
		}



		public function forceRelease():void {
			buttonOff.forceRelease();
			buttonOn.forceRelease();
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
				_skin = CheckButtonSkin(value);

				buttonOff.skin = _skin.buttonOffSkin;
				buttonOn.skin = _skin.buttonOnSkin;
			}
		}



		public function get currentButton():StaticButton {
			return (_isChecked) ? buttonOn : buttonOff;
		}



		public function get isChecked():Boolean {
			return _isChecked;
		}



		public function set isChecked(value:Boolean):void {
			_isChecked = value;

			invalidate();
		}



		public function set areEventsEnabled(value:Boolean):void {
			buttonOff.areEventsEnabled = value;
			buttonOn.areEventsEnabled = value;

			this.buttonMode = value;
			this.useHandCursor = value;
		}



		public function get areEventsEnabled():Boolean {
			return buttonOff.areEventsEnabled;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;

			buttonOff.debugLevel = value;
			buttonOn.debugLevel = value;
		}



		public function get debugColor():RGBA {
			return _debugColor;
		}



		public function set debugColor(value:RGBA):void {
			_debugColor = value;

			buttonOff.debugColor = value;
			buttonOn.debugColor = value;
		}



		override public function get width():Number {
			return buttonOff.width;
		}



		override public function set width(value:Number):void {
		}



		override public function get height():Number {
			return buttonOff.height;
		}



		override public function set height(value:Number):void {
		}



		private function onToggle(e:ButtonEvent):void {
			isChecked = !isChecked;
		}



		protected function invalidate():void {
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}



		private function onInvalidate(e:Event):void {
			removeEventListener(Event.ENTER_FRAME, onInvalidate);

			draw();
		}
	}
}
