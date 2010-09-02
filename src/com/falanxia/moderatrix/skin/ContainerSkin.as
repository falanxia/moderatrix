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
	import com.falanxia.utilitaris.enums.*;



	public class ContainerSkin extends Skin implements ISkinnable {


		protected var _hAlign:String;
		protected var _vAlign:String;
		protected var _paddingTop:Number;
		protected var _paddingBottom:Number;
		protected var _paddingLeft:Number;
		protected var _paddingRight:Number;

		private var oldHAlign:String;
		private var oldVAlign:String;
		private var oldPaddingTop:Number;
		private var oldPaddingBottom:Number;
		private var oldPaddingLeft:Number;
		private var oldPaddingRight:Number;



		public function ContainerSkin(id:String = null) {
			super(SkinType.CONTAINER, id);

			_hAlign = Align.LEFT;
			_vAlign = Align.TOP;
			_paddingTop = 0;
			_paddingBottom = 0;
			_paddingLeft = 0;
			_paddingRight = 0;
		}



		/**
		 * Destroys the ContainerSkin instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_hAlign = null;
			_vAlign = null;

			oldHAlign = null;
			oldVAlign = null;
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			oldHAlign = _hAlign;
			oldVAlign = _vAlign;
			oldPaddingTop = _paddingTop;
			oldPaddingBottom = _paddingBottom;
			oldPaddingLeft = _paddingLeft;
			oldPaddingRight = _paddingRight;

			if(source.hAlign != undefined) _hAlign = source.hAlign;
			if(source.vAlign != undefined) _vAlign = source.vAlign;
			if(source.paddingTop != undefined) _paddingTop = source.paddingTop;
			if(source.paddingBottom != undefined) _paddingBottom = source.paddingBottom;
			if(source.paddingLeft != undefined) _paddingLeft = source.paddingLeft;
			if(source.paddingRight != undefined) _paddingRight = source.paddingRight;
		}



		override public function revertConfig():void {
			super.revertConfig();

			_hAlign = oldHAlign;
			_vAlign = oldVAlign;
			_paddingTop = oldPaddingTop;
			_paddingBottom = oldPaddingBottom;
			_paddingLeft = oldPaddingLeft;
			_paddingRight = oldPaddingRight;
		}



		public function get hAlign():String {
			return _hAlign;
		}



		public function set hAlign(value:String):void {
			_hAlign = value;
		}



		public function get vAlign():String {
			return _vAlign;
		}



		public function set vAlign(value:String):void {
			_vAlign = value;
		}



		public function get paddingTop():Number {
			return _paddingTop;
		}



		public function set paddingTop(value:Number):void {
			_paddingTop = value;
		}



		public function get paddingBottom():Number {
			return _paddingBottom;
		}



		public function set paddingBottom(value:Number):void {
			_paddingBottom = value;
		}



		public function get paddingLeft():Number {
			return _paddingLeft;
		}



		public function set paddingLeft(value:Number):void {
			_paddingLeft = value;
		}



		public function get paddingRight():Number {
			return _paddingRight;
		}



		public function set paddingRight(value:Number):void {
			_paddingRight = value;
		}
	}
}
