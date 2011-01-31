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

package com.falanxia.moderatrix.widgets.meta {
	import com.falanxia.moderatrix.enums.DebugLevel;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.meta.ImageLabelSkin;
	import com.falanxia.moderatrix.widgets.Image;
	import com.falanxia.moderatrix.widgets.Label;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObjectContainer;



	public class ImageLabel extends MorphSprite implements IWidget {


		public var image:Image;
		public var label:Label;

		protected var _skin:ImageLabelSkin;

		private var _debugLevel:String;
		private var _debugColor:RGBA;



		/**
		 * Create a new glyph label button instance.
		 * @param skin Skin to be used (use ImageLabelButtonSkin)
		 * @param displayConfig Configuration Object
		 * @param text Initial text
		 * @param displayParent Parent DisplayObjectContainer
		 * @param debugLevel Debug level ({@see DebugLevel})
		 * @throws Error if no skin defined
		 */
		public function ImageLabel(skin:ImageLabelSkin, displayConfig:Object = null, text:String = "", displayParent:DisplayObjectContainer = null,
		                           debugLevel:String = null) {
			_skin = skin;

			image = new Image(skin.imageSkin, {mouseEnabled:false, mouseChildren:false}, this);
			label = new Label(skin.labelSkin, {mouseEnabled:false, mouseChildren:false}, text, this);

			label.textField.wordWrap = false;

			this.focusRect = false;
			this.debugLevel = (debugLevel == null) ? DebugLevel.NONE : debugLevel;
			this.debugColor = DisplayUtils.DEBUG_BLUE;

			var c:Object = (displayConfig == null) ? new Object() : displayConfig;

			super(c, displayParent);

			draw();
		}



		/**
		 * Destroys ImageLabelButton instance and frees it for GC.
		 */
		override public function destroy():void {
			DisplayUtils.removeChildren(this, image, label);

			image.destroy();
			label.destroy();

			super.destroy();

			image = null;
			label = null;

			_skin = null;
			_debugLevel = null;
			_debugColor = null;
		}



		/**
		 * Draw the widget.
		 */
		public function draw():void {
			image.draw();
			label.draw();

			label.x = image.width;
			label.height = image.height;
		}



		/**
		 * Get current skin.
		 * @return Current skin
		 */
		public function get skin():ISkin {
			return _skin;
		}



		/**
		 * Set skin.
		 * @param value Skin
		 */
		public function set skin(value:ISkin):void {
			if(value != null) {
				_skin = ImageLabelSkin(value);

				image.skin = _skin.imageSkin;
				label.skin = _skin.labelSkin;
			}
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;

			image.debugLevel = value;
			label.debugLevel = value;
		}



		public function get debugColor():RGBA {
			return _debugColor;
		}



		public function set debugColor(value:RGBA):void {
			_debugColor = value;

			image.debugColor = value;
			label.debugColor = value;
		}
	}
}
