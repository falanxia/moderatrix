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
	import com.falanxia.moderatrix.enums.DebugLevel;
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.display.QSprite;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.types.Size;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;



	/**
	 * Widget.
	 *
	 * Parent of all widgets.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class Widget extends MorphSprite implements IWidget {


		public static const DRAW:String = "widget:draw";

		public static var initialDebugLevel:String;

		public var data:Object = {};

		protected static const DEBUG_PADDING:Number = 4;

		protected static var allWidgets:Vector.<IWidget> = new Vector.<IWidget>();

		protected var _config:Object;
		protected var _size:Size = new Size(0, 0);
		protected var _debugLevel:String = DebugLevel.NONE;
		protected var _debugColor:RGBA;
		protected var _idx:uint;
		protected var _skin:ISkin;

		protected var debugSpr:QSprite;
		protected var contentSpr:QSprite;



		/**
		 * Create a new glyph label button instance.
		 * @param config Configuration Object
		 * @param parent Parent DisplayObjectContainer
		 * @param debugLevel Debug level ({@see DebugLevel})
		 */
		public function Widget(config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null):void {
			_config = (config == null) ? new Object() : config;
			_debugColor = SkinManager.defaultDebugColor;

			super(_config, parent);

			allWidgets[_idx = allWidgets.length] = this;

			init();

			if(debugLevel == null) {
				this.debugLevel = initialDebugLevel == null ? null : initialDebugLevel;
			} else {
				this.debugLevel = debugLevel;
			}
		}



		/**
		 * Destroys Widget instance and frees it for GC.
		 */
		override public function destroy():void {
			if(this.hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME, onInvalidate);

			removeChildren();

			debugSpr.destroy();
			contentSpr.destroy();

			super.destroy();

			_config = null;
			_size = null;
			_debugColor = null;
			_debugLevel = null;

			debugSpr = null;
			contentSpr = null;
			data = null;
		}



		/**
		 * Draw the widget.
		 */
		public function draw():void {
			if(_size != null) {
				if(_debugLevel != DebugLevel.NONE) {
					DisplayUtils.clear(debugSpr);
					DisplayUtils.drawRect(debugSpr, _size.rect, _debugColor);
					DisplayUtils.strokeBounds(debugSpr, _size.rect, _debugColor, 5);
				}

				dispatchEvent(new Event(Widget.DRAW));
			}
		}



		override public function addChild(child:DisplayObject):DisplayObject {
			return (contentSpr == null) ? super.addChild(child) : contentSpr.addChild(child);
		}



		override public function removeChild(child:DisplayObject):DisplayObject {
			if(super.getChildByName(child.name)) {
				super.removeChild(child);
			} else if(child.parent.getChildByName(child.name)) {
				child.parent.removeChild(child);
			}

			return child;
		}



		override public function contains(child:DisplayObject):Boolean {
			return (contentSpr == null) ? super.contains(child) : contentSpr.contains(child);
		}



		override public function swapChildrenAt(index1:int, index2:int):void {
			if(contentSpr == null) {
				super.swapChildrenAt(index1, index2);
			} else {
				contentSpr.swapChildrenAt(index1, index2);
			}
		}



		override public function getChildByName(name:String):DisplayObject {
			return (contentSpr == null) ? super.getChildByName(name) : contentSpr.getChildByName(name);
		}



		override public function removeChildAt(index:int):DisplayObject {
			return (contentSpr == null) ? super.removeChildAt(index) : contentSpr.removeChildAt(index);
		}



		override public function getChildIndex(child:DisplayObject):int {
			return (contentSpr == null) ? super.getChildIndex(child) : contentSpr.getChildIndex(child);
		}



		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			return (contentSpr == null) ? super.addChildAt(child, index) : contentSpr.addChildAt(child, index);
		}



		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void {
			if(contentSpr == null) {
				super.swapChildren(child1, child2);
			} else {
				contentSpr.swapChildren(child1, child2);
			}
		}



		override public function getChildAt(index:int):DisplayObject {
			var out:DisplayObject;

			if(contentSpr == null) {
				out = super.getChildAt(index);
			} else {
				contentSpr.getChildAt(index);
			}

			return out;
		}



		override public function setChildIndex(child:DisplayObject, index:int):void {
			if(contentSpr == null) {
				super.setChildIndex(child, index);
			} else {
				contentSpr.setChildIndex(child, index);
			}
		}



		/**
		 * Rescale to new width.
		 * @param value Width
		 */
		override public function set width(value:Number):void {
			if(_size != null) {
				if(_debugLevel != DebugLevel.NONE) DisplayUtils.clear(debugSpr);

				_size.width = Math.round(value);

				invalidate();
				dispatchEvent(new Event(Event.RESIZE));
			}
		}



		/**
		 * Get width.
		 * @return Width
		 */
		override public function get width():Number {
			return _size == null ? 0 : _size.width;
		}



		/**
		 * Rescale to new height.
		 * @param value Height
		 */
		override public function set height(value:Number):void {
			if(_size != null) {
				if(_debugLevel != DebugLevel.NONE) DisplayUtils.clear(debugSpr);

				_size.height = Math.round(value);

				invalidate();
				dispatchEvent(new Event(Event.RESIZE));
			}
		}



		/**
		 * Get height.
		 * @return Height
		 */
		override public function get height():Number {
			return _size.height;
		}



		/**
		 * Get size.
		 * @return Size
		 * @see Size
		 */
		override public function get size():Size {
			return _size;
		}



		/**
		 * Rescales to new size.
		 * @param value New size as Size
		 * @see Size
		 */
		override public function set size(value:Size):void {
			if(value != null) {
				if(_debugLevel != DebugLevel.NONE) DisplayUtils.clear(debugSpr);

				_size = value;

				invalidate();
				dispatchEvent(new Event(Event.RESIZE));
			}
		}



		/**
		 * Set debug level in all widgets everywhere.
		 * @param value Debug level
		 * @see DebugLevel
		 */
		public static function set allDebugLevel(value:String):void {
			var widget:IWidget;

			for each(widget in allWidgets) {
				if(widget != null) widget.debugLevel = value;
			}
		}



		/**
		 * Get configuration Object.
		 * @return Configuration Object
		 */
		public function get config():Object {
			return _config;
		}



		/**
		 * Get index in a list of all widgets.
		 * @return Index
		 */
		public function get idx():uint {
			return _idx;
		}



		/**
		 * Set debug level.
		 * @param value Debug level
		 * @see DebugLevel
		 */
		public function set debugLevel(value:String):void {
			if(value == DebugLevel.HOVER) {
				debugSpr.visible = false;

				addEventListener(MouseEvent.ROLL_OVER, onDebugOver);
				addEventListener(MouseEvent.ROLL_OUT, onDebugOut);
			} else {
				debugSpr.visible = true;

				removeEventListener(MouseEvent.ROLL_OVER, onDebugOver);
				removeEventListener(MouseEvent.ROLL_OUT, onDebugOut);
			}

			_debugLevel = value;
		}



		/**
		 * Get current debug level.
		 * @return Debug level
		 * @see DebugLevel
		 */
		public function get debugLevel():String {
			return _debugLevel;
		}



		/**
		 * Set debug color.
		 * @param value Debug color
		 */
		public function set debugColor(value:RGBA):void {
			if(value != null) {
				_debugColor = value;
				invalidate();
			}
		}



		/**
		 * Get current debug color.
		 * @return Debug color
		 */
		public function get debugColor():RGBA {
			return _debugColor;
		}



		/**
		 * Get skin.
		 * @return Skin
		 */
		public function get skin():ISkin {
			return _skin;
		}



		/**
		 * Set skin.
		 * @param skin Skin
		 */
		public function set skin(skin:ISkin):void {
			if(_size != null) {
				_skin = skin;

				invalidate();
			}
		}



		protected function init():void {
			addChildren();
		}



		protected function addChildren():void {
			contentSpr = new QSprite({mouseEnabled:false}, this);
			debugSpr = new QSprite({mouseEnabled:false, mouseChildren:false}, this);
		}



		protected function removeChildren():void {
			removeEventListener(MouseEvent.ROLL_OVER, onDebugOver);
			removeEventListener(MouseEvent.ROLL_OUT, onDebugOut);

			allWidgets[_idx] = null;

			if(contentSpr != null && this.getChildByName(contentSpr.name)) contentSpr.parent.removeChild(contentSpr);
			if(debugSpr != null && this.getChildByName(debugSpr.name)) debugSpr.parent.removeChild(debugSpr);
		}



		protected function onDebugOver(e:MouseEvent):void {
			debugSpr.visible = true;
		}



		protected function onDebugOut(e:MouseEvent):void {
			debugSpr.visible = false;
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
