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

	import flash.display.*;
	import flash.utils.*;



	/**
	 * Atlas skin.
	 *
	 * Atlas skin to be used with the Atlas widget.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class AtlasSkin extends Skin implements ISkin, IBitmapSkin {


		public static const ATLAS_BITMAP:uint = 0;

		protected var _bitmapSources:Vector.<BitmapData>;



		/**
		 * Constructor.
		 * ID is autogenerated if it's empty
		 * @param id Skin ID (optional)
		 */
		public function AtlasSkin(id:String = null) {
			super(SkinType.IMAGE, id);

			_bitmapSources = new Vector.<BitmapData>;

			_bitmapSources[ATLAS_BITMAP] = new BitmapData(1, 1, true, 0x00000000);
		}



		/**
		 * Destroys the AtlasSkin instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_bitmapSources[ATLAS_BITMAP].dispose();

			_bitmapSources = null;
		}



		/**
		 * Parse config Object.
		 * @param value Config Object
		 */
		override public function parseConfig(value:Object):void {
			super.parseConfig(value);

			_bitmapSize.width = _settings["spriteWidth"];
		}



		/**
		 * Get bitmaps from vector of BitmapData.
		 * @param value Source vector of BitmapData
		 */
		public function getBitmapsFromAtlas(value:Vector.<BitmapData>):void {
			var bitmap:BitmapData = value[0];

			_bitmapSize.width = bitmap.width;
			_bitmapSize.height = bitmap.height;

			_bitmapSources = new <BitmapData>[
				bitmap
			];
		}



		/**
		 * Set bitmap sources BitmapData.
		 * @param value Vector of bitmap sources
		 */
		public function set bitmapSources(value:Vector.<BitmapData>):void {
			checkSize(value[ATLAS_BITMAP]);

			_bitmapSources = value;
		}



		/**
		 * Get bitmap sources BitmapData.
		 * @return Vector of bitmap sources
		 */
		public function get bitmapSources():Vector.<BitmapData> {
			return _bitmapSources;
		}



		override protected function resetSettings():Dictionary {
			var set:Dictionary = new Dictionary();

			set["spriteWidth"] = 0;

			return set;
		}
	}
}
