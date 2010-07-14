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
	import com.falanxia.moderatrix.globals.*;
	import com.falanxia.moderatrix.interfaces.*;
	import com.falanxia.moderatrix.skin.*;
	import com.falanxia.utilitaris.display.*;
	import com.falanxia.utilitaris.utils.*;

	import flash.display.*;



	public class InputBar extends MorphSprite implements IWidget {


		protected var _skin:InputBarSkin;
		protected var _bar:Bar;
		protected var _label:Label;

		private var _debugLevel:String;



		public function InputBar(skin:InputBarSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object;

			if(config == null) {
				c = new Object();
			}
			else {
				c = config;
			}

			var dl:String = (debugLevel == null) ? SkinManager.debugLevel : debugLevel;

			_bar = new Bar(skin.barSkin, {}, this, dl);
			_label = new Label(skin.labelSkin, {}, "", this, dl);

			_bar.debugColor = SkinManager.debugColor;
			_label.debugColor = SkinManager.debugColor;
			_label.isInput = true;

			this.isMorphHeightEnabled = true;
			this.isMorphWidthEnabled = false;

			if(c.width == undefined) c.width = skin.assetSize.width;
			if(c.height == undefined) c.height = skin.assetSize.height;

			//noinspection NegatedIfStatementJS
			if(skin != null) {
				super(c, parent);
			}
			else {
				throw new Error("No skin defined");
			}

			_skin = skin;
		}



		/**
		 * Destroys {@code InputBar} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			removeChildren();

			_bar.destroy();
			_label.destroy();

			_skin = null;
			_bar = null;
			_label = null;
			_debugLevel = null;
		}



		public function draw():void {
			_bar.draw();
			_label.draw();

			_label.height = _bar.height;
		}



		override public function get tabEnabled():Boolean {
			return _label.tabEnabled;
		}



		override public function set tabEnabled(enabled:Boolean):void {
			_label.tabEnabled = enabled;
		}



		override public function get tabIndex():int {
			return _label.tabIndex;
		}



		override public function set tabIndex(index:int):void {
			_label.tabIndex = index;
		}



		override public function get width():Number {
			return _bar.width;
		}



		override public function set width(value:Number):void {
			_bar.width = value;
			_label.width = value;
		}



		override public function get height():Number {
			return _bar.height;
		}



		override public function set height(value:Number):void {
		}



		public function set areEventsEnabled(value:Boolean):void {
			_label.isInput = value;
			_label.alpha = (value) ? 1 : 0.5;
		}



		public function get areEventsEnabled():Boolean {
			return _label.isInput;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;

			_bar.debugLevel = value;
			_label.debugLevel = value;
		}



		public function get bar():Bar {
			return _bar;
		}



		public function get label():Label {
			return _label;
		}



		public function get text():String {
			return _label.text;
		}



		public function set text(value:String):void {
			_label.text = value;
		}



		public function get skin():InputBarSkin {
			return _skin;
		}



		public function set skin(skin:InputBarSkin):void {
			_skin = skin;

			_bar.skin = _skin.barSkin;
			_label.skin = _skin.labelSkin;
		}



		private function removeChildren():void {
			DisplayUtils.removeChildren(this, _bar, _label);
		}
	}
}
