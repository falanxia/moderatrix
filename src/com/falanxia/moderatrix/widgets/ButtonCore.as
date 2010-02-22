// Falanxia Moderatrix.
//
// Copyright (c) 2010 Falanxia (http://falanxia.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

package com.falanxia.moderatrix.widgets {
	import com.falanxia.moderatrix.constants.MouseStatus;
	import com.falanxia.moderatrix.events.ButtonEvent;
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.ButtonSkin;
	import com.falanxia.utilitaris.display.QSprite;
	import com.falanxia.utilitaris.helpers.printf;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObjectContainer;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;



	/** @todo Comment */
	public class ButtonCore extends Widget implements IWidget {


		private static var currentDrag:ButtonCore;

		protected var _skin:ButtonSkin;

		protected var activeSpr:QSprite;

		private var _mouseStatus:String;
		private var _areEventsEnabled:Boolean = true;



		/** @todo Comment */
		public function ButtonCore(skin:ButtonSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                           debugLevel:String = null) {
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			if(c.width == undefined) c.width = skin.assetSize.width;
			if(c.height == undefined) c.height = skin.assetSize.height;

			//noinspection NegatedIfStatementJS
			if(skin != null) super(c, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
			else throw new Error("No skin defined");

			this.skin = skin;

			_mouseStatus = MouseStatus.OUT;
		}



		/** @todo Comment */
		public function forceRelease():void {
			if(_mouseStatus == MouseStatus.FOCUS) {
				currentDrag = null;
				_mouseStatus = MouseStatus.OUT;

				releasedOutsideTween();

				var e:ButtonEvent = new ButtonEvent(ButtonEvent.RELEASE_OUTSIDE, true);
				dispatchEvent(e);
			}
		}



		/** @todo Comment */
		public static function releaseAll():void {
			for each(var b:* in allWidgets) {
				if(b is ButtonCore) {
					ButtonCore(b).forceRelease();
				}
			}
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		override public function set tabEnabled(enabled:Boolean):void {
			activeSpr.tabEnabled = enabled;
		}



		/** @todo Comment */
		override public function set tabIndex(index:int):void {
			activeSpr.tabIndex = index;
		}



		/** @todo Comment */
		override public function get tabIndex():int {
			return activeSpr.tabIndex;
		}



		/** @todo Comment */
		public function get skin():ButtonSkin {
			return _skin;
		}



		/** @todo Comment */
		public function set skin(skin:ButtonSkin):void {
			_skin = ButtonSkin(skin);

			if(_size.width == 0) _size.width = _skin.assetSize.width;
			if(_size.height == 0) _size.height = _skin.assetSize.height;

			if(!_skin.assetSize.isEmpty()) size = _skin.assetSize;
		}



		/** @todo Comment */
		public function set areEventsEnabled(value:Boolean):void {
			_areEventsEnabled = value;

			activeSpr.mouseEnabled = value;
			this.buttonMode = value;
			this.useHandCursor = value;

			if(!value) {
				forceRelease();
			}
		}



		/** @todo Comment */
		public function get areEventsEnabled():Boolean {
			return _areEventsEnabled;
		}



		/** @todo Comment */
		public function get mouseStatus():String {
			return _mouseStatus;
		}



		/** @todo Comment */
		public function set mouseStatus(value:String):void {
			switch(value) {
				case MouseStatus.OUT:
					onOut();
					break;

				case MouseStatus.HOVER:
					onOver();
					break;

				case MouseStatus.FOCUS:
					onFocus();
					break;

				default:
					throw new Error(printf("Unknown mouse status (%s)", value));
			}
		}



		/** @todo Comment */
		override public function get tabEnabled():Boolean {
			return activeSpr.tabEnabled;
		}



		/* ★ PROTECTED METHODS ★ */


		/** @todo Comment */
		override protected function addChildren():void {
			super.addChildren();

			activeSpr = new QSprite({alpha:0}, contentSpr);

			activeSpr.addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			activeSpr.addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
			activeSpr.addEventListener(MouseEvent.MOUSE_DOWN, onFocus, false, 0, true);
			activeSpr.addEventListener(MouseEvent.MOUSE_UP, onRelease, false, 0, true);
			activeSpr.addEventListener(FocusEvent.FOCUS_IN, onFocusIn, false, 0, true);
			activeSpr.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut, false, 0, true);
			activeSpr.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);

			activeSpr.tabEnabled = true;
			activeSpr.focusRect = false;
			activeSpr.buttonMode = true;

			DisplayUtils.drawRect(activeSpr, new Rectangle(0, 0, 100, 100), new RGBA(255, 0, 0, 255));
		}



		/** @todo Comment */
		override protected function removeChildren():void {
			super.removeChildren();

			activeSpr.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			activeSpr.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			activeSpr.removeEventListener(MouseEvent.MOUSE_DOWN, onFocus);
			activeSpr.removeEventListener(MouseEvent.MOUSE_UP, onRelease);
			activeSpr.removeEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			activeSpr.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);

			DisplayUtils.removeChildren(contentSpr, activeSpr);
		}



		/** @todo Comment */
		protected function hoverInTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_IN_TWEEN, true));

			// duration: _skin.hoverInDuration
			// out -> hidden, sineIn
			// hover -> visible, easeOut
			// focus -> hidden, easeIn
		}



		/** @todo Comment */
		protected function hoverOutTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_OUT_TWEEN, true));

			// duration: _skin.hoverOutDuration
			// out -> visible, easeOut
			// hover -> hidden, easeIn
			// focus -> hidden, easeIn
		}



		/** @todo Comment */
		protected function focusInTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.FOCUS_IN_TWEEN, true));

			// duration: _skin.focusInDuration
			// out -> hidden, easeIn
			// hover -> hidden, easeIn
			// focus -> visible, easeOut
		}



		/** @todo Comment */
		protected function dragConfirmedTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_CONFIRMED_TWEEN, true));

			// duration: _skin.hoverInDuration
			// out -> hidden, easeIn
			// hover -> visible, easeOut
			// focus -> hidden, easeIn
		}



		/** @todo Comment */
		protected function releasedInsideTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.RELEASED_INSIDE_TWEEN, true));

			// duration: _skin.focusOutDuration
			// out -> hidden, easeIn
			// hover -> visible, easeOut
			// focus -> hidden, easeIn
		}



		/** @todo Comment */
		protected function releasedOutsideTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.RELEASED_OUTSIDE_TWEEN, true));

			// duration: _skin.focusOutDuration
			// out -> visible, easeOut
			// hover -> hidden, easeIn
			// focus -> hidden, easeIn
		}



		/* ★ EVENT LISTENERS ★ */


		/** @todo Comment */
		private function onOver(event:MouseEvent = null):void {
			if(_areEventsEnabled) {
				if(event != null && event.buttonDown) {
					// drag over
					dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_OVER, true));
				}
				else {
					// roll over
					_mouseStatus = MouseStatus.HOVER;
					hoverInTween();
					dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_IN, true));
				}
			}
		}



		/** @todo Comment */
		private function onOut(event:MouseEvent = null):void {
			if(_areEventsEnabled) {
				if(event != null && event.buttonDown) {
					// drag out
					dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_OUT, true));
				}
				else {
					// roll out
					_mouseStatus = MouseStatus.OUT;
					hoverOutTween();
					dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_OUT, true));
				}
			}
		}



		/** @todo Comment */
		private function onFocus(event:MouseEvent = null):void {
			if(_areEventsEnabled) {
				_mouseStatus = MouseStatus.FOCUS;
				currentDrag = this;
				focusInTween();
				if(stage != null) stage.addEventListener(MouseEvent.MOUSE_UP, onRelease, false, 0, true);
				dispatchEvent(new ButtonEvent(ButtonEvent.FOCUS_IN, true));
			}
		}



		/** @todo Comment */
		private function onRelease(event:MouseEvent = null):void {
			if(stage != null) stage.removeEventListener(MouseEvent.MOUSE_UP, onRelease);

			if(_areEventsEnabled && _mouseStatus == MouseStatus.FOCUS) {
				if(event != null && event.currentTarget == stage) {
					// release outside
					forceRelease();
				}

				else if(currentDrag != this) {
					// drag confirm
					dragConfirmedTween();
					dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_CONFIRM, true));
				}

				else {
					// release inside
					currentDrag = null;
					releasedInsideTween();
					dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_INSIDE, true));
				}

				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true));
			}
		}



		/** @todo Comment */
		private function onFocusIn(event:FocusEvent):void {
			onOver();
		}



		/** @todo Comment */
		private function onFocusOut(event:FocusEvent):void {
			onOut();
		}



		/** @todo Comment */
		private function onKeyDown(event:KeyboardEvent):void {
			// FIXME: Look for all events, like when mouse draggin is on etc.
			if(event.keyCode == 32 || event.keyCode == 13) dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_INSIDE, true));
		}
	}
}
