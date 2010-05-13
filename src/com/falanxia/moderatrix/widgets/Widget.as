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
	import com.falanxia.moderatrix.globals.*;
	import com.falanxia.moderatrix.interfaces.*;
	import com.falanxia.utilitaris.display.*;
	import com.falanxia.utilitaris.types.*;
	import com.falanxia.utilitaris.utils.*;

	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;



	/**
	 * @todo Comment
	 * @todo Width & height not applied in the constructor
	 * @todo Check for children and remove them on destroy()
	 */
	public class Widget extends MorphSprite {


		public static const DRAW:String = "draw";

		public static var initialDebugLevel:String;

		protected static const DEBUG_PADDING:Number = 4;

		protected static var allWidgets:Array;

		protected var _config:Object;
		protected var _size:Rectangle = new Rectangle(0, 0, 0, 0);
		protected var _debugLevel:String;
		protected var _debugColor:RGBA;

		protected var allIdx:uint;
		protected var debugSpr:QSprite;
		protected var contentSpr:QSprite;



		/**
		 * Create a new glyph label button instance.
		 * @param config Configuration {@code Object}
		 * @param parent Parent {@code DisplayObjectContainer}
		 * @param debugLevel Debug level ({@see DebugLevel})
		 */
		public function Widget(config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null):void {
			_config = (config == null) ? new Object() : config;
			_debugColor = SkinManager.debugColor;

			super(_config);

			if(_config.x != undefined) this.x = _config.x;
			if(_config.y != undefined) this.y = _config.y;
			if(_config.width != undefined) this.width = _config.width;
			if(_config.height != undefined) this.height = _config.height;

			if(parent != null) parent.addChild(this);

			if(allWidgets == null) allWidgets = new Array();
			allWidgets.push(this);
			allIdx = allWidgets.length - 1;

			init();

			if(debugLevel == null) {
				if(initialDebugLevel != null) this.debugLevel = initialDebugLevel;
			}
			else {
				this.debugLevel = debugLevel;
			}
		}



		/**
		 * Destroys {@code Widget} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			removeChildren();

			debugSpr.destroy();
			contentSpr.destroy();

			_config = null;
			_size = null;
			_debugColor = null;
			debugSpr = null;
			contentSpr = null;
		}



		/**
		 * Draw the widget.
		 */
		public function draw():void {
			if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) {
				if(!_size.isEmpty()) {
					DisplayUtils.clear(debugSpr);
					DisplayUtils.drawRect(debugSpr, _size, _debugColor);
					DisplayUtils.strokeBounds(debugSpr, _size, _debugColor, 5);
				}
			}

			dispatchEvent(new Event(Widget.DRAW));
		}



		override public function addChild(child:DisplayObject):DisplayObject {
			return (contentSpr == null) ? super.addChild(child) : contentSpr.addChild(child);
		}



		override public function removeChild(child:DisplayObject):DisplayObject {
			var out:DisplayObject;

			if(contentSpr == null && super.contains(child)) {
				out = super.removeChild(child);
			}
			else {
				if(contentSpr.contains(child)) out = contentSpr.removeChild(child);
			}

			return out;
		}



		override public function contains(child:DisplayObject):Boolean {
			return (contentSpr == null) ? super.contains(child) : contentSpr.contains(child);
		}



		override public function swapChildrenAt(index1:int, index2:int):void {
			if(contentSpr == null) {
				super.swapChildrenAt(index1, index2);
			}
			else {
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
			}
			else {
				contentSpr.swapChildren(child1, child2);
			}
		}



		override public function getChildAt(index:int):DisplayObject {
			var out:DisplayObject;

			if(contentSpr == null) {
				out = super.getChildAt(index);
			}
			else {
				contentSpr.getChildAt(index);
			}

			return out;
		}



		override public function setChildIndex(child:DisplayObject, index:int):void {
			if(contentSpr == null) {
				super.setChildIndex(child, index);
			}
			else {
				contentSpr.setChildIndex(child, index);
			}
		}



		/* ★ SETTERS & GETTERS ★ */


		override public function set width(w:Number):void {
			if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) DisplayUtils.clear(debugSpr);

			_size.width = Math.round(w);

			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}



		override public function get width():Number {
			return _size.width;
		}



		override public function set height(h:Number):void {
			if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) DisplayUtils.clear(debugSpr);

			_size.height = Math.round(h);

			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}



		override public function get height():Number {
			return _size.height;
		}



		override public function get size():Rectangle {
			return _size;
		}



		/**
		 * Rescales to new size.
		 * @param rect New size as {@code Rectangle}
		 */
		override public function set size(rect:Rectangle):void {
			_size = rect;
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}



		public static function set allDebugLevel(value:String):void {
			for each(var i:IWidget in allWidgets) {
				if(i != null) i.debugLevel = value;
			}
		}



		override public function set x(value:Number):void {
			super.x = Math.round(value);
		}



		override public function set y(value:Number):void {
			super.y = Math.round(value);
		}



		public function get config():Object {
			return _config;
		}



		public function set debugLevel(value:String):void {
			if(value == DebugLevel.ALWAYS) {
				debugSpr.visible = true;

				this.removeEventListener(MouseEvent.ROLL_OVER, onDebugOver);
				this.removeEventListener(MouseEvent.ROLL_OUT, onDebugOut);
			}
			else {
				debugSpr.visible = false;

				this.addEventListener(MouseEvent.ROLL_OVER, onDebugOver, false, 0, true);
				this.addEventListener(MouseEvent.ROLL_OUT, onDebugOut, false, 0, true);
			}

			_debugLevel = value;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugColor(value:RGBA):void {
			_debugColor = value;
			draw();
		}



		public function get debugColor():RGBA {
			return _debugColor;
		}



		/* ★ PROTECTED METHODS ★ */


		protected function init():void {
			addChildren();
			invalidate();
		}



		protected function addChildren():void {
			contentSpr = new QSprite({mouseEnabled:false}, this);
			debugSpr = new QSprite({mouseEnabled:false, mouseChildren:false}, this);
		}



		protected function removeChildren():void {
			this.removeEventListener(MouseEvent.ROLL_OVER, onDebugOver);
			this.removeEventListener(MouseEvent.ROLL_OUT, onDebugOut);

			allWidgets[allIdx] = null;

			if(contentSpr != null && this.contains(contentSpr)) this.removeChild(contentSpr);
			if(debugSpr != null && this.contains(debugSpr)) this.removeChild(debugSpr);
		}



		protected function invalidate():void {
			addEventListener(Event.ENTER_FRAME, onInvalidate, false, 0, true);
		}



		/* ★ EVENT LISTENERS ★ */


		protected function onDebugOver(e:MouseEvent):void {
			debugSpr.visible = true;
		}



		protected function onDebugOut(e:MouseEvent):void {
			debugSpr.visible = false;
		}



		private function onInvalidate(e:Event):void {
			removeEventListener(Event.ENTER_FRAME, onInvalidate);

			draw();
		}
	}
}
