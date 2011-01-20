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
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.meta.CountBadgeSkin;
	import com.falanxia.moderatrix.widgets.Image;
	import com.falanxia.moderatrix.widgets.Label;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;



	/**
	 * Count badge.
	 * Circle with a counter.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 2.0
	 */
	public class CountBadge extends MorphSprite implements IWidget {


		public var infinityBack:Image;
		public var valueBack:Image;
		public var valueLabel:Label;

		protected var _skin:CountBadgeSkin;

		private var _debugLevel:String;
		private var _debugColor:RGBA;
		private var _value:uint;



		/**
		 * Constructor.
		 * @param skin Widget skin
		 * @param displayConfig (optional) Display config Object
		 * @param displayParent (optional) Parent DisplayObjectContainer
		 * @see CountBadgeSkin
		 */
		public function CountBadge(skin:CountBadgeSkin, displayConfig:Object = null, displayParent:DisplayObjectContainer = null,
		                           debugLevel:String = null) {
			infinityBack = new Image(skin.infinityBackSkin, {visible:false}, this);
			valueBack = new Image(skin.valueBackSkin, {visible:false}, this);
			valueLabel = new Label(skin.valueLabelSkin, {width:infinityBack.width, y:1}, "", valueBack);

			this.skin = skin;
			this.isMorphHeightEnabled = false;
			this.isMorphWidthEnabled = false;
			this.debugLevel = (debugLevel == null) ? DebugLevel.NONE : debugLevel;
			this.debugColor = DisplayUtils.DEBUG_BLUE;

			var c:Object = displayConfig == null ? new Object() : displayConfig;

			if(c.width == undefined) c.width = skin.infinityBackSkin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.infinityBackSkin.bitmapSize.height;

			super(c, displayParent);

			draw();
		}



		/**
		 * Destroys CheckButton instance and frees it for GC.
		 */
		override public function destroy():void {
			DisplayUtils.removeChildren(this, infinityBack, valueBack, valueLabel);

			infinityBack.destroy();
			valueBack.destroy();
			valueLabel.destroy();

			super.destroy();

			infinityBack = null;
			valueBack = null;
			valueLabel = null;

			_skin = null;
			_debugLevel = null;
			_debugColor = null;
		}



		/**
		 * Draw the widget.
		 */
		public function draw():void {
			if(value > 0 && value < 100) {
				infinityBack.visible = false;
				valueBack.visible = true;
				valueLabel.text = String(value);
				valueLabel.width = value > 9 ? infinityBack.width + 1 : infinityBack.width;
			}

			else {
				if(value >= 100) {
					infinityBack.visible = true;
					valueBack.visible = false;
				}
			}

			infinityBack.draw();
			valueBack.draw();
			valueLabel.draw();
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
				_skin = CountBadgeSkin(value);

				infinityBack.skin = _skin.infinityBackSkin;
				valueBack.skin = _skin.valueBackSkin;
				valueLabel.skin = _skin.valueLabelSkin;
			}
		}



		/**
		 * Get the value.
		 * @return Value
		 */
		public function get value():uint {
			return _value;
		}



		/**
		 * Set the value.
		 * @param value Value
		 */
		public function set value(value:uint):void {
			_value = value;

			invalidate();
		}



		/**
		 * Get debug level.
		 * @return Debug level
		 * @see DebugLevel
		 */
		public function get debugLevel():String {
			return _debugLevel;
		}



		/**
		 * Set debug level.
		 * @param value Debug level
		 * @see DebugLevel
		 */
		public function set debugLevel(value:String):void {
			_debugLevel = value;

			infinityBack.debugLevel = value;
			valueBack.debugLevel = value;
			valueLabel.debugLevel = value;
		}



		public function get debugColor():RGBA {
			return _debugColor;
		}



		public function set debugColor(value:RGBA):void {
			_debugColor = value;

			infinityBack.debugColor = value;
			valueBack.debugColor = value;
			valueLabel.debugColor = value;
		}



		/**
		 * Set widget width.
		 * Placeholder, width of the CountBadge can't be set.
		 * @param value Width
		 */
		override public function set width(value:Number):void {
		}



		/**
		 * Set widget height.
		 * Placeholder, height of the CountBadge can't be set.
		 * @param value Height
		 */
		override public function set height(value:Number):void {
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
