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



	public class CheckButtonSkin extends Skin {


		protected var _buttonOffSkin:ButtonSkin;
		protected var _buttonOnSkin:ButtonSkin;



		public function CheckButtonSkin(id:String = null) {
			super(SkinType.CHECK_BUTTON, id);

			_buttonOffSkin = new ButtonSkin(id + "#buttonOff");
			_buttonOnSkin = new ButtonSkin(id + "#buttonOn");
		}



		/**
		 * Destroys the {@code CheckButtonSkin} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_buttonOffSkin.destroy();
			_buttonOnSkin.destroy();

			_buttonOffSkin = null;
			_buttonOnSkin = null;
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			if(source.buttonOff != undefined) _buttonOffSkin.parseConfig(source.buttonOff);
			if(source.buttonOn != undefined) _buttonOnSkin.parseConfig(source.buttonOn);
		}



		override public function revertConfig():void {
			super.revertConfig();

			_buttonOffSkin.revertConfig();
			_buttonOnSkin.revertConfig();
		}



		public function get buttonOffSkin():ButtonSkin {
			return _buttonOffSkin;
		}



		public function set buttonOffSkin(source:ButtonSkin):void {
			_buttonOffSkin = source;
		}



		public function get buttonOnSkin():ButtonSkin {
			return _buttonOnSkin;
		}



		public function set buttonOnSkin(source:ButtonSkin):void {
			_buttonOnSkin = source;
		}
	}
}
