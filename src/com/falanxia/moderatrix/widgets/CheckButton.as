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
	import com.falanxia.moderatrix.events.*;
	import com.falanxia.moderatrix.globals.*;
	import com.falanxia.moderatrix.interfaces.*;
	import com.falanxia.moderatrix.skin.*;
	import com.falanxia.utilitaris.display.*;
	import com.falanxia.utilitaris.utils.*;

	import flash.display.*;



	/**
	 * TODO: Documentation
	 */
	public class CheckButton extends MorphSprite implements IWidget {


		protected var _skin:CheckButtonSkin;
		protected var _buttonOff:StaticButton;
		protected var _buttonOn:StaticButton;

		private var _debugLevel:String;
		private var _isChecked:Boolean;



		/**
		 * TODO: Documentation
		 * @param skin
		 * @param config
		 * @param parent
		 * @param debugLevel
		 */
		public function CheckButton(skin:CheckButtonSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			var c:Object;

			if(config == null) {
				c = new Object();
			}
			else {
				c = config;
			}

			var dl:String = (debugLevel == null) ? SkinManager.debugLevel : debugLevel;

			_buttonOff = new StaticButton(skin.buttonOffSkin, {}, this, dl);
			_buttonOn = new StaticButton(skin.buttonOnSkin, {visible:false}, this, dl);

			_buttonOff.debugColor = SkinManager.debugColor;
			_buttonOn.debugColor = SkinManager.debugColor;

			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.isMorphHeightEnabled = false;
			this.isMorphWidthEnabled = false;

			_buttonOff.addEventListener(ButtonEvent.RELEASE_INSIDE, onToggle, false, 0, true);
			_buttonOn.addEventListener(ButtonEvent.RELEASE_INSIDE, onToggle, false, 0, true);

			if(c.width == undefined) c.width = skin.buttonOffSkin.assetSize.width;
			if(c.height == undefined) c.height = skin.buttonOffSkin.assetSize.height;

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
		 * Destroys {@code CheckButton} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			forceRelease();
			removeChildren();

			_buttonOff.destroy();
			_buttonOn.destroy();

			_skin = null;
			_buttonOff = null;
			_buttonOn = null;
			_debugLevel = null;
		}



		/**
		 * TODO: Documentation
		 */
		public function draw():void {
			_buttonOff.draw();
			_buttonOn.draw();

			_buttonOff.visible = !_isChecked;
			_buttonOn.visible = _isChecked;
		}



		/**
		 * TODO: Documentation
		 */
		public function forceRelease():void {
			_buttonOff.forceRelease();
			_buttonOn.forceRelease();
		}



		/**
		 * TODO: Documentation
		 */
		public static function releaseAll():void {
			ButtonCore.releaseAll();
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		override public function get tabEnabled():Boolean {
			return button.tabEnabled;
		}



		/**
		 * TODO: Documentation
		 * @param enabled
		 */
		override public function set tabEnabled(enabled:Boolean):void {
			button.tabEnabled = enabled;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		override public function get tabIndex():int {
			return button.tabIndex;
		}



		/**
		 * TODO: Documentation
		 * @param index
		 */
		override public function set tabIndex(index:int):void {
			button.tabIndex = index;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		override public function get width():Number {
			return _buttonOff.width;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		override public function set width(value:Number):void {
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		override public function get height():Number {
			return _buttonOff.height;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		override public function set height(value:Number):void {
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set areEventsEnabled(value:Boolean):void {
			_buttonOff.areEventsEnabled = value;
			_buttonOn.areEventsEnabled = value;

			this.buttonMode = value;
			this.useHandCursor = value;

			draw();
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get areEventsEnabled():Boolean {
			return _buttonOff.areEventsEnabled;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get mouseStatus():String {
			return button.mouseStatus;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set mouseStatus(value:String):void {
			button.mouseStatus = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get debugLevel():String {
			return _debugLevel;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set debugLevel(value:String):void {
			_debugLevel = value;

			_buttonOff.debugLevel = value;
			_buttonOn.debugLevel = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get isChecked():Boolean {
			return _isChecked;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set isChecked(value:Boolean):void {
			_isChecked = value;
			draw();
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get skin():CheckButtonSkin {
			return _skin;
		}



		/**
		 * TODO: Documentation
		 * @param skin
		 */
		public function set skin(skin:CheckButtonSkin):void {
			_skin = skin;

			_buttonOff.skin = skin.buttonOffSkin;
			_buttonOn.skin = skin.buttonOnSkin;

			draw();
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get button():StaticButton {
			return (_isChecked) ? _buttonOn : _buttonOff;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get buttonOff():StaticButton {
			return _buttonOff;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get buttonOn():StaticButton {
			return _buttonOn;
		}



		private function removeChildren():void {
			_buttonOff.removeEventListener(ButtonEvent.RELEASE_INSIDE, onToggle);
			_buttonOn.removeEventListener(ButtonEvent.RELEASE_INSIDE, onToggle);

			DisplayUtils.removeChildren(this, _buttonOff, _buttonOn);
		}



		private function onToggle(e:ButtonEvent):void {
			isChecked = !isChecked;
		}
	}
}
