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
							skin = new ContainerSkin();

							var containerSkin:ContainerSkin = ContainerSkin(skin);

							containerSkin.parseConfig(config);

							break;

						case SkinType.BAR:
							skin = new BarSkin();

							var barSkin:BarSkin = BarSkin(skin);
							var barSkinBD:BitmapData = asset.getChunkByURL(config.image).bitmap.bitmapData;

							barSkin.getAssetsFromAtlas(barSkinBD);
							barSkin.parseConfig(config);

							break;

						case SkinType.IMAGE:
							skin = new ImageSkin();

							var imageSkin:ImageSkin = ImageSkin(skin);
							var imageSkinBD:BitmapData = asset.getChunkByURL(config.image).bitmap.bitmapData;

							imageSkin.getAssetsFromAtlas(imageSkinBD);
							imageSkin.parseConfig(config);

							break;

						case SkinType.ATLAS:
							skin = new AtlasSkin();

							var atlasSkin:AtlasSkin = AtlasSkin(skin);
							var atlasSkinBD:BitmapData = asset.getChunkByURL(config.image).bitmap.bitmapData;

							atlasSkin.getAssetsFromAtlas(atlasSkinBD);
							atlasSkin.parseConfig(config);

							break;

						case SkinType.BUTTON:
							skin = new ButtonSkin();

							var buttonSkin:ButtonSkin = ButtonSkin(skin);
							var buttonSkinBD:BitmapData = asset.getChunkByURL(config.image).bitmap.bitmapData;

							buttonSkin.getAssetsFromAtlas(buttonSkinBD);
							buttonSkin.parseConfig(config);

							break;

						case SkinType.LABEL:
							skin = new LabelSkin();

							var labelSkin:LabelSkin = LabelSkin(skin);

							labelSkin.parseConfig(config);

							break;

						case SkinType.LABEL_BUTTON:
							skin = new LabelButtonSkin();

							var labelButtonSkin:LabelButtonSkin = LabelButtonSkin(skin);
							var labelButtonSkinBD:BitmapData = asset.getChunkByURL(config.button.image).bitmap.bitmapData;

							labelButtonSkin.buttonSkin.getAssetsFromAtlas(labelButtonSkinBD);
							labelButtonSkin.parseConfig(config);

							break;

						case SkinType.GLYPH_BUTTON:
							skin = new GlyphButtonSkin();

							var glyphButtonSkin:GlyphButtonSkin = GlyphButtonSkin(skin);
							var glyphButtonSkinBD1:BitmapData = asset.getChunkByURL(config.button.image).bitmap.bitmapData;
							var glyphButtonSkinBD2:BitmapData = asset.getChunkByURL(config.glyph.image).bitmap.bitmapData;

							glyphButtonSkin.buttonSkin.getAssetsFromAtlas(glyphButtonSkinBD1);
							glyphButtonSkin.glyphSkin.getAssetsFromAtlas(glyphButtonSkinBD2);
							glyphButtonSkin.parseConfig(config);

							break;

						case SkinType.GLYPH_LABEL_BUTTON:
							skin = new GlyphLabelButtonSkin();

							var glyphLabelButtonSkin:GlyphLabelButtonSkin = GlyphLabelButtonSkin(skin);
							var glyphLabelButtonSkinBD1:BitmapData = asset.getChunkByURL(config.button.image).bitmap.bitmapData;
							var glyphLabelButtonSkinBD2:BitmapData = asset.getChunkByURL(config.glyph.image).bitmap.bitmapData;

							glyphLabelButtonSkin.buttonSkin.getAssetsFromAtlas(glyphLabelButtonSkinBD1);
							glyphLabelButtonSkin.glyphSkin.getAssetsFromAtlas(glyphLabelButtonSkinBD2);
							glyphLabelButtonSkin.parseConfig(config);

							break;

						case SkinType.CHECK_BUTTON:
							skin = new CheckButtonSkin();

							var checkButtonSkin:CheckButtonSkin = CheckButtonSkin(skin);
							var checkButtonSkinBD1:BitmapData = asset.getChunkByURL(config.buttonOff.image).bitmap.bitmapData;
							var checkButtonSkinBD2:BitmapData = asset.getChunkByURL(config.buttonOn.image).bitmap.bitmapData;

							checkButtonSkin.buttonOffSkin.getAssetsFromAtlas(checkButtonSkinBD1);
							checkButtonSkin.buttonOnSkin.getAssetsFromAtlas(checkButtonSkinBD2);
							checkButtonSkin.parseConfig(config);

							break;

						case SkinType.INPUT_BAR:
							skin = new InputBarSkin();

							var inputBarSkin:InputBarSkin = InputBarSkin(skin);
							var inputBarSkinBD:BitmapData = asset.getChunkByURL(config.bar.image).bitmap.bitmapData;

							inputBarSkin.barSkin.getAssetsFromAtlas(inputBarSkinBD);
							inputBarSkin.parseConfig(config);

							break;

						default:
							isSupported = false;
					}
				}
				catch(err:Error) {
					throw new Error(printf("Asset error: %s", err.message));
				}
			}

			if(isSupported) {
				return skin;
			}
			else {
				return null;
			}
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
	}
}
