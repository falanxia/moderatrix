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
	import com.falanxia.moderatrix.constants.Align;
	import com.falanxia.moderatrix.constants.DebugLevel;
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.skin.ContainerSkin;
	import com.falanxia.utilitaris.display.QSprite;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;



	/**
	 * Class: Container
	 *
	 * Container is a.. Container. You can place other DisplayObjects inside and let them automatically align via
	 * paddingLeft, paddingRight, paddingTop and paddingBottom properties specified in the skin or altered via skin
	 * property. You can set alignment too (left, right, top, bottom, center vertically and/or horizontally). If you
	 * need to override inner sprite size, specify it via innerWidth and innerHeight setters (with corresponding
	 * getters of course).
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @todo Comment
	 */
	public class Container extends Widget {


		protected var _skin:ContainerSkin;

		private var _innerSpr:QSprite;
		private var _innerWidth:Number = 0;
		private var _innerHeight:Number = 0;



		/**
		 * Constructor.
		 * @param skin Skin
		 * @param config (Optional) Config Object
		 * @param parent (Optional) parent to addChild() to
		 * @param debugLevel (Optional) DebugLevel
		 * @see QSprite
		 * @see ContainerSkin
		 * @see DebugLevel
		 * @todo Comment
		 */
		public function Container(skin:ContainerSkin, config:Object = null, parent:DisplayObjectContainer = null,
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
		}



		/**
		 * Redraw stuff.
		 * @todo Optimize
		 */
		override public function draw():void {
			super.draw();

			if(_skin != null) {
				var rect:Rectangle = new Rectangle(_skin.paddingLeft, _skin.paddingTop, _size.width - _skin.paddingLeft - _skin.paddingRight, _size.height - _skin.paddingTop - _skin.paddingBottom);

				// check for inner width & height override
				if(_innerWidth == 0) _innerWidth = _innerSpr.width;
				if(_innerHeight == 0) _innerHeight = _innerSpr.height;

				// draw debug rectangle
				if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) {
					if(!_size.isEmpty()) DisplayUtils.strokeBounds(_debugSpr, rect, _debugColor, 5);
				}

				// align inner sprite horizontally
				if(_skin.hAlign == Align.RIGHT) {
					// right
					_innerSpr.x = _size.width - _skin.paddingRight - _innerWidth;
				} else if(_skin.hAlign == Align.CENTER) {
					// center
					_innerSpr.x = rect.x + Math.round((rect.width - _innerWidth) / 2);
				}
				else {
					// left
					_innerSpr.x = rect.x;
				}

				// align inner sprite vertically
				if(_skin.vAlign == Align.BOTTOM) {
					// bottom
					_innerSpr.y = _size.height - _skin.paddingBottom - _innerHeight;
				} else if(_skin.vAlign == Align.CENTER) {
					// center
					_innerSpr.y = rect.y + Math.round((rect.height - _innerHeight) / 2);
				}
				else {
					// top
					_innerSpr.y = rect.y;
				}
			}
		}



		/** @todo Comment */
		override public function addChild(child:DisplayObject):DisplayObject {
			var out:DisplayObject;

			if(_innerSpr == null) out = super.addChild(child);
			else out = _innerSpr.addChild(child);

			return out;
		}



		/** @todo Comment */
		override public function removeChild(child:DisplayObject):DisplayObject {
			var out:DisplayObject;

			if(_innerSpr == null) out = super.removeChild(child);
			else out = _innerSpr.removeChild(child);

			return out;
		}



		/** @todo Comment */
		override public function contains(child:DisplayObject):Boolean {
			var out:Boolean;

			if(_innerSpr == null) out = super.contains(child);
			else out = _innerSpr.contains(child);

			return out;
		}



		/** @todo Comment */
		override public function swapChildrenAt(index1:int, index2:int):void {
			if(_innerSpr == null) super.swapChildrenAt(index1, index2);
			else _innerSpr.swapChildrenAt(index1, index2);
		}



		/** @todo Comment */
		override public function getChildByName(name:String):DisplayObject {
			var out:DisplayObject;

			if(_innerSpr == null) out = super.getChildByName(name);
			else out = _innerSpr.getChildByName(name);

			return out;
		}



		/** @todo Comment */
		override public function removeChildAt(index:int):DisplayObject {
			var out:DisplayObject;

			if(_innerSpr == null) out = super.removeChildAt(index);
			else out = _innerSpr.removeChildAt(index);

			return out;
		}



		/** @todo Comment */
		override public function getChildIndex(child:DisplayObject):int {
			var out:int;

			if(_innerSpr == null) out = super.getChildIndex(child);
			else out = _innerSpr.getChildIndex(child);

			return out;
		}



		/** @todo Comment */
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			var out:DisplayObject;

			if(_innerSpr == null) out = super.addChildAt(child, index);
			else out = _innerSpr.addChildAt(child, index);

			return out;
		}



		/** @todo Comment */
		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void {
			if(_innerSpr == null) super.swapChildren(child1, child2);
			else _innerSpr.swapChildren(child1, child2);
		}



		/** @todo Comment */
		override public function getChildAt(index:int):DisplayObject {
			var out:DisplayObject;

			if(_innerSpr == null) out = super.getChildAt(index);
			else out = _innerSpr.getChildAt(index);

			return out;
		}



		/** @todo Comment */
		override public function setChildIndex(child:DisplayObject, index:int):void {
			if(_innerSpr == null) super.setChildIndex(child, index);
			else _innerSpr.setChildIndex(child, index);
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		public function get skin():ContainerSkin {
			return _skin;
		}



		/** @todo Comment */
		public function set skin(skin:ContainerSkin):void {
			_skin = skin;

			if(_size.width == 0) _size.width = _skin.assetSize.width;
			if(_size.height == 0) _size.height = _skin.assetSize.height;

			draw();
		}



		/** @todo Comment */
		override public function get width():Number {
			return _size.width + _skin.paddingLeft + _skin.paddingRight;
		}



		/** @todo Comment */
		override public function get height():Number {
			return _size.height + _skin.paddingTop + _skin.paddingBottom;
		}



		/** @todo Comment */
		public function get innerWidth():Number {
			return _innerWidth;
		}



		/** @todo Comment */
		public function set innerWidth(value:Number):void {
			_innerWidth = value;
		}



		/** @todo Comment */
		public function get innerHeight():Number {
			return _innerWidth;
		}



		/** @todo Comment */
		public function set innerHeight(value:Number):void {
			_innerHeight = value;
		}



		/* ★ PROTECTED METHODS ★ */


		/** @todo Comment */
		override protected function _init():void {
			super._init();

			isMorphWidthEnabled = true;
			isMorphHeightEnabled = true;
			isChangeWidthEnabled = true;
			isChangeHeightEnabled = true;
		}



		/** @todo Comment */
		override protected function _addChildren():void {
			super._addChildren();

			_innerSpr = new QSprite({});

			DisplayUtils.addChildren(_contentSpr, _innerSpr);
		}



		/** @todo Comment */
		override protected function _removeChildren():void {
			super._removeChildren();

			DisplayUtils.removeChildren(_contentSpr, _innerSpr);
		}
	}
}
