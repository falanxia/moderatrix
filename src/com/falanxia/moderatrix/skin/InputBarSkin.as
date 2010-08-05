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



	public class InputBarSkin extends Skin {


		protected var _barSkin:BarSkin;
		protected var _labelSkin:LabelSkin;



		public function InputBarSkin(id:String = null) {
			super(SkinType.INPUT_BAR, id);

			_barSkin = new BarSkin(id + "#bar");
			_labelSkin = new LabelSkin(id + "#label");
		}



		/**
		 * Destroys the InpuBarSkin instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_barSkin.destroy();
			_labelSkin.destroy();

			_barSkin = null;
			_labelSkin = null;
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			if(source.bar != undefined) _barSkin.parseConfig(source.bar);
			if(source.label != undefined) _labelSkin.parseConfig(source.label);
		}



		override public function revertConfig():void {
			super.revertConfig();

			_barSkin.revertConfig();
			_labelSkin.revertConfig();
		}



		public function get barSkin():BarSkin {
			return _barSkin;
		}



		public function set barSkin(source:BarSkin):void {
			_barSkin = source;
		}



		public function get labelSkin():LabelSkin {
			return _labelSkin;
		}



		public function set labelSkin(source:LabelSkin):void {
			_labelSkin = source;
		}
	}
}
