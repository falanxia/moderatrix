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
	import com.falanxia.moderatrix.enums.MouseStatus;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.meta.GlyphSkin;
	import com.falanxia.moderatrix.widgets.Image;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObjectContainer;



	public class Glyph extends MorphSprite implements IWidget {


		public var glyphOut:Image;
		public var glyphHover:Image;
		public var glyphFocus:Image;

		protected var _skin:GlyphSkin;

		private var _debugLevel:String;
		private var _mouseStatus:String;



		public function Glyph(skin:GlyphSkin, displayConfig:Object = null, displayParent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object = displayConfig == null ? new Object() : displayConfig;
			var dl:String = (debugLevel == null) ? DebugLevel.NONE : debugLevel;
			var dc:RGBA = DisplayUtils.RED;

			glyphOut = new Image(skin.glyphOutSkin, {mouseEnabled:false, mouseChildren:false}, this, dl);
			glyphHover = new Image(skin.glyphHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dl);
			glyphFocus = new Image(skin.glyphFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dl);

			glyphOut.debugColor = dc;
			glyphHover.debugColor = dc;
			glyphFocus.debugColor = dc;

			this.skin = skin;
			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;

			if(c.width == undefined) c.width = skin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.bitmapSize.height;

			super(c, displayParent);

			_skin = skin;
			_debugLevel = dl;
		}



		/**
		 * Destroys GlyphButton instance and frees it for GC.
		 */
		override public function destroy():void {
			DisplayUtils.removeChildren(this, glyphOut, glyphHover, glyphFocus);

			glyphOut.destroy();
			glyphHover.destroy();
			glyphFocus.destroy();

			super.destroy();

			glyphOut = null;
			glyphHover = null;
			glyphFocus = null;

			_skin = null;
			_debugLevel = null;
		}



		public function draw():void {
			glyphOut.draw();
			glyphHover.draw();
			glyphFocus.draw();
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
				_skin = GlyphSkin(value);

				glyphOut.skin = _skin.glyphOutSkin;
				glyphHover.skin = _skin.glyphHoverSkin;
				glyphFocus.skin = _skin.glyphFocusSkin;
			}
		}



		override public function set width(value:Number):void {
		}



		override public function set height(value:Number):void {
		}



		public function get mouseStatus():String {
			return _mouseStatus;
		}



		public function set mouseStatus(value:String):void {
			_mouseStatus = value;

			glyphOut.alpha = (_mouseStatus == MouseStatus.OUT) ? 1.0 : 0.0;
			glyphHover.alpha = (_mouseStatus == MouseStatus.HOVER) ? 1.0 : 0.0;
			glyphFocus.alpha = (_mouseStatus == MouseStatus.FOCUS) ? 1.0 : 0.0;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;

			glyphOut.debugLevel = value;
			glyphHover.debugLevel = value;
			glyphFocus.debugLevel = value;
		}



		public function get currentGlyph():Image {
			var out:Image;

			switch(_mouseStatus) {
				case MouseStatus.HOVER:
					out = glyphOut;
					break;

				case MouseStatus.FOCUS:
					out = glyphFocus;
					break;

				default:
					out = glyphOut;
			}

			return out;
		}
	}
}
