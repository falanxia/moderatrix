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

package com.falanxia.moderatrix.skin.meta {
	import com.falanxia.emitor.Asset;
	import com.falanxia.moderatrix.enums.SkinType;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.skin.ImageSkin;
	import com.falanxia.moderatrix.skin.LabelSkin;
	import com.falanxia.moderatrix.skin.Skin;

	import flash.display.BitmapData;



	/**
	 * Count badge skin.
	 *
	 * Count badge skin to be used with the CountBadge widget.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 2.0
	 */
	public class CountBadgeSkin extends Skin implements ISkin {


		public var infinityBackSkin:ImageSkin;
		public var valueBackSkin:ImageSkin;
		public var valueLabelSkin:LabelSkin;



		/**
		 * Constructor.
		 * ID is autogenerated if it's empty
		 * @param config Config Object (optional)
		 * @param id Skin ID (optional)
		 * @param asset Asset (optional)
		 */
		public function CountBadgeSkin(config:Object = null, id:String = null, asset:Asset = null) {
			infinityBackSkin = new ImageSkin(config, id + "#infinityBack");
			valueBackSkin = new ImageSkin(config, id + "#valueBack");
			valueLabelSkin = new LabelSkin(config, id + "#valueLabel");

			super(SkinType.CHECK_BUTTON, config, id);

			if(asset != null) parseAsset(asset);
		}



		/**
		 * Destroys the CheckButtonSkin instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			infinityBackSkin.destroy();
			valueBackSkin.destroy();
			valueLabelSkin.destroy();

			infinityBackSkin = null;
			valueBackSkin = null;
			valueLabelSkin = null;
		}



		/**
		 * Parse asset.
		 * @param value Asset
		 * @see Asset
		 */
		public function parseAsset(value:Asset):void {
			infinityBackSkin.getBitmapsFromAtlas(new <BitmapData>[value.getChunkByURL(_config.infinityBack.image).bitmap.bitmapData]);
			valueBackSkin.getBitmapsFromAtlas(new <BitmapData>[value.getChunkByURL(_config.valueBack.image).bitmap.bitmapData]);
		}



		/**
		 * Parse config Object.
		 * @param value Config Object
		 */
		override public function parseConfig(value:Object):void {
			super.parseConfig(value);

			if(value.infinityBack != undefined) infinityBackSkin.parseConfig(value.infinityBack);
			if(value.valueBack != undefined) valueBackSkin.parseConfig(value.valueBack);
			if(value.valueLabel != undefined) valueLabelSkin.parseConfig(value.valueLabel);
		}



		/**
		 * Revert config to the last known state.
		 */
		override public function revertConfig():void {
			super.revertConfig();

			infinityBackSkin.revertConfig();
			valueBackSkin.revertConfig();
			valueLabelSkin.revertConfig();
		}
	}
}