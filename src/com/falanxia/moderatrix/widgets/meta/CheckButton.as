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
	import com.falanxia.moderatrix.events.ButtonEvent;
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.meta.CheckButtonSkin;
	import com.falanxia.moderatrix.widgets.ButtonCore;
	import com.falanxia.moderatrix.widgets.StaticButton;
	import com.falanxia.utilitaris.display.MorphSprite;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;



	public class CheckButton extends MorphSprite implements IWidget {


		protected var _skin:CheckButtonSkin;
		protected var _buttonOff:StaticButton;
		protected var _buttonOn:StaticButton;

		private var _debugLevel:String;
		private var _isChecked:Boolean;



		public function CheckButton(skin:CheckButtonSkin, displayConfig:Object = null, displayParent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			var c:Object = displayConfig == null ? new Object() : displayConfig;
			var dl:String = (debugLevel == null) ? SkinManager.defaultDebugLevel : debugLevel;

			_buttonOff = new StaticButton(skin.buttonOffSkin, {}, this, dl);
			_buttonOn = new StaticButton(skin.buttonOnSkin, {visible:false}, this, dl);

			_buttonOff.debugColor = SkinManager.defaultDebugColor;
			_buttonOn.debugColor = SkinManager.defaultDebugColor;

			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.isMorphHeightEnabled = false;
			this.isMorphWidthEnabled = false;

			_buttonOff.addEventListener(ButtonEvent.RELEASE_INSIDE, onToggle);
			_buttonOn.addEventListener(ButtonEvent.RELEASE_INSIDE, onToggle);

			if(c.width == undefined) c.width = skin.buttonOffSkin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.buttonOffSkin.bitmapSize.height;

			super(c, displayParent);

			_skin = skin;
		}



		/**
		 * Destroys CheckButton instance and frees it for GC.
		 */
		override public function destroy():void {
			_buttonOff.removeEventListener(ButtonEvent.RELEASE_INSIDE, onToggle);
			_buttonOn.removeEventListener(ButtonEvent.RELEASE_INSIDE, onToggle);
			removeEventListener(Event.ENTER_FRAME, onInvalidate);

			forceRelease();

			_buttonOff.destroy();
			_buttonOn.destroy();

			super.destroy();

			_skin = null;
			_buttonOff = null;
			_buttonOn = null;
			_debugLevel = null;
		}



		public function draw():void {
			_buttonOff.visible = !_isChecked;
			_buttonOn.visible = _isChecked;

			_buttonOff.draw();
			_buttonOn.draw();
		}



		public function forceRelease():void {
			_buttonOff.forceRelease();
			_buttonOn.forceRelease();
		}



		public static function releaseAll():void {
			ButtonCore.releaseAll();
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



		override public function get width():Number {
			return _buttonOff.width;
		}



		override public function set width(value:Number):void {
		}



		override public function get height():Number {
			return _buttonOff.height;
		}



		override public function set height(value:Number):void {
		}



		public function set areEventsEnabled(value:Boolean):void {
			_buttonOff.areEventsEnabled = value;
			_buttonOn.areEventsEnabled = value;

			this.buttonMode = value;
			this.useHandCursor = value;
		}



		public function get areEventsEnabled():Boolean {
			return _buttonOff.areEventsEnabled;
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

			_buttonOff.debugLevel = value;
			_buttonOn.debugLevel = value;
		}



		public function get isChecked():Boolean {
			return _isChecked;
		}



		public function set isChecked(value:Boolean):void {
			_isChecked = value;

			invalidate();
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

				_buttonOff.skin = _skin.buttonOffSkin;
				_buttonOn.skin = _skin.buttonOnSkin;
			}
		}



		public function get button():StaticButton {
			return (_isChecked) ? _buttonOn : _buttonOff;
		}



		public function get buttonOff():StaticButton {
			return _buttonOff;
		}



		public function get buttonOn():StaticButton {
			return _buttonOn;
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
