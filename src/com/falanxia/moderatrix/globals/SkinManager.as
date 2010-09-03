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
	import com.falanxia.moderatrix.skin.meta.*;
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


		private static var _defaultDebugLevel:String = DebugLevel.NONE;
		private static var _defaultDebugColor:RGBA = new RGBA(255, 0, 0, 0.25 * 255);



		/**
		 * Convert asset data to a skin.
		 * @param asset Asset data Object
		 * @return Skin
		 */
		public static function assetToSkin(asset:Asset):ISkin {
			if(asset.config.widget == null) {
				throw new Error("Asset is null");
			}

			else {
				var skin:ISkin;
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



		public static function get defaultDebugLevel():String {
			return _defaultDebugLevel;
		}



		public static function set defaultDebugLevel(value:String):void {
			_defaultDebugLevel = value;
		}



		public static function get defaultDebugColor():RGBA {
			return _defaultDebugColor;
		}



		public static function set defaultDebugColor(value:RGBA):void {
			_defaultDebugColor = value;
		}



		private static function createContainerSkin(config:Object):ISkin {
			var skin:ContainerSkin = new ContainerSkin();

			skin.parseConfig(config);

			return skin;
		}



		private static function createBarSkin(config:Object, asset:Asset):ISkin {
			var skin:BarSkin = new BarSkin();

			skin.getBitmapsFromAtlas(new <BitmapData>[
				asset.getChunkByURL(config.image).bitmap.bitmapData
			]);

			skin.parseConfig(config);

			return skin;
		}



		private static function createImageSkin(config:Object, asset:Asset):ISkin {
			var skin:ImageSkin = new ImageSkin();

			skin.getBitmapsFromAtlas(new <BitmapData>[
				asset.getChunkByURL(config.image).bitmap.bitmapData
			]);

			skin.parseConfig(config);

			return skin;
		}



		private static function createAtlasSkin(config:Object, asset:Asset):ISkin {
			var skin:AtlasSkin = new AtlasSkin();

			skin.getBitmapsFromAtlas(new <BitmapData>[
				asset.getChunkByURL(config.image).bitmap.bitmapData
			]);

			skin.parseConfig(config);

			return skin;
		}



		private static function createButtonSkin(config:Object, asset:Asset):ISkin {
			var skin:ButtonSkin = new ButtonSkin();

			skin.getBitmapsFromAtlas(new <BitmapData>[
				asset.getChunkByURL(config.image).bitmap.bitmapData
			]);

			skin.parseConfig(config);

			return skin;
		}



		private static function createLabelSkin(config:Object):ISkin {
			var skin:LabelSkin = new LabelSkin();

			skin.parseConfig(config);

			return skin;
		}



		private static function createLabelButtonSkin(config:Object, asset:Asset):ISkin {
			var skin:LabelButtonSkin = new LabelButtonSkin();

			skin.buttonSkin.getBitmapsFromAtlas(new <BitmapData>[
				asset.getChunkByURL(config.button.image).bitmap.bitmapData
			]);

			skin.parseConfig(config);

			return skin;
		}



		private static function createGlyphButtonSkin(config:Object, asset:Asset):ISkin {
			var skin:GlyphButtonSkin = new GlyphButtonSkin();

			skin.buttonSkin.getBitmapsFromAtlas(new <BitmapData>[
				asset.getChunkByURL(config.button.image).bitmap.bitmapData
			]);

			skin.glyphSkin.getBitmapsFromAtlas(new <BitmapData>[
				asset.getChunkByURL(config.glyph.image).bitmap.bitmapData
			]);

			skin.parseConfig(config);

			return skin;
		}



		private static function createGlyphLabelButtonSkin(config:Object, asset:Asset):ISkin {
			var skin:GlyphLabelButtonSkin = new GlyphLabelButtonSkin();

			skin.buttonSkin.getBitmapsFromAtlas(new <BitmapData>[
				asset.getChunkByURL(config.button.image).bitmap.bitmapData
			]);

			skin.glyphSkin.getBitmapsFromAtlas(new <BitmapData>[
				asset.getChunkByURL(config.glyph.image).bitmap.bitmapData
			]);

			skin.parseConfig(config);

			return skin;
		}



		private static function createCheckButtonSkin(config:Object, asset:Asset):ISkin {
			var skin:CheckButtonSkin = new CheckButtonSkin();

			skin.buttonOffSkin.getBitmapsFromAtlas(new <BitmapData>[
				asset.getChunkByURL(config.buttonOff.image).bitmap.bitmapData
			]);

			skin.buttonOnSkin.getBitmapsFromAtlas(new <BitmapData>[
				asset.getChunkByURL(config.buttonOn.image).bitmap.bitmapData
			]);

			skin.parseConfig(config);

			return skin;
		}



		private static function createInputBarSkin(config:Object, asset:Asset):ISkin {
			var skin:InputBarSkin = new InputBarSkin();

			skin.barSkin.getBitmapsFromAtlas(new <BitmapData>[
				asset.getChunkByURL(config.bar.image).bitmap.bitmapData
			]);

			skin.parseConfig(config);

			return skin;
		}
	}
}
