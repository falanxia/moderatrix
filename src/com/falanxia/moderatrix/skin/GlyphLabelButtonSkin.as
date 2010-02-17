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



	/** @todo Comment */
	public class GlyphLabelButtonSkin extends Skin {


		protected var _buttonSkin:ButtonSkin;
		protected var _glyphsSkin:GlyphsSkin;
		protected var _labelOutSkin:LabelSkin;
		protected var _labelHoverSkin:LabelSkin;
		protected var _labelFocusSkin:LabelSkin;



		/** @todo Comment */
		public function GlyphLabelButtonSkin(id:String = null) {
			super(SkinType.GLYPH_BUTTON, id);

			_buttonSkin = new ButtonSkin(id + "#button");
			_glyphsSkin = new GlyphsSkin(id + "#glyphs");
			_labelOutSkin = new LabelSkin(id + "#labelOut");
			_labelHoverSkin = new LabelSkin(id + "#labelHover");
			_labelFocusSkin = new LabelSkin(id + "#labelFocus");
		}



		/** @todo Comment */
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			if(source.button != undefined) _buttonSkin.parseConfig(source.button);
			if(source.glyphs != undefined) _glyphsSkin.parseConfig(source.glyphs);
			if(source.labelOut != undefined) _labelOutSkin.parseConfig(source.labelOut);
			if(source.labelHover != undefined) _labelHoverSkin.parseConfig(source.labelHover);
			if(source.labelFocus != undefined) _labelFocusSkin.parseConfig(source.labelFocus);
		}



		/** @todo Comment */
		override public function revertConfig():void {
			super.revertConfig();

			_buttonSkin.revertConfig();
			_glyphsSkin.revertConfig();
			_labelOutSkin.revertConfig();
			_labelHoverSkin.revertConfig();
			_labelFocusSkin.revertConfig();
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		public function get buttonSkin():ButtonSkin {
			return _buttonSkin;
		}



		/** @todo Comment */
		public function set buttonSkin(source:ButtonSkin):void {
			_buttonSkin = source;
		}



		/** @todo Comment */
		public function get glyphsSkin():GlyphsSkin {
			return _glyphsSkin;
		}



		/** @todo Comment */
		public function set glyphsSkin(source:GlyphsSkin):void {
			_glyphsSkin = source;
		}



		/** @todo Comment */
		public function get labelOutSkin():LabelSkin {
			return _labelOutSkin;
		}



		/** @todo Comment */
		public function set labelOutSkin(source:LabelSkin):void {
			_labelOutSkin = source;
		}



		/** @todo Comment */
		public function get labelHoverSkin():LabelSkin {
			return _labelHoverSkin;
		}



		/** @todo Comment */
		public function set labelHoverSkin(source:LabelSkin):void {
			_labelHoverSkin = source;
		}



		/** @todo Comment */
		public function get labelFocusSkin():LabelSkin {
			return _labelFocusSkin;
		}



		/** @todo Comment */
		public function set labelFocusSkin(source:LabelSkin):void {
			_labelFocusSkin = source;
		}
	}
}
