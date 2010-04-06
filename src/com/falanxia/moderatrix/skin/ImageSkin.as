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
	import com.falanxia.moderatrix.enums.SkinType;

	import flash.display.BitmapData;



	/** @todo Comment */
	public class ImageSkin extends Skin {


		protected var _paddingTop:Number;
		protected var _paddingLeft:Number;
		protected var _imageBD:BitmapData;

		private var oldPaddingTop:Number;
		private var oldPaddingLeft:Number;



		/** @todo Comment */
		public function ImageSkin(id:String = null) {
			super(SkinType.IMAGE, id);

			_paddingTop = 0;
			_paddingLeft = 0;

			_imageBD = new BitmapData(1, 1, true, 0x00000000);
		}



		/**
		 * Destroys the {@code ImageSkin} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_imageBD.dispose();

			_imageBD = null;
		}



		/** @todo Comment */
		public function getAssetsFromAtlas(source:BitmapData):void {
			_assetSize.width = source.width;
			_assetSize.height = source.height;

			_imageBD = source;
		}



		/** @todo Comment */
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			oldPaddingTop = _paddingTop;
			oldPaddingLeft = _paddingLeft;

			if(source.paddingTop != undefined) _paddingTop = source.paddingTop;
			if(source.paddingLeft != undefined) _paddingLeft = source.paddingLeft;
		}



		/** @todo Comment */
		override public function revertConfig():void {
			super.revertConfig();

			_paddingTop = oldPaddingTop;
			_paddingLeft = oldPaddingLeft;
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		public function get paddingTop():Number {
			return _paddingTop;
		}



		/** @todo Comment */
		public function set paddingTop(value:Number):void {
			_paddingTop = value;
		}



		/** @todo Comment */
		public function get paddingLeft():Number {
			return _paddingLeft;
		}



		/** @todo Comment */
		public function set paddingLeft(value:Number):void {
			_paddingLeft = value;
		}



		/** @todo Comment */
		public function set imageBD(source:BitmapData):void {
			checkSize(source);
			_imageBD = source;
		}



		/** @todo Comment */
		public function get imageBD():BitmapData {
			return _imageBD;
		}
	}
}
