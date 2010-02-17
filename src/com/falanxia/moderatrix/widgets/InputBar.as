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
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.InputBarSkin;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObjectContainer;



	/** @todo Comment */
	public class InputBar extends MorphSprite implements IWidget {


		protected var _skin:InputBarSkin;
		protected var _bar:Bar;
		protected var _label:Label;

		private var _debugLevel:String;



		/** @todo Comment */
		public function InputBar(skin:InputBarSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                         debugLevel:String = null) {
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			var dl:String = (debugLevel == null) ? SkinManager.debugLevel : debugLevel;

			_bar = new Bar(skin.barSkin, {}, this, dl);
			_label = new Label(skin.labelSkin, {}, '', this, dl);

			_bar.debugColor = SkinManager.debugColor;
			_label.debugColor = SkinManager.debugColor;
			_label.isInput = true;
			//_label.focusRect = false;

			this.isMorphHeightEnabled = true;
			this.isMorphWidthEnabled = false;

			if(c.width == undefined) c.width = skin.assetSize.width;
			if(c.height == undefined) c.height = skin.assetSize.height;

			//noinspection NegatedIfStatementJS
			if(skin != null) super(c, parent);
			else throw new Error('No skin defined');

			_skin = skin;
		}



		/** @todo Comment */
		public function destroy():void {
			DisplayUtils.removeChildren(this, _bar, _label);

			_bar.destroy();
			_label.destroy();
		}



		/** @todo Comment */
		public function draw():void {
			_bar.draw();
			_label.draw();

			_label.height = _bar.height;
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		override public function get tabEnabled():Boolean {
			return _label.tabEnabled;
		}



		/** @todo Comment */
		override public function set tabEnabled(enabled:Boolean):void {
			_label.tabEnabled = enabled;
		}



		/** @todo Comment */
		override public function get tabIndex():int {
			return _label.tabIndex;
		}



		/** @todo Comment */
		override public function set tabIndex(index:int):void {
			_label.tabIndex = index;
		}



		/** @todo Comment */
		override public function get width():Number {
			return _bar.width;
		}



		/** @todo Comment */
		override public function set width(value:Number):void {
			_bar.width = value;
			_label.width = value;

			draw();
		}



		/** @todo Comment */
		override public function get height():Number {
			return _bar.height;
		}



		/** @todo Comment */
		override public function set height(value:Number):void {
		}



		/** @todo Comment */
		public function set areEventsEnabled(value:Boolean):void {
			_label.isInput = value;
			_label.alpha = (value) ? 1 : 0.5;

			draw();
		}



		/** @todo Comment */
		public function get areEventsEnabled():Boolean {
			return _label.isInput;
		}



		/** @todo Comment */
		public function get debugLevel():String {
			return _debugLevel;
		}



		/** @todo Comment */
		public function set debugLevel(value:String):void {
			_debugLevel = value;

			_bar.debugLevel = value;
			_label.debugLevel = value;
		}



		/** @todo Comment */
		public function get bar():Bar {
			return _bar;
		}



		/** @todo Comment */
		public function get label():Label {
			return _label;
		}



		/** @todo Comment */
		public function get text():String {
			return _label.text;
		}



		/** @todo Comment */
		public function set text(value:String):void {
			_label.text = value;
		}



		/** @todo Comment */
		public function get skin():InputBarSkin {
			return _skin;
		}



		/** @todo Comment */
		public function set skin(skin:InputBarSkin):void {
			_skin = skin;

			_bar.skin = _skin.barSkin;
			_label.skin = _skin.labelSkin;

			draw();
		}
	}
}
