/*
 * Falanxia Moderatrix.
 *
 * Copyright (c) 2011 Falanxia (http://falanxia.com)
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

package com.falanxia.moderatrix.skin.combos {
	import com.falanxia.emitor.Asset;
	import com.falanxia.moderatrix.enums.SkinType;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.skin.ImageSkin;
	import com.falanxia.moderatrix.skin.Skin;
	import com.falanxia.utilitaris.utils.BitmapUtils;

	import flash.display.BitmapData;
	import flash.geom.Rectangle;



	/**
	 * Image combo skin.
	 *
	 * Image combo skin to be used with the ImageCombo widget.
	 *
	 * @author Vaclav Vancura / Falanxia a.s.
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class ImageComboSkin extends Skin implements ISkin {


		public var imageOutSkin:ImageSkin;
		public var imageHoverSkin:ImageSkin;
		public var imageFocusSkin:ImageSkin;



		/**
		 * Constructor.
		 * ID is autogenerated if it's empty
		 * @param config Config Object (optional)
		 * @param id Skin ID (optional)
		 * @param asset Asset (optional)
		 */
		public function ImageComboSkin(config:Object, id:String = null, asset:Asset = null) {
			imageOutSkin = new ImageSkin(config, id + "#imageOut");
			imageHoverSkin = new ImageSkin(config, id + "#imageHover");
			imageFocusSkin = new ImageSkin(config, id + "#imageFocus");

			super(SkinType.IMAGE_COMBO, config, id);

			if(asset != null) parseAsset(asset, _config);
		}



		/**
		 * Destroys the ImageComboSkin instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			imageOutSkin.destroy();
			imageHoverSkin.destroy();
			imageFocusSkin.destroy();

			imageOutSkin = null;
			imageHoverSkin = null;
			imageFocusSkin = null;
		}



		/**
		 * Parse asset.
		 * @param asset Asset
		 * @param config Config
		 * @see Asset
		 */
		public function parseAsset(asset:Asset, config:Object):void {
			getBitmapsFromAtlas(new <BitmapData>[asset.getChunkByURL(config.image).bitmap.bitmapData]);
		}



		/**
		 * Get bitmaps from vector of BitmapData.
		 * @param value Source vector of BitmapData
		 */
		public function getBitmapsFromAtlas(value:Vector.<BitmapData>):void {
			var bitmap:BitmapData = value[0];

			if(bitmap.width % 3 != 0) throw new Error("Width has to be multiple of 3");

			_bitmapSize.width = bitmap.width / 3;
			_bitmapSize.height = bitmap.height;

			imageOutSkin.getBitmapsFromAtlas(new <BitmapData>[BitmapUtils.crop(bitmap, new Rectangle(0, 0, _bitmapSize.width, _bitmapSize.height))]);
			imageHoverSkin.getBitmapsFromAtlas(new <BitmapData>[BitmapUtils.crop(bitmap, new Rectangle(_bitmapSize.width, 0, _bitmapSize.width, _bitmapSize.height))]);
			imageFocusSkin.getBitmapsFromAtlas(new <BitmapData>[BitmapUtils.crop(bitmap, new Rectangle(_bitmapSize.width << 1, 0, _bitmapSize.width, _bitmapSize.height))]);
		}



		/**
		 * Parse config Object.
		 * @param value Config Object
		 */
		override public function parseConfig(value:Object):void {
			super.parseConfig(value);

			imageOutSkin.parseConfig(value);
			imageHoverSkin.parseConfig(value);
			imageFocusSkin.parseConfig(value);
		}



		/**
		 * Revert config to the last known state.
		 */
		override public function revertConfig():void {
			super.revertConfig();

			imageOutSkin.revertConfig();
			imageHoverSkin.revertConfig();
			imageFocusSkin.revertConfig();
		}
	}
}
