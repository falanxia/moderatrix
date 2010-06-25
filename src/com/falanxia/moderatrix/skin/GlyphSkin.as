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



	/**
	 * TODO: Documentation
	 */
	public class GlyphSkin extends Skin {


		protected var _glyphOutSkin:ImageSkin;
		protected var _glyphHoverSkin:ImageSkin;
		protected var _glyphFocusSkin:ImageSkin;



		/**
		 * TODO: Documentation
		 * @param id
		 */
		public function GlyphSkin(id:String = null) {
			super(SkinType.GLYPHS, id);

			_glyphOutSkin = new ImageSkin(id + "#glyphOut");
			_glyphHoverSkin = new ImageSkin(id + "#glyphHover");
			_glyphFocusSkin = new ImageSkin(id + "#glyphFocus");
		}



		/**
		 * Destroys the {@code GlyphSkin} instance and frees it for GC.
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



		/**
		 * TODO: Documentation
		 * @param source
		 */
		public function getAssetsFromAtlas(source:BitmapData):void {
			if(source.width % 3 != 0) throw new Error("Width has to be multiple of 3");

			_assetSize.width = source.width / 3;
			_assetSize.height = source.height;

			var outBD:BitmapData = BitmapUtils.crop(source, new Rectangle(0, 0, _assetSize.width, _assetSize.height));
			var overBD:BitmapData = BitmapUtils.crop(source, new Rectangle(_assetSize.width, 0, _assetSize.width, _assetSize.height));
			var focusBD:BitmapData = BitmapUtils.crop(source, new Rectangle(_assetSize.width << 1, 0, _assetSize.width, _assetSize.height));

			_glyphOutSkin.getAssetsFromAtlas(outBD);
			_glyphHoverSkin.getAssetsFromAtlas(overBD);
			_glyphFocusSkin.getAssetsFromAtlas(focusBD);
		}



		/**
		 * TODO: Documentation
		 * @param source
		 */
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			_glyphOutSkin.parseConfig(source);
			_glyphHoverSkin.parseConfig(source);
			_glyphFocusSkin.parseConfig(source);
		}



		/**
		 * TODO: Documentation
		 */
		override public function revertConfig():void {
			super.revertConfig();

			_glyphOutSkin.revertConfig();
			_glyphHoverSkin.revertConfig();
			_glyphFocusSkin.revertConfig();
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get glyphOutSkin():ImageSkin {
			return _glyphOutSkin;
		}



		/**
		 * TODO: Documentation
		 * @param source
		 */
		public function set glyphOutSkin(source:ImageSkin):void {
			_glyphOutSkin = source;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get glyphHoverSkin():ImageSkin {
			return _glyphHoverSkin;
		}



		/**
		 * TODO: Documentation
		 * @param source
		 */
		public function set glyphHoverSkin(source:ImageSkin):void {
			_glyphHoverSkin = source;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get glyphFocusSkin():ImageSkin {
			return _glyphFocusSkin;
		}



		/**
		 * TODO: Documentation
		 * @param source
		 */
		public function set glyphFocusSkin(source:ImageSkin):void {
			_glyphFocusSkin = source;
		}
	}
}
