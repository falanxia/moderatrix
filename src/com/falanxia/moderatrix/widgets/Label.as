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

package com.falanxia.moderatrix.widgets {
	import com.falanxia.moderatrix.enums.*;
	import com.falanxia.moderatrix.globals.*;
	import com.falanxia.moderatrix.interfaces.*;
	import com.falanxia.moderatrix.skin.*;
	import com.falanxia.utilitaris.display.*;
	import com.falanxia.utilitaris.enums.*;
	import com.falanxia.utilitaris.utils.*;

	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.utils.*;



	public class Label extends Widget implements IWidget {


		protected var _textField:QTextField;
		protected var _textFormat:TextFormat;

		private var _isWidthOverriden:Boolean;
		private var _isHeightOverriden:Boolean;
		private var _vAlign:String;
		private var _isInput:Boolean;



		public function Label(skin:LabelSkin, config:Object = null, text:String = "", parent:DisplayObjectContainer = null, debugLevel:String = null
				) {

			var c:Object = config == null ? new Object() : config;

			//noinspection NegatedIfStatementJS
			if(skin != null) {
				super(c, parent, (debugLevel == null) ? SkinManager.defaultDebugLevel : debugLevel);
			}
			else {
				throw new Error("No skin defined");
			}

			_isWidthOverriden = (c.width != undefined);
			_isHeightOverriden = (c.height != undefined);

			this.skin = skin;
			this.text = text;
		}



		/**
		 * Destroys Label instance and frees it for GC.
		 */
		override public function destroy():void {
			removeChildren();

			_textField.destroy();

			super.destroy();

			_skin = null;
			_textField = null;
			_textFormat = null;
			_vAlign = null;
		}



		override public function draw():void {
			super.draw();

			if(_skin != null && _size != null) {
				var skinSettings:Dictionary = _skin.settings;
				var paddingLeft:Number = skinSettings["paddingLeft"];
				var paddingTop:Number = skinSettings["paddingTop"];
				var paddingRight:Number = skinSettings["paddingRight"];
				var paddingBottom:Number = skinSettings["paddingBottom"];
				var rect:Rectangle = new Rectangle(paddingLeft, paddingTop, _size.width - paddingLeft - paddingRight, _size.height - paddingTop - paddingBottom);

				if(_size.width != 0) _textField.width = rect.width;

				if(_size.height != 0) {
					// set label height
					_textField.height = rect.height;

					// non-top alignment
					if(_vAlign == Align.CENTER) {
						_textField.y = Math.round((rect.height - _textField.textHeight) / 2) + skinSettings.paddingTop;
					}
					if(_vAlign == Align.BOTTOM) {
						_textField.y = rect.height - _textField.textHeight + skinSettings.paddingTop;
					}
				}

				if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) {
					if(rect.top == rect.bottom) rect.bottom += 30;
					DisplayUtils.strokeBounds(debugSpr, rect, _debugColor, 5);
				}
			}
		}



		override public function get tabEnabled():Boolean {
			return _textField.tabEnabled;
		}



		override public function set tabIndex(index:int):void {
			_textField.tabIndex = index;

			draw();
		}



		override public function get tabIndex():int {
			return _textField.tabIndex;
		}



		override public function set tabEnabled(enabled:Boolean):void {
			_textField.tabEnabled = enabled;

			draw();
		}



		override public function set debugLevel(value:String):void {
			super.debugLevel = value;

			_textField.border = (_debugLevel == DebugLevel.ALWAYS);
			_textField.borderColor = _debugColor.color32;

			draw();
		}



		/**
		 * Set skin.
		 * @param value Skin
		 */
		override public function set skin(value:ISkin):void {
			if(value != null) {
				super.skin = value;

				var settings:Dictionary = _skin.settings;

				_vAlign = settings["vAlign"];

				_textFormat = new TextFormat();
				_textFormat.align = settings["hAlign"];
				_textFormat.blockIndent = settings["blockIndent"];
				_textFormat.bold = settings["bold"];
				_textFormat.bullet = settings["bullet"];
				_textFormat.color = settings["color"];
				_textFormat.font = settings["font"];
				_textFormat.indent = settings["indent"];
				_textFormat.italic = settings["italic"];
				_textFormat.kerning = settings["kerning"];
				_textFormat.leading = settings["leading"];
				_textFormat.leftMargin = settings["marginLeft"];
				_textFormat.letterSpacing = settings["letterSpacing"];
				_textFormat.rightMargin = settings["marginRight"];
				_textFormat.size = settings["size"];
				_textFormat.underline = settings["underline"];
				_textFormat.url = settings["url"];

				_textField.setTextFormat(_textFormat);
				_textField.defaultTextFormat = _textFormat;
				_textField.position = new Point(settings["paddingLeft"], settings["paddingTop"]);
				_textField.filters = settings["filters"];
				_textField.sharpness = settings["sharpness"];
				_textField.thickness = settings["thickness"];
				_textField.alpha = settings["alpha"];
				_textField.embedFonts = (settings["font"] != "");

				if(_size.width == 0) _size.width = _skin.bitmapSize.width;
				if(_size.height == 0) _size.height = _skin.bitmapSize.height;
			}
		}



		public function get text():String {
			return _textField.text;
		}



		public function set text(value:String):void {
			var v:String = value;

			if(_textField != null) {
				_textField.defaultTextFormat = _textFormat;

				if(v != null) {
					if(v == "") {
						// fix alignment problem when empty string was applied to the html enabled TextField
						// noinspection ReuseOfLocalVariableJS
						v = "&nbsp;";
					}

					_textField.htmlText = v;

					draw();
				}
			}

			draw();
		}



		public function get textField():TextField {
			return _textField;
		}



		override public function get width():Number {
			var settings:Dictionary = _skin.settings;

			return (_isWidthOverriden) ? _textField.width : _textField.textWidth + settings["paddingLeft"] + settings["paddingRight"];
		}



		override public function get height():Number {
			var settins:Dictionary = _skin.settings;

			return (_isHeightOverriden) ? _textField.height : _textField.textHeight + settins["paddingTop"] + settins["paddingBottom"];
		}



		override public function get x():Number {
			return super.x - _skin.settings["paddingLeft"];
		}



		override public function get y():Number {
			return super.y - _skin.settings["paddingTop"];
		}



		public function get isInput():Boolean {
			return _isInput;
		}



		public function get isPassword():Boolean {
			return _textField.displayAsPassword;
		}



		public function set isPassword(value:Boolean):void {
			_textField.displayAsPassword = value;

			draw();
		}



		public function set isInput(value:Boolean):void {
			if(_textField != null) {
				_textField.type = (value) ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
				_textField.selectable = value;
				_textField.multiline = !value;
				_textField.condenseWhite = !value;

				if(value) _textField.autoSize = TextFieldAutoSize.NONE;

				_textFormat.kerning = !value;
				_textField.setTextFormat(_textFormat);
			}

			_isInput = value;

			draw();
		}



		override protected function init():void {
			super.init();

			_textFormat = new TextFormat();

			isMorphWidthEnabled = true;
			isMorphHeightEnabled = true;
			isChangeWidthEnabled = true;
			isChangeHeightEnabled = true;
		}



		override protected function addChildren():void {
			super.addChildren();

			_textField = new QTextField({width:2880, autoSize:(_isWidthOverriden) ? TextFieldAutoSize.NONE : Align.LEFT, borderColor:_debugColor, border:(_debugLevel == DebugLevel.ALWAYS)}, contentSpr);
		}



		override protected function removeChildren():void {
			super.removeChildren();

			DisplayUtils.removeChildren(contentSpr, _textField);
		}



		override protected function onDebugOver(e:MouseEvent):void {
			super.onDebugOver(e);

			if(_debugLevel == DebugLevel.HOVER) {
				_textField.border = true;
			}
		}



		override protected function onDebugOut(e:MouseEvent):void {
			super.onDebugOut(e);

			if(_debugLevel == DebugLevel.HOVER) {
				_textField.border = false;
			}
		}
	}
}
