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

package com.falanxia.moderatrix.widgets {
	import com.falanxia.moderatrix.enums.MouseStatus;
	import com.falanxia.moderatrix.events.ButtonEvent;
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.ButtonSkin;
	import com.falanxia.utilitaris.display.QSprite;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObjectContainer;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;



	/**
	 * Button core.
	 *
	 * Parent of all button widgets.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class ButtonCore extends Widget implements IWidget {


		private static var currentDrag:ButtonCore;

		protected var activeSpr:QSprite;

		private var _mouseStatus:String;
		private var _areEventsEnabled:Boolean = true;



		/**
		 * Constructor.
		 * @param skin Initial skin
		 * @param displayConfig Config Object
		 * @param displayParent Parent DisplayObjectContainer
		 * @param debugLevel Initial debug level
		 * @see DebugLevel
		 */
		public function ButtonCore(skin:ButtonSkin, displayConfig:Object = null, displayParent:DisplayObjectContainer = null,
		                           debugLevel:String = null) {
			var c:Object = displayConfig == null ? new Object() : displayConfig;
			var dl:String = (debugLevel == null) ? SkinManager.defaultDebugLevel : debugLevel;

			if(c.width == undefined) c.width = skin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.bitmapSize.height;

			super(c, displayParent, dl);

			this.skin = skin;

			_mouseStatus = MouseStatus.OUT;

			draw();
		}



		/**
		 * Destroys ButtonCore instance and frees it for GC.
		 */
		override public function destroy():void {
			forceRelease();

			if(stage != null) stage.removeEventListener(MouseEvent.MOUSE_UP, onRelease);

			activeSpr.destroy();

			super.destroy();

			_skin = null;
			activeSpr = null;
			_mouseStatus = null;
		}



		/**
		 * Force release.
		 */
		public function forceRelease():void {
			if(_mouseStatus == MouseStatus.FOCUS && _areEventsEnabled) {
				currentDrag = null;
				_mouseStatus = MouseStatus.OUT;

				releasedOutsideTween();

				dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_OUTSIDE, true));

				invalidate();
			}
		}



		/**
		 * Release all buttons everywhere.
		 */
		public static function releaseAll():void {
			var widget:IWidget;

			for each(widget in allWidgets) {
				if(widget is ButtonCore) ButtonCore(widget).forceRelease();
			}
		}



		override public function get tabEnabled():Boolean {
			return activeSpr.tabEnabled;
		}



		override public function set tabEnabled(enabled:Boolean):void {
			activeSpr.tabEnabled = enabled;
			super.tabEnabled = enabled;

			invalidate();
		}



		override public function set tabIndex(index:int):void {
			activeSpr.tabIndex = index;

			invalidate();
		}



		override public function get tabIndex():int {
			return activeSpr.tabIndex;
		}



		/**
		 * Set skin.
		 * @param value Skin
		 */
		override public function set skin(value:ISkin):void {
			if(value != null) {
				super.skin = value;

				if(_skin.bitmapSize != null) {
					if(_size.width == 0) _size.width = _skin.bitmapSize.width;
					if(_size.height == 0) _size.height = _skin.bitmapSize.height;
				}
			}
		}



		/**
		 * Enable or disable button events.
		 * @param value true to enable button events
		 */
		public function set areEventsEnabled(value:Boolean):void {
			_areEventsEnabled = value;

			activeSpr.mouseEnabled = value;
			this.buttonMode = value;
			this.useHandCursor = value;

			if(!value) forceRelease();

			invalidate();
		}



		/**
		 * Get button events enabled flag.
		 * @return Button events enabled flag
		 */
		public function get areEventsEnabled():Boolean {
			return _areEventsEnabled;
		}



		/**
		 * Get current mouse status.
		 * @return Current mouse status
		 * @see MouseStatus
		 */
		public function get mouseStatus():String {
			return _mouseStatus;
		}



		/**
		 * Set mouse status.
		 * @param value Mouse status
		 * @see MouseStatus
		 */
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
					throw new Error("Unknown mouse status (" + value + ")");
			}
		}



		override protected function addChildren():void {
			super.addChildren();

			activeSpr = new QSprite({alpha:0}, contentSpr);

			activeSpr.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			activeSpr.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			activeSpr.addEventListener(MouseEvent.MOUSE_DOWN, onFocus);
			activeSpr.addEventListener(MouseEvent.MOUSE_UP, onRelease);
			activeSpr.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			activeSpr.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);

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

			if(stage != null) stage.removeEventListener(MouseEvent.MOUSE_UP, onRelease);

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
				} else {
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
				} else {
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

				if(stage != null) stage.addEventListener(MouseEvent.MOUSE_UP, onRelease);

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
					} else {
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
	}
}
