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

	import flash.display.*;



	public class AtlasSkin extends Skin {


		protected var _imageBD:BitmapData;



		public function AtlasSkin(id:String = null) {
			super(SkinType.IMAGE, id);

			_imageBD = new BitmapData(1, 1, true, 0x00000000);
		}



		/**
		 * Destroys the AtlasSkin instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_imageBD.dispose();

			_imageBD = null;
		}



		public function getAssetsFromAtlas(source:BitmapData):void {
			_assetSize.width = source.width;
			_assetSize.height = source.height;

			_imageBD = source;
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			if(source.spriteWidth != undefined) _assetSize.width = source.spriteWidth;
		}



		override public function revertConfig():void {
			super.revertConfig();
		}



		public function set imageBD(source:BitmapData):void {
			checkSize(source);
			_imageBD = source;
		}



		public function get imageBD():BitmapData {
			return _imageBD;
		}
	}
}
