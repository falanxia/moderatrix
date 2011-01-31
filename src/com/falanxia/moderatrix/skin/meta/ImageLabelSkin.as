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



	/**
	 * Image label skin.
	 *
	 * Image label skin to be used with the ImageLabel widget.
	 *
	 * @author Vaclav Vancura / Falanxia a.s.
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class ImageLabelSkin extends Skin implements ISkin {


		public var imageSkin:ImageSkin;
		public var labelSkin:LabelSkin;



		/**
		 * Constructor.
		 * ID is autogenerated if it's empty
		 * @param config Config Object (optional)
		 * @param id Skin ID (optional)
		 * @param asset Asset (optional)
		 */
		public function ImageLabelSkin(config:Object = null, id:String = null, asset:Asset = null) {
			imageSkin = new ImageSkin(config, id + "#image");
			labelSkin = new LabelSkin(config, id + "#label");

			super(SkinType.IMAGE_LABEL, config, id);

			if(asset != null) parseAsset(asset, _config);
		}



		/**
		 * Destroys the ImageLabelButtonSkin instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			imageSkin.destroy();
			labelSkin.destroy();

			imageSkin = null;
			labelSkin = null;
		}



		/**
		 * Parse asset.
		 * @param asset Asset
		 * @param config Config
		 * @see Asset
		 */
		public function parseAsset(asset:Asset, config:Object):void {
			imageSkin.parseAsset(asset, config.image);
		}



		/**
		 * Parse config Object.
		 * @param value Config Object
		 */
		override public function parseConfig(value:Object):void {
			super.parseConfig(value);

			if(value.image != undefined) imageSkin.parseConfig(value.image);
			if(value.label != undefined) labelSkin.parseConfig(value.label);
		}



		/**
		 * Revert config to the last known state.
		 */
		override public function revertConfig():void {
			super.revertConfig();

			imageSkin.revertConfig();
			labelSkin.revertConfig();
		}
	}
}
