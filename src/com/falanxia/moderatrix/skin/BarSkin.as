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

package com.falanxia.moderatrix.skin {
	import com.falanxia.moderatrix.enums.*;
	import com.falanxia.utilitaris.utils.*;

	import flash.display.*;
	import flash.geom.*;



	public class BarSkin extends Skin {


		protected var _paddingTop:Number;
		protected var _paddingBottom:Number;
		protected var _paddingLeft:Number;
		protected var _paddingRight:Number;
		protected var _guideBD:BitmapData;
		protected var _backBD:BitmapData;

		private var oldPaddingTop:Number;
		private var oldPaddingBottom:Number;
		private var oldPaddingLeft:Number;
		private var oldPaddingRight:Number;



		public function BarSkin(id:String = null) {
			super(SkinType.BAR, id);

			_paddingTop = 0;
			_paddingBottom = 0;
			_paddingLeft = 0;
			_paddingRight = 0;

			_guideBD = new BitmapData(1, 1, true, 0x00000000);
			_backBD = new BitmapData(1, 1, true, 0x00000000);
		}



		/**
		 * Destroys the {@code BarSkin} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_guideBD.dispose();
			_backBD.dispose();

			_guideBD = null;
			_backBD = null;
		}



		public function getAssetsFromAtlas(source:BitmapData):void {
			if(source.width % 2 != 0) throw new Error("Width has to be multiple of 2");

			_assetSize.width = source.width / 2;
			_assetSize.height = source.height;

			_guideBD = BitmapUtils.crop(source, new Rectangle(0, 0, _assetSize.width, _assetSize.height));
			_backBD = BitmapUtils.crop(source, new Rectangle(_assetSize.width, 0, _assetSize.width, _assetSize.height));
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			oldPaddingTop = _paddingTop;
			oldPaddingBottom = _paddingBottom;
			oldPaddingLeft = _paddingLeft;
			oldPaddingRight = _paddingRight;

			if(source.paddingTop != undefined) _paddingTop = source.paddingTop;
			if(source.paddingBottom != undefined) _paddingBottom = source.paddingBottom;
			if(source.paddingLeft != undefined) _paddingLeft = source.paddingLeft;
			if(source.paddingRight != undefined) _paddingRight = source.paddingRight;
		}



		override public function revertConfig():void {
			super.revertConfig();

			_paddingTop = oldPaddingTop;
			_paddingBottom = oldPaddingBottom;
			_paddingLeft = oldPaddingLeft;
			_paddingRight = oldPaddingRight;
		}



		public function get paddingTop():Number {
			return _paddingTop;
		}



		public function set paddingTop(value:Number):void {
			_paddingTop = value;
		}



		public function get paddingBottom():Number {
			return _paddingBottom;
		}



		public function set paddingBottom(value:Number):void {
			_paddingBottom = value;
		}



		public function get paddingLeft():Number {
			return _paddingLeft;
		}



		public function set paddingLeft(value:Number):void {
			_paddingLeft = value;
		}



		public function get paddingRight():Number {
			return _paddingRight;
		}



		public function set paddingRight(value:Number):void {
			_paddingRight = value;
		}



		public function set guideBD(source:BitmapData):void {
			checkSize(source);
			_guideBD = source;
		}



		public function get guideBD():BitmapData {
			return _guideBD;
		}



		public function set backBD(source:BitmapData):void {
			checkSize(source);
			_backBD = source;
		}



		public function get backBD():BitmapData {
			return _backBD;
		}
	}
}
