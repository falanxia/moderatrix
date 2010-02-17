// Falanxia Moderatrix.
//
// Copyright (c) 2010 Falanxia (http://falanxia.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

package com.falanxia.moderatrix.skin {
	import com.falanxia.moderatrix.constants.Align;
	import com.falanxia.moderatrix.constants.SkinType;

	import com.falanxia.utilitaris.helpers.printf;

	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;



	/** @todo Comment */
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

		private var _oldHAlign:String;
		private var _oldVAlign:String;
		private var _oldBold:Boolean;
		private var _oldBlockIndent:Number;
		private var _oldBullet:Boolean;
		private var _oldColor:uint;
		private var _oldFont:String;
		private var _oldIndent:Number;
		private var _oldItalic:Boolean;
		private var _oldKerning:Boolean;
		private var _oldLeading:Number;
		private var _oldLetterSpacing:Number;
		private var _oldSize:Number;
		private var _oldUnderline:Boolean;
		private var _oldURL:String;
		private var _oldAlpha:Number;
		private var _oldFilters:Array;
		private var _oldSharpness:Number;
		private var _oldThickness:Number;
		private var _oldPaddingTop:Number;
		private var _oldPaddingBottom:Number;
		private var _oldPaddingLeft:Number;
		private var _oldPaddingRight:Number;
		private var _oldMarginLeft:Number;
		private var _oldMarginRight:Number;



		/** @todo Comment */
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



		/** @todo Comment */
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			// TODO: Figure out how to speed up this mess:
			_oldHAlign = _hAlign;
			_oldVAlign = _vAlign;
			_oldBold = _bold;
			_oldBlockIndent = _blockIndent;
			_oldBullet = _bullet;
			_oldColor = _color;
			_oldFont = _font;
			_oldIndent = _indent;
			_oldItalic = _italic;
			_oldKerning = _kerning;
			_oldLeading = _leading;
			_oldLetterSpacing = _letterSpacing;
			_oldSize = _size;
			_oldUnderline = _underline;
			_oldURL = _url;
			_oldAlpha = _alpha;
			_oldFilters = _filters;
			_oldSharpness = _sharpness;
			_oldThickness = _thickness;
			_oldPaddingTop = _paddingTop;
			_oldPaddingBottom = _paddingBottom;
			_oldPaddingLeft = _paddingLeft;
			_oldPaddingRight = _paddingRight;
			_oldMarginLeft = _marginLeft;
			_oldMarginRight = _marginRight;

			// TODO: This is the way how to speed up skins, apply it everywhere
			for(var i:String in source) if(i != "filters") this["_" + i] = source[i];

			// TODO: Add this functionality to all skins where it's needed
			if(source.filters != undefined && source.filters is Array) {
				for each(var f:* in source.filters) {
					if(f is BitmapFilter) {
						// bitmapFilter means we got filter already converted
						_filters.push(f);
					} else if(f is Object) {
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



		/** @todo Comment */
		override public function revertConfig():void {
			super.revertConfig();

			_hAlign = _oldHAlign;
			_vAlign = _oldVAlign;
			_bold = _oldBold;
			_blockIndent = _oldBlockIndent;
			_bullet = _oldBullet;
			_color = _oldColor;
			_font = _oldFont;
			_indent = _oldIndent;
			_italic = _oldItalic;
			_kerning = _oldKerning;
			_leading = _oldLeading;
			_letterSpacing = _oldLetterSpacing;
			_size = _oldSize;
			_underline = _oldUnderline;
			_url = _oldURL;
			_alpha = _oldAlpha;
			_filters = _oldFilters;
			_sharpness = _oldSharpness;
			_thickness = _oldThickness;
			_paddingTop = _oldPaddingTop;
			_paddingBottom = _oldPaddingBottom;
			_paddingLeft = _oldPaddingLeft;
			_paddingRight = _oldPaddingRight;
			_marginLeft = _oldMarginLeft;
			_marginRight = _oldMarginRight;
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		public function get hAlign():String {
			return _hAlign;
		}



		/** @todo Comment */
		public function set hAlign(value:String):void {
			_hAlign = value;
		}



		/** @todo Comment */
		public function get vAlign():String {
			return _vAlign;
		}



		/** @todo Comment */
		public function set vAlign(value:String):void {
			_vAlign = value;
		}



		/** @todo Comment */
		public function get bold():Boolean {
			return _bold;
		}



		/** @todo Comment */
		public function set bold(value:Boolean):void {
			_bold = value;
		}



		/** @todo Comment */
		public function get blockIndent():Number {
			return _blockIndent;
		}



		/** @todo Comment */
		public function set blockIndent(value:Number):void {
			_blockIndent = value;
		}



		/** @todo Comment */
		public function get bullet():Boolean {
			return _bullet;
		}



		/** @todo Comment */
		public function set bullet(value:Boolean):void {
			_bullet = value;
		}



		/** @todo Comment */
		public function get color():uint {
			return _color;
		}



		/** @todo Comment */
		public function set color(value:uint):void {
			_color = value;
		}



		/** @todo Comment */
		public function get font():String {
			return _font;
		}



		/** @todo Comment */
		public function set font(value:String):void {
			_font = value;
		}



		/** @todo Comment */
		public function get indent():Number {
			return _indent;
		}



		/** @todo Comment */
		public function set indent(value:Number):void {
			_indent = value;
		}



		/** @todo Comment */
		public function get italic():Boolean {
			return _italic;
		}



		/** @todo Comment */
		public function set italic(value:Boolean):void {
			_italic = value;
		}



		/** @todo Comment */
		public function get kerning():Boolean {
			return _kerning;
		}



		/** @todo Comment */
		public function set kerning(value:Boolean):void {
			_kerning = value;
		}



		/** @todo Comment */
		public function get leading():Number {
			return _leading;
		}



		/** @todo Comment */
		public function set leading(value:Number):void {
			_leading = value;
		}



		/** @todo Comment */
		public function get letterSpacing():Number {
			return _letterSpacing;
		}



		/** @todo Comment */
		public function set letterSpacing(value:Number):void {
			_letterSpacing = value;
		}



		/** @todo Comment */
		public function get size():Number {
			return _size;
		}



		/** @todo Comment */
		public function set size(value:Number):void {
			_size = value;
		}



		/** @todo Comment */
		public function get underline():Boolean {
			return _underline;
		}



		/** @todo Comment */
		public function set underline(value:Boolean):void {
			_underline = value;
		}



		/** @todo Comment */
		public function get url():String {
			return _url;
		}



		/** @todo Comment */
		public function set url(value:String):void {
			_url = value;
		}



		/** @todo Comment */
		public function get alpha():Number {
			return _alpha;
		}



		/** @todo Comment */
		public function set alpha(value:Number):void {
			_alpha = value;
		}



		/** @todo Comment */
		public function get filters():Array {
			return _filters;
		}



		/** @todo Comment */
		public function set filters(value:Array):void {
			_filters = value;
		}



		/** @todo Comment */
		public function get sharpness():Number {
			return _sharpness;
		}



		/** @todo Comment */
		public function set sharpness(value:Number):void {
			_sharpness = value;
		}



		/** @todo Comment */
		public function get thickness():Number {
			return _thickness;
		}



		/** @todo Comment */
		public function set thickness(value:Number):void {
			_thickness = value;
		}



		/** @todo Comment */
		public function get paddingTop():Number {
			return _paddingTop;
		}



		/** @todo Comment */
		public function set paddingTop(value:Number):void {
			_paddingTop = value;
		}



		/** @todo Comment */
		public function get paddingBottom():Number {
			return _paddingBottom;
		}



		/** @todo Comment */
		public function set paddingBottom(value:Number):void {
			_paddingBottom = value;
		}



		/** @todo Comment */
		public function get paddingLeft():Number {
			return _paddingLeft;
		}



		/** @todo Comment */
		public function set paddingLeft(value:Number):void {
			_paddingLeft = value;
		}



		/** @todo Comment */
		public function get paddingRight():Number {
			return _paddingRight;
		}



		/** @todo Comment */
		public function set paddingRight(value:Number):void {
			_paddingRight = value;
		}



		/** @todo Comment */
		public function get marginLeft():Number {
			return _marginLeft;
		}



		/** @todo Comment */
		public function set marginLeft(value:Number):void {
			_marginLeft = value;
		}



		/** @todo Comment */
		public function get marginRight():Number {
			return _marginRight;
		}



		/** @todo Comment */
		public function set marginRight(value:Number):void {
			_marginRight = value;
		}
	}
}
