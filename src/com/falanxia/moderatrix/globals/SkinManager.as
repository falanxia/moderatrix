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


package com.falanxia.moderatrix.globals {
	import com.falanxia.emitor.Asset;
	import com.falanxia.emitor.AssetCollection;
	import com.falanxia.emitor.AssetManager;
	import com.falanxia.moderatrix.enums.SkinType;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.skin.AtlasSkin;
	import com.falanxia.moderatrix.skin.BarSkin;
	import com.falanxia.moderatrix.skin.ButtonSkin;
	import com.falanxia.moderatrix.skin.ContainerSkin;
	import com.falanxia.moderatrix.skin.ImageSkin;
	import com.falanxia.moderatrix.skin.LabelSkin;
	import com.falanxia.moderatrix.skin.meta.CheckButtonSkin;
	import com.falanxia.moderatrix.skin.meta.CountBadgeSkin;
	import com.falanxia.moderatrix.skin.meta.GlyphButtonSkin;
	import com.falanxia.moderatrix.skin.meta.GlyphLabelButtonSkin;
	import com.falanxia.moderatrix.skin.meta.GlyphSkin;
	import com.falanxia.moderatrix.skin.meta.InputBarSkin;
	import com.falanxia.moderatrix.skin.meta.LabelButtonSkin;



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


		private static var instance:SkinManager;

		private var assetManager:AssetManager;
		private var defaultCollection:AssetCollection;



		/**
		 * Constructor.
		 */
		public function SkinManager(s:Senf) {
			if(s == null) throw new Error("SkinManager is singleton, use getInstance() method");
		}



		/**
		 * Singleton acces method
		 * @return Instance of the SkinManager singleton.
		 */
		public static function getInstance():SkinManager {
			if(instance == null) instance = new SkinManager(new Senf());

			return instance;
		}



		/**
		 * Convert asset data to a skin.
		 * @param asset Asset data Object
		 * @return Skin
		 */
		public function assetToSkin(asset:Asset):ISkin {
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
							skin = new ContainerSkin(config, null);
							break;

						case SkinType.BAR:
							skin = new BarSkin(config, null, asset);
							break;

						case SkinType.IMAGE:
							skin = new ImageSkin(config, null, asset);
							break;

						case SkinType.ATLAS:
							skin = new AtlasSkin(config, null, asset);
							break;

						case SkinType.BUTTON:
							skin = new ButtonSkin(config, null, asset);
							break;

						case SkinType.LABEL:
							skin = new LabelSkin(config, null);
							break;

						case SkinType.LABEL_BUTTON:
							skin = new LabelButtonSkin(config, null, asset);
							break;

						case SkinType.GLYPH_BUTTON:
							skin = new GlyphButtonSkin(config, null, asset);
							break;

						case SkinType.GLYPH_LABEL_BUTTON:
							skin = new GlyphLabelButtonSkin(config, null, asset);
							break;

						case SkinType.GLYPH:
							skin = new GlyphSkin(config, null, asset);
							break;

						case SkinType.CHECK_BUTTON:
							skin = new CheckButtonSkin(config, null, asset);
							break;

						case SkinType.INPUT_BAR:
							skin = new InputBarSkin(config, null, asset);
							break;

						case SkinType.COUNT_BADGE:
							skin = new CountBadgeSkin(config, null, asset);
							break;

						default:
							isSupported = false;
					}
				}
				catch(err:Error) {
					throw new Error("Asset error: " + err.message);
				}
			}

			return isSupported ? skin : null;
		}



		/**
		 * Get asset from the asset collection.
		 * If no asset collection ID is provided, default one is used instead.
		 * @param assetID Asset ID
		 * @param collectionID (optional) Asset collection ID
		 * @return Skin
		 * @see ISkin
		 */
		public function a2s(assetID:String, collectionID:String = null):ISkin {
			if(assetManager == null) {
				assetManager = AssetManager.getInstance();
			}

			if(defaultCollection == null) {
				defaultCollection = assetManager.getCollection();
			}

			var collection:AssetCollection = (collectionID == null) ? defaultCollection : assetManager.getCollection(collectionID);

			return (collection == null) ? null : assetToSkin(collection.getAsset(assetID));
		}
	}
}



class Senf {
}
