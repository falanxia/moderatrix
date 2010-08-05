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
	import com.falanxia.moderatrix.interfaces.*;
	import com.falanxia.utilitaris.utils.*;

	import flash.display.*;
	import flash.geom.*;



	public class Skin implements ISkinnable {


		protected var _id:String;
		protected var _type:String;
		protected var _assetSize:Rectangle = new Rectangle(0, 0, 0, 0);
		protected var _data:Object = new Object();

		private var oldData:Object;



		public function Skin(type:String, id:String = null):void {
			_id = id;
			_type = type;

			if(_id == null) {
				var rs:String = RandomUtils.randomString();
				_id = type + ":skin:" + rs;
			}
		}



		/**
		 * Destroys Skin instance and frees it for GC.
		 */
		public function destroy():void {
			_id = null;
			_type = null;
			_assetSize = null;
			_data = null;

			oldData = null;
		}



		public function parseConfig(source:Object):void {
			oldData = _data;

			if(source._data != undefined) {
				_data = source._data;
			}
		}



		public function revertConfig():void {
			_data = oldData;
		}



		public function get id():String {
			return _id;
		}



		public function get type():String {
			return _type;
		}



		public function get assetSize():Rectangle {
			return _assetSize;
		}



		public function get data():Object {
			return _data;
		}



		public function set data(value:Object):void {
			_data = value;
		}



		protected function getSkinSize(source:MovieClip, frame:*):void {
			// it's needed to duplicate this MovieClip as there was some weird bug:
			// when used source.gotoAndStop(frame) on one of next lines,
			// all future getChildByName() on this source failed.
			var duplicate:MovieClip = DisplayUtils.duplicateMovieClip(source);

			duplicate.gotoAndStop(frame);

			_assetSize.width = duplicate.width;
			_assetSize.height = duplicate.height;
		}



		protected function checkSize(source:BitmapData):void {
			if(_assetSize.width == 0 && _assetSize.height == 0) {
				// size is not specified, set initial values
				_assetSize.width = source.width;
				_assetSize.height = source.height;
			}

			else {
				if(source.width != _assetSize.width || source.height != _assetSize.height) {
					// size mismatch
					throw new Error("Sizes have to match");
				}
			}
		}
	}
}
