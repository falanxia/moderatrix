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



	/**
	 * TODO: Documentation
	 */
	public class GlyphButtonSkin extends Skin {


		protected var _buttonSkin:ButtonSkin;
		protected var _glyphSkin:GlyphSkin;



		/**
		 * TODO: Documentation
		 * @param id
		 */
		public function GlyphButtonSkin(id:String = null) {
			super(SkinType.GLYPH_BUTTON, id);

			_buttonSkin = new ButtonSkin(id + "#button");
			_glyphSkin = new GlyphSkin(id + "#glyph");
		}



		/**
		 * Destroys the {@code GlyphButtonSkin} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_buttonSkin.destroy();
			_glyphSkin.destroy();

			_buttonSkin = null;
			_glyphSkin = null;
		}



		/**
		 * TODO: Documentation
		 * @param source
		 */
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			if(source.button != undefined) _buttonSkin.parseConfig(source.button);
			if(source.glyphs != undefined) _glyphSkin.parseConfig(source.glyphs);
		}



		/**
		 * TODO: Documentation
		 */
		override public function revertConfig():void {
			super.revertConfig();

			_buttonSkin.revertConfig();
			_glyphSkin.revertConfig();
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get buttonSkin():ButtonSkin {
			return _buttonSkin;
		}



		/**
		 * TODO: Documentation
		 * @param source
		 */
		public function set buttonSkin(source:ButtonSkin):void {
			_buttonSkin = source;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get glyphSkin():GlyphSkin {
			return _glyphSkin;
		}



		/**
		 * TODO: Documentation
		 * @param source
		 */
		public function set glyphSkin(source:GlyphSkin):void {
			_glyphSkin = source;
		}
	}
}
