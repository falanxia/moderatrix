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
	import com.falanxia.utilitaris.utils.BitmapUtils;

	import flash.display.BitmapData;
	import flash.geom.Rectangle;



	/** @todo Comment */
	public class ButtonSkin extends Skin {


		protected var _hoverInDuration:Number;
		protected var _hoverOutDuration:Number;
		protected var _focusInDuration:Number;
		protected var _focusOutDuration:Number;
		protected var _guideBD:BitmapData;
		protected var _outBD:BitmapData;
		protected var _hoverBD:BitmapData;
		protected var _focusBD:BitmapData;

		private var oldHoverInDuration:Number;
		private var oldHoverOutDuration:Number;
		private var oldFocusInDuration:Number;
		private var oldFocusOutDuration:Number;



		/** @todo Comment */
		public function ButtonSkin(id:String = null) {
			super(SkinType.BUTTON, id);

			_hoverInDuration = 0;
			_hoverOutDuration = 0.15;
			_focusInDuration = 0;
			_focusOutDuration = 0.1;

			_guideBD = new BitmapData(1, 1, true, 0x00000000);
			_outBD = new BitmapData(1, 1, true, 0x00000000);
			_hoverBD = new BitmapData(1, 1, true, 0x00000000);
			_focusBD = new BitmapData(1, 1, true, 0x00000000);
		}



		/**
		 * Destroys the {@code ButtonSkin} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_guideBD.dispose();
			_outBD.dispose();
			_hoverBD.dispose();
			_focusBD.dispose();

			_guideBD = null;
			_outBD = null;
			_hoverBD = null;
			_focusBD = null;
		}



		/** @todo Comment */
		public function getAssetsFromAtlas(source:BitmapData):void {
			if(source.width % 4 != 0) throw new Error("Width has to be multiple of 4");

			_assetSize.width = source.width / 4;
			_assetSize.height = source.height;

			_guideBD = BitmapUtils.crop(source, new Rectangle(0, 0, _assetSize.width, _assetSize.height));
			_outBD = BitmapUtils.crop(source, new Rectangle(_assetSize.width, 0, _assetSize.width, _assetSize.height));
			_hoverBD = BitmapUtils.crop(source, new Rectangle(_assetSize.width * 2, 0, _assetSize.width, _assetSize.height));
			_focusBD = BitmapUtils.crop(source, new Rectangle(_assetSize.width * 3, 0, _assetSize.width, _assetSize.height));
		}



		/** @todo Comment */
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			oldHoverInDuration = _hoverInDuration;
			oldHoverOutDuration = _hoverOutDuration;
			oldFocusInDuration = _focusInDuration;
			oldFocusOutDuration = _focusOutDuration;

			if(source.hoverInDuration != undefined) _hoverInDuration = source.hoverInDuration;
			if(source.hoverOutDuration != undefined) _hoverOutDuration = source.hoverOutDuration;
			if(source.pressInDuration != undefined) _focusInDuration = source.pressInDuration;
			if(source.pressOutDuration != undefined) _focusOutDuration = source.pressOutDuration;
		}



		/** @todo Comment */
		override public function revertConfig():void {
			super.revertConfig();

			_hoverInDuration = oldHoverInDuration;
			_hoverOutDuration = oldHoverOutDuration;
			_focusInDuration = oldFocusInDuration;
			_focusOutDuration = oldFocusOutDuration;
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		public function set hoverInDuration(value:Number):void {
			_hoverInDuration = value;
		}



		/** @todo Comment */
		public function get hoverInDuration():Number {
			return _hoverInDuration;
		}



		/** @todo Comment */
		public function set hoverOutDuration(value:Number):void {
			_hoverOutDuration = value;
		}



		/** @todo Comment */
		public function get hoverOutDuration():Number {
			return _hoverOutDuration;
		}



		/** @todo Comment */
		public function set focusInDuration(value:Number):void {
			_focusInDuration = value;
		}



		/** @todo Comment */
		public function get focusInDuration():Number {
			return _focusInDuration;
		}



		/** @todo Comment */
		public function set focusOutDuration(value:Number):void {
			_focusOutDuration = value;
		}



		/** @todo Comment */
		public function get focusOutDuration():Number {
			return _focusOutDuration;
		}



		/** @todo Comment */
		public function set outBD(source:BitmapData):void {
			checkSize(source);
			_outBD = source;
		}



		/** @todo Comment */
		public function get outBD():BitmapData {
			return _outBD;
		}



		/** @todo Comment */
		public function set hoverBD(source:BitmapData):void {
			checkSize(source);
			_hoverBD = source;
		}



		/** @todo Comment */
		public function get hoverBD():BitmapData {
			return _hoverBD;
		}



		/** @todo Comment */
		public function set focusBD(source:BitmapData):void {
			checkSize(source);
			_focusBD = source;
		}



		/** @todo Comment */
		public function get focusBD():BitmapData {
			return _focusBD;
		}



		/** @todo Comment */
		public function set guideBD(source:BitmapData):void {
			checkSize(source);
			_guideBD = source;
		}



		/** @todo Comment */
		public function get guideBD():BitmapData {
			return _guideBD;
		}
	}
}
