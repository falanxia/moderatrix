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
	import com.falanxia.moderatrix.skin.meta.InputBarSkin;
	import com.falanxia.moderatrix.widgets.Bar;
	import com.falanxia.moderatrix.widgets.Label;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObjectContainer;



	public class InputBar extends MorphSprite implements IWidget {


		public var bar:Bar;
		public var label:Label;

		protected var _skin:InputBarSkin;

		private var _debugLevel:String;



		public function InputBar(skin:InputBarSkin, displayConfig:Object = null, displayParent:DisplayObjectContainer = null,
		                         debugLevel:String = null) {
			var c:Object = displayConfig == null ? new Object() : displayConfig;
			var dl:String = (debugLevel == null) ? DebugLevel.NONE : debugLevel;
			var dc:RGBA = DisplayUtils.RED;

			bar = new Bar(skin.barSkin, {}, this, dl);
			label = new Label(skin.labelSkin, {}, "", this, dl);

			bar.debugColor = dc;
			label.debugColor = dc;
			label.isInput = true;

			this.isMorphHeightEnabled = true;
			this.isMorphWidthEnabled = false;

			if(c.width == undefined) c.width = skin.barSkin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.barSkin.bitmapSize.height;

			super(c, displayParent);

			_skin = skin;
			_debugLevel = dl;
		}



		/**
		 * Destroys InputBar instance and frees it for GC.
		 */
		override public function destroy():void {
			removeChildren();

			bar.destroy();
			label.destroy();

			super.destroy();

			bar = null;
			label = null;

			_skin = null;
			_debugLevel = null;
		}



		public function draw():void {
			bar.draw();
			label.draw();

			label.height = bar.height;
		}



		override public function get tabEnabled():Boolean {
			return label.tabEnabled;
		}



		override public function set tabEnabled(enabled:Boolean):void {
			label.tabEnabled = enabled;
		}



		override public function get tabIndex():int {
			return label.tabIndex;
		}



		override public function set tabIndex(index:int):void {
			label.tabIndex = index;
		}



		override public function get width():Number {
			return bar.width;
		}



		override public function set width(value:Number):void {
			bar.width = value;
			label.width = value;
		}



		override public function get height():Number {
			return bar.height;
		}



		override public function set height(value:Number):void {
		}



		public function set areEventsEnabled(value:Boolean):void {
			label.isInput = value;
			label.alpha = (value) ? 1 : 0.5;
		}



		public function get areEventsEnabled():Boolean {
			return label.isInput;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;

			bar.debugLevel = value;
			label.debugLevel = value;
		}



		public function get text():String {
			return label.text;
		}



		public function set text(value:String):void {
			label.text = value;
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
				_skin = InputBarSkin(value);

				bar.skin = _skin.barSkin;
				label.skin = _skin.labelSkin;
			}
		}



		private function removeChildren():void {
			DisplayUtils.removeChildren(this, bar, label);
		}
	}
}
