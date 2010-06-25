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
	import com.falanxia.utilitaris.enums.*;
	import com.falanxia.utilitaris.helpers.*;

	import flash.filters.*;



	/**
	 * TODO: Documentation
	 */
	public class LabelSkin extends Skin {


		protected var _hAlign:String;
		protected var _vAlign:String;
		protected var _bold:Boolean;
		protected var _blockIndent:Number;
		protected var _bullet:Boolean;
		protected var _color:uint;
		protected var _font:String;
		protected var _indent:Number;
		protected var _italic:Boolean;
		protected var _kerning:Boolean;
		protected var _leading:Number;
		protected var _letterSpacing:Number;
		protected var _size:Number;
		protected var _underline:Boolean;
		protected var _url:String;
		protected var _alpha:Number;
		protected var _filters:Array;
		protected var _sharpness:Number;
		protected var _thickness:Number;
		protected var _paddingTop:Number;
		protected var _paddingBottom:Number;
		protected var _paddingLeft:Number;
		protected var _paddingRight:Number;
		protected var _marginLeft:Number;
		protected var _marginRight:Number;

		private var oldHAlign:String;
		private var oldVAlign:String;
		private var oldBold:Boolean;
		private var oldBlockIndent:Number;
		private var oldBullet:Boolean;
		private var oldColor:uint;
		private var oldFont:String;
		private var oldIndent:Number;
		private var oldItalic:Boolean;
		private var oldKerning:Boolean;
		private var oldLeading:Number;
		private var oldLetterSpacing:Number;
		private var oldSize:Number;
		private var oldUnderline:Boolean;
		private var oldURL:String;
		private var oldAlpha:Number;
		private var oldFilters:Array;
		private var oldSharpness:Number;
		private var oldThickness:Number;
		private var oldPaddingTop:Number;
		private var oldPaddingBottom:Number;
		private var oldPaddingLeft:Number;
		private var oldPaddingRight:Number;
		private var oldMarginLeft:Number;
		private var oldMarginRight:Number;



		/**
		 * TODO: Documentation
		 * @param id
		 */
		public function LabelSkin(id:String = null) {
			super(SkinType.LABEL, id);

			_hAlign = Align.LEFT;
			_vAlign = Align.TOP;
			_bold = false;
			_blockIndent = 0;
			_bullet = false;
			_color = 0x000000;
			_font = null;
			_indent = 0;
			_italic = false;
			_kerning = false;
			_leading = 0;
			_letterSpacing = 0;
			_size = 10;
			_underline = false;
			_url = null;
			_alpha = 1;
			_filters = new Array();
			_sharpness = 0;
			_thickness = 0;
			_paddingTop = 0;
			_paddingBottom = 0;
			_paddingLeft = 0;
			_paddingRight = 0;
			_marginLeft = 0;
			_marginRight = 0;
		}



		/**
		 * Destroys the {@code LabelSkin} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_hAlign = null;
			_vAlign = null;
			_font = null;
			_url = null;
			_filters = null;

			oldHAlign = null;
			oldVAlign = null;
			oldFont = null;
			oldURL = null;
			oldFilters = null;
		}



		/**
		 * TODO: Documentation
		 * @param source
		 */
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			// TODO: Figure out how to speed up this mess:
			oldHAlign = _hAlign;
			oldVAlign = _vAlign;
			oldBold = _bold;
			oldBlockIndent = _blockIndent;
			oldBullet = _bullet;
			oldColor = _color;
			oldFont = _font;
			oldIndent = _indent;
			oldItalic = _italic;
			oldKerning = _kerning;
			oldLeading = _leading;
			oldLetterSpacing = _letterSpacing;
			oldSize = _size;
			oldUnderline = _underline;
			oldURL = _url;
			oldAlpha = _alpha;
			oldFilters = _filters;
			oldSharpness = _sharpness;
			oldThickness = _thickness;
			oldPaddingTop = _paddingTop;
			oldPaddingBottom = _paddingBottom;
			oldPaddingLeft = _paddingLeft;
			oldPaddingRight = _paddingRight;
			oldMarginLeft = _marginLeft;
			oldMarginRight = _marginRight;

			// TODO: This is the way how to speed up skins, apply it everywhere
			for(var i:String in source) if(i != "filters") this["_" + i] = source[i];

			// TODO: Add this functionality to all skins where it's needed
			if(source.filters != undefined && source.filters is Array) {
				for each(var f:* in source.filters) {
					if(f is BitmapFilter) {
						// bitmapFilter means we got filter already converted
						_filters.push(f);
					}
					else {
						if(f is Object) {
							// it's an Object, we need to convert it first
							try {
								switch(f.filter) {
									case "DropShadow" :
										var dsDistance:Number = (f.distance == undefined) ? 1 : f.distance;
										var dsAngle:Number = (f.angle == undefined) ? 45 : f.angle;
										var dsColor:Number = (f.color == undefined) ? 0x000000 : f.color;
										var dsAlpha:Number = (f.alpha == undefined) ? 0.5 : f.alpha;
										var dsBlur:Number = (f.blur == undefined) ? 1 : f.blur;
										var dsStrength:Number = (f.strength == undefined) ? 1 : f.strength;
										var dsQuality:Number = (f.quality == undefined) ? 1 : f.quality;
										var dsInner:Boolean = (f.inner == undefined) ? false : f.inner;
										var dsKnockout:Boolean = (f.knockout == undefined) ? false : f.knockout;
										var dsHideObject:Boolean = (f.hideObject == undefined) ? false : f.hideObject;
										var g:DropShadowFilter = new DropShadowFilter(dsDistance, dsAngle, dsColor, dsAlpha, dsBlur, dsBlur, dsStrength, dsQuality, dsInner, dsKnockout, dsHideObject);
										_filters.push(g);
										break;

									default:
								}
							}
							catch(err:Error) {
								throw new Error(printf("Error converting filters Object to native filters (%s)", err.message));
							}
						}
					}
				}
			}
		}



		/**
		 * TODO: Documentation
		 */
		override public function revertConfig():void {
			super.revertConfig();

			_hAlign = oldHAlign;
			_vAlign = oldVAlign;
			_bold = oldBold;
			_blockIndent = oldBlockIndent;
			_bullet = oldBullet;
			_color = oldColor;
			_font = oldFont;
			_indent = oldIndent;
			_italic = oldItalic;
			_kerning = oldKerning;
			_leading = oldLeading;
			_letterSpacing = oldLetterSpacing;
			_size = oldSize;
			_underline = oldUnderline;
			_url = oldURL;
			_alpha = oldAlpha;
			_filters = oldFilters;
			_sharpness = oldSharpness;
			_thickness = oldThickness;
			_paddingTop = oldPaddingTop;
			_paddingBottom = oldPaddingBottom;
			_paddingLeft = oldPaddingLeft;
			_paddingRight = oldPaddingRight;
			_marginLeft = oldMarginLeft;
			_marginRight = oldMarginRight;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get hAlign():String {
			return _hAlign;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set hAlign(value:String):void {
			_hAlign = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get vAlign():String {
			return _vAlign;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set vAlign(value:String):void {
			_vAlign = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get bold():Boolean {
			return _bold;
		}



		/***
		 * TODO: Documentation
		 * @param value
		 */
		public function set bold(value:Boolean):void {
			_bold = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get blockIndent():Number {
			return _blockIndent;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set blockIndent(value:Number):void {
			_blockIndent = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get bullet():Boolean {
			return _bullet;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set bullet(value:Boolean):void {
			_bullet = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get color():uint {
			return _color;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set color(value:uint):void {
			_color = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get font():String {
			return _font;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set font(value:String):void {
			_font = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get indent():Number {
			return _indent;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set indent(value:Number):void {
			_indent = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get italic():Boolean {
			return _italic;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set italic(value:Boolean):void {
			_italic = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get kerning():Boolean {
			return _kerning;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set kerning(value:Boolean):void {
			_kerning = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get leading():Number {
			return _leading;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set leading(value:Number):void {
			_leading = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get letterSpacing():Number {
			return _letterSpacing;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set letterSpacing(value:Number):void {
			_letterSpacing = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get size():Number {
			return _size;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set size(value:Number):void {
			_size = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get underline():Boolean {
			return _underline;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set underline(value:Boolean):void {
			_underline = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get url():String {
			return _url;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set url(value:String):void {
			_url = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get alpha():Number {
			return _alpha;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set alpha(value:Number):void {
			_alpha = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get filters():Array {
			return _filters;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set filters(value:Array):void {
			_filters = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get sharpness():Number {
			return _sharpness;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set sharpness(value:Number):void {
			_sharpness = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get thickness():Number {
			return _thickness;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set thickness(value:Number):void {
			_thickness = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get paddingTop():Number {
			return _paddingTop;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set paddingTop(value:Number):void {
			_paddingTop = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get paddingBottom():Number {
			return _paddingBottom;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set paddingBottom(value:Number):void {
			_paddingBottom = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get paddingLeft():Number {
			return _paddingLeft;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set paddingLeft(value:Number):void {
			_paddingLeft = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get paddingRight():Number {
			return _paddingRight;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set paddingRight(value:Number):void {
			_paddingRight = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get marginLeft():Number {
			return _marginLeft;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set marginLeft(value:Number):void {
			_marginLeft = value;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get marginRight():Number {
			return _marginRight;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set marginRight(value:Number):void {
			_marginRight = value;
		}
	}
}
