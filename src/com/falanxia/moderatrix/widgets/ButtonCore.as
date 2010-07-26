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
	import com.falanxia.moderatrix.skin.*;
	import com.falanxia.utilitaris.display.*;
	import com.falanxia.utilitaris.helpers.*;
	import com.falanxia.utilitaris.types.*;
	import com.falanxia.utilitaris.utils.*;

	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;



	public class ButtonCore extends Widget implements IWidget {


		private static var currentDrag:ButtonCore;

		protected var _skin:ButtonSkin;

		protected var activeSpr:QSprite;

		private var _mouseStatus:String;
		private var _areEventsEnabled:Boolean = true;



		public function ButtonCore(skin:ButtonSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object;

			if(config == null) {
				c = new Object();
			}
			else {
				c = config;
			}

			if(c.width == undefined) c.width = skin.assetSize.width;
			if(c.height == undefined) c.height = skin.assetSize.height;

			//noinspection NegatedIfStatementJS
			if(skin != null) {
				super(c, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
			}
			else {
				throw new Error("No skin defined");
			}

			this.skin = skin;

			_mouseStatus = MouseStatus.OUT;
		}



		/**
		 * Destroys {@code ButtonCore} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			forceRelease();

			// removeChildren();
			// was removed due to multiple item removal
			// TODO: Test if it's needed

			if(stage != null) stage.removeEventListener(MouseEvent.MOUSE_UP, onRelease);

			activeSpr.destroy();

			_skin = null;
			activeSpr = null;
			_mouseStatus = null;
		}



		public function forceRelease():void {
			if(_mouseStatus == MouseStatus.FOCUS && _areEventsEnabled) {
				currentDrag = null;
				_mouseStatus = MouseStatus.OUT;

				releasedOutsideTween();

				var e:ButtonEvent = new ButtonEvent(ButtonEvent.RELEASE_OUTSIDE, true);
				dispatchEvent(e);

				draw();
			}
		}



		public static function releaseAll():void {
			for each(var b:* in allWidgets) {
				if(b is ButtonCore) {
					ButtonCore(b).forceRelease();
				}
			}
		}



		override public function set tabEnabled(enabled:Boolean):void {
			activeSpr.tabEnabled = enabled;
			super.tabEnabled = enabled;

			draw();
		}



		override public function set tabIndex(index:int):void {
			activeSpr.tabIndex = index;

			draw();
		}



		override public function get tabIndex():int {
			return activeSpr.tabIndex;
		}



		public function get skin():ButtonSkin {
			return _skin;
		}



		public function set skin(skin:ButtonSkin):void {
			_skin = ButtonSkin(skin);

			if(_size.width == 0) _size.width = _skin.assetSize.width;
			if(_size.height == 0) _size.height = _skin.assetSize.height;

			//if(!_skin.assetSize.isEmpty()) size = _skin.assetSize; // FIXME: Removed because some weird bug happened when setting size via set.size()

			draw();
		}



		public function set areEventsEnabled(value:Boolean):void {
			_areEventsEnabled = value;

			activeSpr.mouseEnabled = value;
			this.buttonMode = value;
			this.useHandCursor = value;

			if(!value) {
				forceRelease();
			}

			draw();
		}



		public function get areEventsEnabled():Boolean {
			return _areEventsEnabled;
		}



		public function get mouseStatus():String {
			return _mouseStatus;
		}



		public function set mouseStatus(value:String):void {
			switch(value) {
				case MouseStatus.OUT:
					setOut();
					break;

				case MouseStatus.HOVER:
					setOver();
					break;

				case MouseStatus.FOCUS:
					setFocus();
					break;

				default:
					throw new Error(printf("Unknown mouse status (%s)", value));
			}
		}



		override public function get tabEnabled():Boolean {
			return activeSpr.tabEnabled;
		}



		override protected function addChildren():void {
			super.addChildren();

			activeSpr = new QSprite({alpha:0}, contentSpr);

			activeSpr.addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			activeSpr.addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
			activeSpr.addEventListener(MouseEvent.MOUSE_DOWN, onFocus, false, 0, true);
			activeSpr.addEventListener(MouseEvent.MOUSE_UP, onRelease, false, 0, true);
			activeSpr.addEventListener(FocusEvent.FOCUS_IN, onFocusIn, false, 0, true);
			activeSpr.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut, false, 0, true);

			// activeSpr.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
			// TODO: Removed, caused a lot of troubles

			activeSpr.tabEnabled = true;
			activeSpr.focusRect = false;
			activeSpr.buttonMode = true;

			DisplayUtils.drawRect(activeSpr, new Rectangle(0, 0, 100, 100), new RGBA(255, 0, 0, 255));
		}



		override protected function removeChildren():void {
			super.removeChildren();

			activeSpr.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			activeSpr.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			activeSpr.removeEventListener(MouseEvent.MOUSE_DOWN, onFocus);
			activeSpr.removeEventListener(MouseEvent.MOUSE_UP, onRelease);
			activeSpr.removeEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			activeSpr.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);

			// activeSpr.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			// TODO: Removed, caused a lot of troubles

			DisplayUtils.removeChildren(contentSpr, activeSpr);
		}



		protected function hoverInTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_IN_TWEEN, true));

			// duration: _skin.hoverInDuration
			// out -> hidden, sineIn
			// hover -> visible, easeOut
			// focus -> hidden, easeIn
		}



		protected function hoverOutTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_OUT_TWEEN, true));

			// duration: _skin.hoverOutDuration
			// out -> visible, easeOut
			// hover -> hidden, easeIn
			// focus -> hidden, easeIn
		}



		protected function focusInTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.FOCUS_IN_TWEEN, true));

			// duration: _skin.focusInDuration
			// out -> hidden, easeIn
			// hover -> hidden, easeIn
			// focus -> visible, easeOut
		}



		protected function dragConfirmedTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_CONFIRMED_TWEEN, true));

			// duration: _skin.hoverInDuration
			// out -> hidden, easeIn
			// hover -> visible, easeOut
			// focus -> hidden, easeIn
		}



		protected function releasedInsideTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.RELEASED_INSIDE_TWEEN, true));

			// duration: _skin.focusOutDuration
			// out -> hidden, easeIn
			// hover -> visible, easeOut
			// focus -> hidden, easeIn
		}



		protected function releasedOutsideTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.RELEASED_OUTSIDE_TWEEN, true));

			// duration: _skin.focusOutDuration
			// out -> visible, easeOut
			// hover -> hidden, easeIn
			// focus -> hidden, easeIn
		}



		private function setOut():void {
			_mouseStatus = MouseStatus.OUT;
			hoverOutTween();
		}



		private function setOver():void {
			_mouseStatus = MouseStatus.HOVER;
			hoverInTween();
		}



		private function setFocus():void {
			_mouseStatus = MouseStatus.FOCUS;
			focusInTween();
		}



		private function onOver(e:MouseEvent = null):void {
			if(_areEventsEnabled) {
				if(e != null && e.buttonDown) {
					// drag over
					dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_OVER, true));
				}
				else {
					// roll over
					setOver();
					dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_IN, true));
				}
			}
		}



		private function onOut(e:MouseEvent = null):void {
			if(_areEventsEnabled) {
				if(e != null && e.buttonDown) {
					// drag out
					dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_OUT, true));
				}
				else {
					// roll out
					setOut();
					dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_OUT, true));
				}
			}
		}



		private function onFocus(e:MouseEvent = null):void {
			if(_areEventsEnabled) {
				currentDrag = this;
				setFocus();
				if(stage != null) stage.addEventListener(MouseEvent.MOUSE_UP, onRelease, false, 0, true);
				dispatchEvent(new ButtonEvent(ButtonEvent.FOCUS_IN, true));
			}
		}



		private function onRelease(e:MouseEvent = null):void {
			if(stage != null) stage.removeEventListener(MouseEvent.MOUSE_UP, onRelease);

			if(_areEventsEnabled && _mouseStatus == MouseStatus.FOCUS) {
				if(e != null && e.currentTarget == stage) {
					// release outside
					forceRelease();
				}

				else {
					if(currentDrag == this) {
						// release inside
						currentDrag = null;
						releasedInsideTween();
						dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_INSIDE, true));
					}
					else {
						// drag confirm
						dragConfirmedTween();
						dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_CONFIRM, true));
					}
				}

				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true));
			}
		}



		private function onFocusIn(e:FocusEvent):void {
			if(_areEventsEnabled) {
				onOver();
			}
		}



		private function onFocusOut(e:FocusEvent):void {
			if(_areEventsEnabled) {
				onOut();
			}
		}



		/*
		 private function onKeyDown(e:KeyboardEvent):void {
		 if(_areEventsEnabled) {
		 if(e.keyCode == 32 || e.keyCode == 13) dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_INSIDE, true));
		 }
		 }
		 */
		// TODO: Removed, caused a lot of troubles
	}
}
