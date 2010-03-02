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

package com.falanxia.moderatrix.skin {
	import com.falanxia.moderatrix.constants.SkinType;
	import com.falanxia.utilitaris.utils.BitmapUtils;

	import flash.display.BitmapData;



	/** @todo Comment */
	public class GlyphsSkin extends Skin {


		protected var _glyphOutSkin:ImageSkin;
		protected var _glyphHoverSkin:ImageSkin;
		protected var _glyphFocusSkin:ImageSkin;



		/** @todo Comment */
		public function GlyphsSkin(id:String = null) {
			super(SkinType.GLYPHS, id);

			_glyphOutSkin = new ImageSkin(id + "#glyphOut");
			_glyphHoverSkin = new ImageSkin(id + "#glyphHover");
			_glyphFocusSkin = new ImageSkin(id + "#glyphFocus");
		}



		/**
		 * Destroys the {@code GlyphsSkin} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_glyphOutSkin.destroy();
			_glyphHoverSkin.destroy();
			_glyphFocusSkin.destroy();

			_glyphOutSkin = null;
			_glyphHoverSkin = null;
			_glyphFocusSkin = null;
		}



		/** @todo Comment */
		public function getAssetsFromAtlas(source:BitmapData):void {
			if(source.width % 3 != 0) throw new Error("Width has to be multiple of 3");

			_assetSize.width = source.width / 3;
			_assetSize.height = source.height;

			var outBD:BitmapData = BitmapUtils.crop(source, _assetSize);
			var overBD:BitmapData = BitmapUtils.crop(source, _assetSize);
			var focusBD:BitmapData = BitmapUtils.crop(source, _assetSize);

			_glyphOutSkin.getAssetsFromAtlas(outBD);
			_glyphHoverSkin.getAssetsFromAtlas(overBD);
			_glyphFocusSkin.getAssetsFromAtlas(focusBD);
		}



		/** @todo Comment */
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);
		}



		/** @todo Comment */
		override public function revertConfig():void {
			super.revertConfig();

			_glyphOutSkin.revertConfig();
			_glyphHoverSkin.revertConfig();
			_glyphFocusSkin.revertConfig();
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		public function get glyphOutSkin():ImageSkin {
			return _glyphOutSkin;
		}



		/** @todo Comment */
		public function set glyphOutSkin(source:ImageSkin):void {
			_glyphOutSkin = source;
		}



		/** @todo Comment */
		public function get glyphHoverSkin():ImageSkin {
			return _glyphHoverSkin;
		}



		/** @todo Comment */
		public function set glyphHoverSkin(source:ImageSkin):void {
			_glyphHoverSkin = source;
		}



		/** @todo Comment */
		public function get glyphFocusSkin():ImageSkin {
			return _glyphFocusSkin;
		}



		/** @todo Comment */
		public function set glyphFocusSkin(source:ImageSkin):void {
			_glyphFocusSkin = source;
		}
	}
}
