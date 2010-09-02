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
	import com.falanxia.moderatrix.interfaces.*;



	public class GlyphLabelButtonSkin extends Skin implements ISkinnable {


		protected var _buttonSkin:ButtonSkin;
		protected var _glyphSkin:GlyphSkin;
		protected var _labelOutSkin:LabelSkin;
		protected var _labelHoverSkin:LabelSkin;
		protected var _labelFocusSkin:LabelSkin;



		public function GlyphLabelButtonSkin(id:String = null) {
			super(SkinType.GLYPH_BUTTON, id);

			_buttonSkin = new ButtonSkin(id + "#button");
			_glyphSkin = new GlyphSkin(id + "#glyphs");
			_labelOutSkin = new LabelSkin(id + "#labelOut");
			_labelHoverSkin = new LabelSkin(id + "#labelHover");
			_labelFocusSkin = new LabelSkin(id + "#labelFocus");
		}



		/**
		 * Destroys the GlyphLabelButtonSkin instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_buttonSkin.destroy();
			_glyphSkin.destroy();
			_labelOutSkin.destroy();
			_labelHoverSkin.destroy();
			_labelFocusSkin.destroy();

			_buttonSkin = null;
			_glyphSkin = null;
			_labelOutSkin = null;
			_labelHoverSkin = null;
			_labelFocusSkin = null;
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			if(source.button != undefined) _buttonSkin.parseConfig(source.button);
			if(source.glyph != undefined) _glyphSkin.parseConfig(source.glyph);
			if(source.labelOut != undefined) _labelOutSkin.parseConfig(source.labelOut);
			if(source.labelHover != undefined) _labelHoverSkin.parseConfig(source.labelHover);
			if(source.labelFocus != undefined) _labelFocusSkin.parseConfig(source.labelFocus);
		}



		override public function revertConfig():void {
			super.revertConfig();

			_buttonSkin.revertConfig();
			_glyphSkin.revertConfig();
			_labelOutSkin.revertConfig();
			_labelHoverSkin.revertConfig();
			_labelFocusSkin.revertConfig();
		}



		public function get buttonSkin():ButtonSkin {
			return _buttonSkin;
		}



		public function set buttonSkin(source:ButtonSkin):void {
			_buttonSkin = source;
		}



		public function get glyphSkin():GlyphSkin {
			return _glyphSkin;
		}



		public function set glyphSkin(source:GlyphSkin):void {
			_glyphSkin = source;
		}



		public function get labelOutSkin():LabelSkin {
			return _labelOutSkin;
		}



		public function set labelOutSkin(source:LabelSkin):void {
			_labelOutSkin = source;
		}



		public function get labelHoverSkin():LabelSkin {
			return _labelHoverSkin;
		}



		public function set labelHoverSkin(source:LabelSkin):void {
			_labelHoverSkin = source;
		}



		public function get labelFocusSkin():LabelSkin {
			return _labelFocusSkin;
		}



		public function set labelFocusSkin(source:LabelSkin):void {
			_labelFocusSkin = source;
		}
	}
}
