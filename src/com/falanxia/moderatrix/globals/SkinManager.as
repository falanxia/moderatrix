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


package com.falanxia.moderatrix.globals {
	import com.falanxia.emitor.*;
	import com.falanxia.moderatrix.enums.*;
	import com.falanxia.moderatrix.interfaces.*;
	import com.falanxia.moderatrix.skin.*;
	import com.falanxia.utilitaris.helpers.*;
	import com.falanxia.utilitaris.types.*;

	import flash.display.*;



	/**
	 * Skin manager.
	 *
	 * Skin manager manages all widget skins used in the loaded skin.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class SkinManager {


		private static var _debugLevel:String = DebugLevel.NONE;
		private static var _debugColor:RGBA = new RGBA(255, 0, 0, 0.25 * 255);



		/**
		 * Convert asset data to a skin.
		 * @param asset Asset data Object
		 * @return Skin
		 */
		public static function assetToSkin(asset:Asset):ISkinnable {
			if(asset.config.widget == null) {
				throw new Error("Asset is null");
			}

			else {
				var skin:ISkinnable;
				var isSupported:Boolean = true;
				var config:Object = asset.config.widget;

				try {
					switch(config.type) {
						case SkinType.CONTAINER:
							skin = createContainerSkin(config);
							break;

						case SkinType.BAR:
							skin = createBarSkin(config, asset);
							break;

						case SkinType.IMAGE:
							skin = createImageSkin(config, asset);
							break;

						case SkinType.ATLAS:
							skin = createAtlasSkin(config, asset);
							break;

						case SkinType.BUTTON:
							skin = createButtonSkin(config, asset);
							break;

						case SkinType.LABEL:
							skin = createLabelSkin(config);
							break;

						case SkinType.LABEL_BUTTON:
							skin = createLabelButtonSkin(config, asset);
							break;

						case SkinType.GLYPH_BUTTON:
							skin = createGlyphButtonSkin(config, asset);
							break;

						case SkinType.GLYPH_LABEL_BUTTON:
							skin = createGlyphLabelButtonSkin(config, asset);
							break;

						case SkinType.CHECK_BUTTON:
							skin = createCheckButtonSkin(config, asset);
							break;

						case SkinType.INPUT_BAR:
							skin = createInputBarSkin(config, asset);
							break;

						default:
							isSupported = false;
					}
				}
				catch(err:Error) {
					throw new Error(printf("Asset error: %s", err.message));
				}
			}

			return isSupported ? skin : null;
		}



		public static function get debugLevel():String {
			return _debugLevel;
		}



		public static function set debugLevel(value:String):void {
			_debugLevel = value;
		}



		public static function get debugColor():RGBA {
			return _debugColor;
		}



		public static function set debugColor(value:RGBA):void {
			_debugColor = value;
		}



		private static function createContainerSkin(config:Object):ISkinnable {
			var skin:ContainerSkin = new ContainerSkin();

			skin.parseConfig(config);

			return skin;
		}



		private static function createBarSkin(config:Object, asset:Asset):ISkinnable {
			var skin:BarSkin = new BarSkin();

			skin.getAssetsFromAtlas(asset.getChunkByURL(config.image).bitmap.bitmapData);
			skin.parseConfig(config);

			return skin;
		}



		private static function createImageSkin(config:Object, asset:Asset):ISkinnable {
			var skin:ImageSkin = new ImageSkin();

			skin.getAssetsFromAtlas(asset.getChunkByURL(config.image).bitmap.bitmapData);
			skin.parseConfig(config);

			return skin;
		}



		private static function createAtlasSkin(config:Object, asset:Asset):ISkinnable {
			var skin:AtlasSkin = new AtlasSkin();

			skin.getAssetsFromAtlas(asset.getChunkByURL(config.image).bitmap.bitmapData);
			skin.parseConfig(config);

			return skin;
		}



		private static function createButtonSkin(config:Object, asset:Asset):ISkinnable {
			var skin:ButtonSkin = new ButtonSkin();

			skin.getAssetsFromAtlas(asset.getChunkByURL(config.image).bitmap.bitmapData);
			skin.parseConfig(config);

			return skin;
		}



		private static function createLabelSkin(config:Object):ISkinnable {
			var skin:LabelSkin = new LabelSkin();

			skin.parseConfig(config);

			return skin;
		}



		private static function createLabelButtonSkin(config:Object, asset:Asset):ISkinnable {
			var skin:LabelButtonSkin = new LabelButtonSkin();

			skin.buttonSkin.getAssetsFromAtlas(asset.getChunkByURL(config.button.image).bitmap.bitmapData);
			skin.parseConfig(config);

			return skin;
		}



		private static function createGlyphButtonSkin(config:Object, asset:Asset):ISkinnable {
			var skin:GlyphButtonSkin = new GlyphButtonSkin();

			var glyphButtonSkinBD1:BitmapData = asset.getChunkByURL(config.button.image).bitmap.bitmapData;
			var glyphButtonSkinBD2:BitmapData = asset.getChunkByURL(config.glyph.image).bitmap.bitmapData;

			skin.buttonSkin.getAssetsFromAtlas(glyphButtonSkinBD1);
			skin.glyphSkin.getAssetsFromAtlas(glyphButtonSkinBD2);
			skin.parseConfig(config);

			return skin;
		}



		private static function createGlyphLabelButtonSkin(config:Object, asset:Asset):ISkinnable {
			var skin:GlyphLabelButtonSkin = new GlyphLabelButtonSkin();

			skin.buttonSkin.getAssetsFromAtlas(asset.getChunkByURL(config.button.image).bitmap.bitmapData);
			skin.glyphSkin.getAssetsFromAtlas(asset.getChunkByURL(config.glyph.image).bitmap.bitmapData);
			skin.parseConfig(config);

			return skin;
		}



		private static function createCheckButtonSkin(config:Object, asset:Asset):ISkinnable {
			var skin:CheckButtonSkin = new CheckButtonSkin();

			skin.buttonOffSkin.getAssetsFromAtlas(asset.getChunkByURL(config.buttonOff.image).bitmap.bitmapData);
			skin.buttonOnSkin.getAssetsFromAtlas(asset.getChunkByURL(config.buttonOn.image).bitmap.bitmapData);
			skin.parseConfig(config);

			return skin;
		}



		private static function createInputBarSkin(config:Object, asset:Asset):ISkinnable {
			var skin:InputBarSkin = new InputBarSkin();

			skin.barSkin.getAssetsFromAtlas(asset.getChunkByURL(config.bar.image).bitmap.bitmapData);
			skin.parseConfig(config);

			return skin;
		}
	}
}
