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
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObjectContainer;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;



	/** @todo Comment */
	public class ButtonCore extends Widget implements IWidget {


		private static var _currentDrag:ButtonCore;

		protected var _skin:ButtonSkin;
		protected var _activeSpr:QSprite;

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
			else throw new Error('No skin defined');

			this.skin = skin;

			_mouseStatus = MouseStatus.OUT;
		}



		/** @todo Comment */
		public function forceRelease():void {
			if(_mouseStatus == MouseStatus.FOCUS) {
				_currentDrag = null;
				_mouseStatus = MouseStatus.OUT;

				_releasedOutsideTween();

				var e:ButtonEvent = new ButtonEvent(ButtonEvent.RELEASE_OUTSIDE, true);
				dispatchEvent(e);
			}
		}



		/** @todo Comment */
		public static function releaseAll():void {
			for each(var b:* in _allWidgets) {
				if(b is ButtonCore) {
					(b as ButtonCore).forceRelease();
				}
			}
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		override public function set tabEnabled(enabled:Boolean):void {
			_activeSpr.tabEnabled = enabled;
		}



		/** @todo Comment */
		override public function set tabIndex(index:int):void {
			_activeSpr.tabIndex = index;
		}



		/** @todo Comment */
		override public function get tabIndex():int {
			return _activeSpr.tabIndex;
		}



		/** @todo Comment */
		public function get skin():ButtonSkin {
			return _skin;
		}



		/** @todo Comment */
		public function set skin(skin:ButtonSkin):void {
			_skin = skin as ButtonSkin;

			if(_size.width == 0) _size.width = _skin.assetSize.width;
			if(_size.height == 0) _size.height = _skin.assetSize.height;

			if(!_skin.assetSize.isEmpty()) size = _skin.assetSize;
		}



		/** @todo Comment */
		public function set areEventsEnabled(value:Boolean):void {
			_areEventsEnabled = value;

			_activeSpr.mouseEnabled = value;
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
					_onOut();
					break;

				case MouseStatus.HOVER:
					_onOver();
					break;

				case MouseStatus.FOCUS:
					_onFocus();
					break;

				default:
					throw new Error('Unknown mouse status (' + value + ')');
			}
		}



		/** @todo Comment */
		override public function get tabEnabled():Boolean {
			return _activeSpr.tabEnabled;
		}



		/* ★ PROTECTED METHODS ★ */


		/** @todo Comment */
		override protected function _addChildren():void {
			super._addChildren();

			_activeSpr = new QSprite({alpha:0}, _contentSpr);

			_activeSpr.addEventListener(MouseEvent.MOUSE_OVER, _onOver, false, 0, true);
			_activeSpr.addEventListener(MouseEvent.MOUSE_OUT, _onOut, false, 0, true);
			_activeSpr.addEventListener(MouseEvent.MOUSE_DOWN, _onFocus, false, 0, true);
			_activeSpr.addEventListener(MouseEvent.MOUSE_UP, _onRelease, false, 0, true);
			_activeSpr.addEventListener(FocusEvent.FOCUS_IN, _onFocusIn, false, 0, true);
			_activeSpr.addEventListener(FocusEvent.FOCUS_OUT, _onFocusOut, false, 0, true);
			_activeSpr.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown, false, 0, true);

			_activeSpr.tabEnabled = true;
			_activeSpr.focusRect = false;
			_activeSpr.buttonMode = true;

			DisplayUtils.drawRect(_activeSpr, new Rectangle(0, 0, 100, 100), new RGBA(255, 0, 0, 255));
		}



		/** @todo Comment */
		override protected function _removeChildren():void {
			super._removeChildren();

			_activeSpr.removeEventListener(MouseEvent.MOUSE_OVER, _onOver);
			_activeSpr.removeEventListener(MouseEvent.MOUSE_OUT, _onOut);
			_activeSpr.removeEventListener(MouseEvent.MOUSE_DOWN, _onFocus);
			_activeSpr.removeEventListener(MouseEvent.MOUSE_UP, _onRelease);
			_activeSpr.removeEventListener(FocusEvent.FOCUS_IN, _onFocusIn);
			_activeSpr.removeEventListener(FocusEvent.FOCUS_OUT, _onFocusOut);

			DisplayUtils.removeChildren(_contentSpr, _activeSpr);
		}



		/** @todo Comment */
		protected function _hoverInTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_IN_TWEEN, true));

			// duration: _skin.hoverInDuration
			// out -> hidden, sineIn
			// hover -> visible, easeOut
			// focus -> hidden, easeIn
		}



		/** @todo Comment */
		protected function _hoverOutTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_OUT_TWEEN, true));

			// duration: _skin.hoverOutDuration
			// out -> visible, easeOut
			// hover -> hidden, easeIn
			// focus -> hidden, easeIn
		}



		/** @todo Comment */
		protected function _focusInTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.FOCUS_IN_TWEEN, true));

			// duration: _skin.focusInDuration
			// out -> hidden, easeIn
			// hover -> hidden, easeIn
			// focus -> visible, easeOut
		}



		/** @todo Comment */
		protected function _dragConfirmedTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_CONFIRMED_TWEEN, true));

			// duration: _skin.hoverInDuration
			// out -> hidden, easeIn
			// hover -> visible, easeOut
			// focus -> hidden, easeIn
		}



		/** @todo Comment */
		protected function _releasedInsideTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.RELEASED_INSIDE_TWEEN, true));

			// duration: _skin.focusOutDuration
			// out -> hidden, easeIn
			// hover -> visible, easeOut
			// focus -> hidden, easeIn
		}



		/** @todo Comment */
		protected function _releasedOutsideTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.RELEASED_OUTSIDE_TWEEN, true));

			// duration: _skin.focusOutDuration
			// out -> visible, easeOut
			// hover -> hidden, easeIn
			// focus -> hidden, easeIn
		}



		/* ★ EVENT LISTENERS ★ */


		/** @todo Comment */
		private function _onOver(event:MouseEvent = null):void {
			if(_areEventsEnabled) {
				if(event != null && event.buttonDown) {
					// drag over
					dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_OVER, true));
				}
				else {
					// roll over
					_mouseStatus = MouseStatus.HOVER;
					_hoverInTween();
					dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_IN, true));
				}
			}
		}



		/** @todo Comment */
		private function _onOut(event:MouseEvent = null):void {
			if(_areEventsEnabled) {
				if(event != null && event.buttonDown) {
					// drag out
					dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_OUT, true));
				}
				else {
					// roll out
					_mouseStatus = MouseStatus.OUT;
					_hoverOutTween();
					dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_OUT, true));
				}
			}
		}



		/** @todo Comment */
		private function _onFocus(event:MouseEvent = null):void {
			if(_areEventsEnabled) {
				_mouseStatus = MouseStatus.FOCUS;
				_currentDrag = this;
				_focusInTween();
				if(stage != null) stage.addEventListener(MouseEvent.MOUSE_UP, _onRelease, false, 0, true);
				dispatchEvent(new ButtonEvent(ButtonEvent.FOCUS_IN, true));
			}
		}



		/** @todo Comment */
		private function _onRelease(event:MouseEvent = null):void {
			if(stage != null) stage.removeEventListener(MouseEvent.MOUSE_UP, _onRelease);

			if(_areEventsEnabled && _mouseStatus == MouseStatus.FOCUS) {
				if(event != null && event.currentTarget == stage) {
					// release outside
					forceRelease();
				}

				else if(_currentDrag != this) {
					// drag confirm
					_dragConfirmedTween();
					dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_CONFIRM, true));
				}

				else {
					// release inside
					_currentDrag = null;
					_releasedInsideTween();
					dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_INSIDE, true));
				}

				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true));
			}
		}



		/** @todo Comment */
		private function _onFocusIn(event:FocusEvent):void {
			_onOver();
		}



		/** @todo Comment */
		private function _onFocusOut(event:FocusEvent):void {
			_onOut();
		}



		/** @todo Comment */
		private function _onKeyDown(event:KeyboardEvent):void {
			// FIXME: Look for all events, like when mouse draggin is on etc.
			if(event.keyCode == 32 || event.keyCode == 13) dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_INSIDE, true));
		}
	}
}
