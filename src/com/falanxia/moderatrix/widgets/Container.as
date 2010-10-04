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
	import com.falanxia.moderatrix.enums.DebugLevel;
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.ContainerSkin;
	import com.falanxia.utilitaris.display.QSprite;
	import com.falanxia.utilitaris.enums.Align;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;



	/**
	 * Class: Container
	 *
	 * Container is a.. Container. You can place other DisplayObjects inside and let them automatically align via
	 * paddingLeft, paddingRight, paddingTop and paddingBottom properties specified in the skin or altered via skin
	 * property. You can set alignment too (left, right, top, bottom, center vertically and/or horizontally). If you
	 * need to override inner sprite size, specify it via innerWidth and innerHeight setters (with corresponding
	 * getters of course).
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class Container extends Widget implements IWidget {


		private var innerSpr:QSprite;



		/**
		 * Constructor.
		 * @param skin Initial skin
		 * @param config Config Object
		 * @param parent Parent DisplayObjectContainer
		 * @param debugLevel Initial debug level
		 * @see DebugLevel
		 */
		public function Container(skin:ContainerSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object = config == null ? new Object() : config;
			var dl:String = (debugLevel == null) ? SkinManager.defaultDebugLevel : debugLevel;

			if(c.width == undefined) c.width = skin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.bitmapSize.height;

			super(c, parent, dl);

			this.skin = skin;

			draw();
		}



		/**
		 * Destroys Container instance and frees it for GC.
		 */
		override public function destroy():void {
			removeChildren();

			innerSpr.destroy();

			super.destroy();

			_skin = null;
			innerSpr = null;
		}



		/**
		 * Draw widget.
		 */
		override public function draw():void {
			super.draw();

			if(_skin != null && _skin.settings != null && _size != null) {
				_size = new Rectangle(0, 0, innerSpr.width, innerSpr.height);

				var settings:Dictionary = _skin.settings;
				var paddingLeft:Number = settings["paddingLeft"];
				var paddingTop:Number = settings["paddingTop"];
				var paddingRight:Number = settings["paddingRight"];
				var paddingBottom:Number = settings["paddingBottom"];
				var hAlign:String = settings["hAlign"];
				var vAlign:String = settings["vAlign"];
				var rect:Rectangle = new Rectangle(paddingLeft, paddingTop, _size.width - paddingLeft - paddingRight, _size.height - paddingTop - paddingBottom);

				// draw debug rectangle
				if(_debugLevel != DebugLevel.NONE) {
					DisplayUtils.strokeBounds(debugSpr, rect, _debugColor, 5);
				}

				// align inner sprite horizontally
				if(hAlign == Align.RIGHT) {
					// right
					innerSpr.x = _size.width - paddingRight;
				}
				else {
					if(hAlign == Align.CENTER) {
						// center
						innerSpr.x = rect.x + (rect.width >> 1);
					}
					else {
						// left
						innerSpr.x = rect.x;
					}
				}

				// align inner sprite vertically
				if(vAlign == Align.BOTTOM) {
					// bottom
					innerSpr.y = _size.height - paddingBottom;
				}
				else {
					if(vAlign == Align.CENTER) {
						// center
						innerSpr.y = rect.y + (rect.height >> 1);
					}
					else {
						// top
						innerSpr.y = rect.y;
					}
				}
			}
		}



		override public function addChild(child:DisplayObject):DisplayObject {
			var out:DisplayObject;

			if(innerSpr == null) {
				out = super.addChild(child);
			}
			else {
				out = innerSpr.addChild(child);
			}

			invalidate();

			return out;
		}



		override public function removeChild(child:DisplayObject):DisplayObject {
			var out:DisplayObject;

			if(innerSpr == null) {
				out = super.removeChild(child);
			}
			else {
				out = innerSpr.removeChild(child);
			}

			invalidate();

			return out;
		}



		override public function contains(child:DisplayObject):Boolean {
			var out:Boolean;

			if(innerSpr == null) {
				out = super.contains(child);
			}
			else {
				out = innerSpr.contains(child);
			}

			return out;
		}



		override public function swapChildrenAt(index1:int, index2:int):void {
			if(innerSpr == null) {
				super.swapChildrenAt(index1, index2);
			}
			else {
				innerSpr.swapChildrenAt(index1, index2);
			}

			invalidate();
		}



		override public function getChildByName(name:String):DisplayObject {
			var out:DisplayObject;

			if(innerSpr == null) {
				out = super.getChildByName(name);
			}
			else {
				out = innerSpr.getChildByName(name);
			}

			return out;
		}



		override public function removeChildAt(index:int):DisplayObject {
			var out:DisplayObject;

			if(innerSpr == null) {
				out = super.removeChildAt(index);
			}
			else {
				out = innerSpr.removeChildAt(index);
			}

			invalidate();

			return out;
		}



		override public function getChildIndex(child:DisplayObject):int {
			var out:int;

			if(innerSpr == null) {
				out = super.getChildIndex(child);
			}
			else {
				out = innerSpr.getChildIndex(child);
			}

			return out;
		}



		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			var out:DisplayObject;

			if(innerSpr == null) {
				out = super.addChildAt(child, index);
			}
			else {
				out = innerSpr.addChildAt(child, index);
			}

			invalidate();

			return out;
		}



		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void {
			if(innerSpr == null) {
				super.swapChildren(child1, child2);
			}
			else {
				innerSpr.swapChildren(child1, child2);
			}

			invalidate();
		}



		override public function getChildAt(index:int):DisplayObject {
			var out:DisplayObject;

			if(innerSpr == null) {
				out = super.getChildAt(index);
			}
			else {
				out = innerSpr.getChildAt(index);
			}

			return out;
		}



		override public function setChildIndex(child:DisplayObject, index:int):void {
			if(innerSpr == null) {
				super.setChildIndex(child, index);
			}
			else {
				innerSpr.setChildIndex(child, index);
			}

			invalidate();
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
		 * Get current width.
		 * @return Current width
		 */
		override public function get width():Number {
			if(_skin != null && _skin.settings != null) {
				var settings:Dictionary = _skin.settings;

				return _size == null ? 0 : _size.width + settings["paddingLeft"] + settings["paddingRight"];
			}
			else {
				return 0;
			}
		}



		/**
		 * Get current height.
		 * @return Current height
		 */
		override public function get height():Number {
			if(_skin != null && _skin.settings != null) {
				var settings:Dictionary = _skin.settings;

				return _size == null ? 0 : _size.height + settings["paddingTop"] + settings["paddingBottom"];
			}
			else {
				return 0;
			}
		}



		override protected function init():void {
			super.init();

			isMorphWidthEnabled = true;
			isMorphHeightEnabled = true;
			isChangeWidthEnabled = true;
			isChangeHeightEnabled = true;
		}



		override protected function addChildren():void {
			super.addChildren();

			innerSpr = new QSprite({});

			DisplayUtils.addChildren(contentSpr, innerSpr);

			invalidate();
		}



		override protected function removeChildren():void {
			super.removeChildren();

			DisplayUtils.removeChildren(contentSpr, innerSpr);

			invalidate();
		}
	}
}
