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
	import com.falanxia.moderatrix.constants.DebugLevel;
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.display.QSprite;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;



	/**
	 * @todo Comment
	 * @todo Width & height not applied in the constructor
	 * @todo Check for children and remove them on destroy()
	 */
	public class Widget extends MorphSprite {


		/** @todo Comment */
		public static const DRAW:String = "draw";

		/** @todo Comment */
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



		/** @todo Comment */
		public function Widget(config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null):void {
			if(config == null) _config = new Object();
			else _config = config;

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
				if(initialDebugLevel != null) {
					this.debugLevel = initialDebugLevel;
				}
			}
			else this.debugLevel = debugLevel;
		}



		/** @todo Comment */
		public function destroy():void {
			removeChildren();
		}



		/** @todo Comment */
		public static function initStage(stage:Stage):void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}



		/** @todo Comment */
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



		/** @todo Comment */
		override public function addChild(child:DisplayObject):DisplayObject {
			var out:DisplayObject;

			if(contentSpr == null) out = super.addChild(child);
			else out = contentSpr.addChild(child);

			return out;
		}



		/** @todo Comment */
		override public function removeChild(child:DisplayObject):DisplayObject {
			var out:DisplayObject;

			try {
				if(contentSpr == null && super.contains(child)) out = super.removeChild(child);
				else {
					if(contentSpr.contains(child)) out = contentSpr.removeChild(child);
				}
			}
			catch(err:Error) {
				// TODO: Fix me. This stinks, somewhere something here is totally wrong
			}

			return out;
		}



		/** @todo Comment */
		override public function contains(child:DisplayObject):Boolean {
			var out:Boolean;

			if(contentSpr == null) out = super.contains(child);
			else out = contentSpr.contains(child);

			return out;
		}



		/** @todo Comment */
		override public function swapChildrenAt(index1:int, index2:int):void {
			if(contentSpr == null) super.swapChildrenAt(index1, index2);
			else contentSpr.swapChildrenAt(index1, index2);
		}



		/** @todo Comment */
		override public function getChildByName(name:String):DisplayObject {
			var out:DisplayObject;

			if(contentSpr == null) out = super.getChildByName(name);
			else out = contentSpr.getChildByName(name);

			return out;
		}



		/** @todo Comment */
		override public function removeChildAt(index:int):DisplayObject {
			var out:DisplayObject;

			if(contentSpr == null) out = super.removeChildAt(index);
			else out = contentSpr.removeChildAt(index);

			return out;
		}



		/** @todo Comment */
		override public function getChildIndex(child:DisplayObject):int {
			var out:int;

			if(contentSpr == null) out = super.getChildIndex(child);
			else out = contentSpr.getChildIndex(child);

			return out;
		}



		/** @todo Comment */
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			var out:DisplayObject;

			if(contentSpr == null) out = super.addChildAt(child, index);
			else out = contentSpr.addChildAt(child, index);

			return out;
		}



		/** @todo Comment */
		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void {
			if(contentSpr == null) super.swapChildren(child1, child2);
			else contentSpr.swapChildren(child1, child2);
		}



		/** @todo Comment */
		override public function getChildAt(index:int):DisplayObject {
			var out:DisplayObject;

			if(contentSpr == null) out = super.getChildAt(index);
			else contentSpr.getChildAt(index);

			return out;
		}



		/** @todo Comment */
		override public function setChildIndex(child:DisplayObject, index:int):void {
			if(contentSpr == null) super.setChildIndex(child, index);
			else contentSpr.setChildIndex(child, index);
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		override public function set width(w:Number):void {
			_size.width = Math.round(w);
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}



		/** @todo Comment */
		override public function get width():Number {
			return _size.width;
		}



		/** @todo Comment */
		override public function set height(h:Number):void {
			_size.height = Math.round(h);
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}



		/** @todo Comment */
		override public function get height():Number {
			return _size.height;
		}



		/** @todo Comment */
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



		/** @todo Comment */
		public static function set allDebugLevel(value:String):void {
			for each(var i:IWidget in allWidgets) {
				if(i != null) i.debugLevel = value;
			}
		}



		/** @todo Comment */
		override public function set x(value:Number):void {
			super.x = Math.round(value);
		}



		/** @todo Comment */
		override public function set y(value:Number):void {
			super.y = Math.round(value);
		}



		/** @todo Comment */
		public function get config():Object {
			return _config;
		}



		/** @todo Comment */
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



		/** @todo Comment */
		public function get debugLevel():String {
			return _debugLevel;
		}



		/** @todo Comment */
		public function set debugColor(value:RGBA):void {
			_debugColor = value;
			draw();
		}



		/** @todo Comment */
		public function get debugColor():RGBA {
			return _debugColor;
		}



		/* ★ PROTECTED METHODS ★ */


		/** @todo Comment */
		protected function init():void {
			addChildren();
			invalidate();
		}



		/** @todo Comment */
		protected function addChildren():void {
			// FIXME: For some reason _debugSpr is below _contentSpr

			contentSpr = new QSprite({mouseEnabled:false}, this);
			debugSpr = new QSprite({mouseEnabled:false, mouseChildren:false}, this);
		}



		/** @todo Comment */
		protected function removeChildren():void {
			this.removeEventListener(MouseEvent.ROLL_OVER, onDebugOver);
			this.removeEventListener(MouseEvent.ROLL_OUT, onDebugOut);

			allWidgets[allIdx] = null;

			DisplayUtils.removeChildren(this, contentSpr, debugSpr);
		}



		/** @todo Comment */
		protected function invalidate():void {
			addEventListener(Event.ENTER_FRAME, onInvalidate, false, 0, true);
		}



		/* ★ EVENT LISTENERS ★ */


		/** @todo Comment */
		protected function onDebugOver(event:MouseEvent):void {
			debugSpr.visible = true;
		}



		/** @todo Comment */
		protected function onDebugOut(event:MouseEvent):void {
			debugSpr.visible = false;
		}



		/** @todo Comment */
		private function onInvalidate(event:Event):void {
			removeEventListener(Event.ENTER_FRAME, onInvalidate);

			draw();
		}
	}
}
