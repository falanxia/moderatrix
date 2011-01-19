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

package com.falanxia.moderatrix.widgets {
	import com.falanxia.moderatrix.enums.DebugLevel;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.utilitaris.display.QTextField;
	import com.falanxia.utilitaris.enums.Align;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;



	/**
	 * Label.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class Label extends Widget implements IWidget {


		public var textField:QTextField;

		protected var _textFormat:TextFormat;

		private var _isWidthOverriden:Boolean;
		private var _isHeightOverriden:Boolean;
		private var _vAlign:String;
		private var _isInput:Boolean;



		/**
		 * Constructor.
		 * @param skin Widget skin
		 * @param displayConfig (optional) Display config
		 * @param text (optional) Text
		 * @param displayParent (optional) Display parent
		 * @param debugLevel (optional) Debug level
		 * @see ISkin
		 * @see DebugLevel
		 */
		public function Label(skin:ISkin, displayConfig:Object = null, text:String = "", displayParent:DisplayObjectContainer = null,
		                      debugLevel:String = null) {
			var c:Object = displayConfig == null ? new Object() : displayConfig;
			var dl:String = (debugLevel == null) ? DebugLevel.NONE : debugLevel;

			_isWidthOverriden = (c.width != undefined);
			_isHeightOverriden = (c.height != undefined);

			super(c, displayParent, dl);

			this.skin = skin;
			this.text = text;

			draw();
		}



		/**
		 * Destroys Label instance and frees it for GC.
		 */
		override public function destroy():void {
			removeChildren();

			textField.destroy();

			super.destroy();

			textField = null;

			_skin = null;
			_textFormat = null;
			_vAlign = null;
		}



		/**
		 * Draw the widget.
		 */
		override public function draw():void {
			super.draw();

			if(_skin != null && _skin.settings != null && _size != null) {
				var skinSettings:Dictionary = _skin.settings;
				var paddingLeft:Number = skinSettings["paddingLeft"];
				var paddingTop:Number = skinSettings["paddingTop"];
				var paddingRight:Number = skinSettings["paddingRight"];
				var paddingBottom:Number = skinSettings["paddingBottom"];
				var rect:Rectangle = new Rectangle(paddingLeft, paddingTop, _size.width - paddingLeft - paddingRight, _size.height - paddingTop - paddingBottom);

				if(_size.width != 0) textField.width = rect.width;

				if(_size.height != 0) {
					// set label height
					textField.height = rect.height;

					// non-top alignment
					if(_vAlign == Align.CENTER) {
						textField.y = Math.round((rect.height - textField.textHeight) / 2) + skinSettings.paddingTop;
					}
					if(_vAlign == Align.BOTTOM) {
						textField.y = rect.height - textField.textHeight + skinSettings.paddingTop;
					}
				}

				if(_debugLevel != DebugLevel.NONE) {
					if(rect.top == rect.bottom) rect.bottom += 30;
					DisplayUtils.strokeBounds(debugSpr, rect, _debugColor, 5);
				}
			}
		}



		/**
		 * Get the tab enabled status.
		 * @return true if tab is enabled for this widget
		 */
		override public function get tabEnabled():Boolean {
			return textField.tabEnabled;
		}



		/**
		 * Set tab enabled status.
		 * @param value true if tab is enabled for this widget
		 */
		override public function set tabEnabled(value:Boolean):void {
			textField.tabEnabled = value;

			invalidate();
		}



		/**
		 * Get the tab index.
		 * @return Tab index for this widget
		 */
		override public function get tabIndex():int {
			return textField.tabIndex;
		}



		/**
		 * Set the tab index.
		 * @param value Tab index for this widget
		 */
		override public function set tabIndex(value:int):void {
			textField.tabIndex = value;

			invalidate();
		}



		/**
		 * Set the debug level.
		 * @param value Debug level
		 * @see DebugLevel
		 */
		override public function set debugLevel(value:String):void {
			super.debugLevel = value;

			textField.border = (_debugLevel == DebugLevel.ALWAYS);
			textField.borderColor = _debugColor.color32;

			invalidate();
		}



		/**
		 * Set skin.
		 * @param value Skin
		 * @see ISkin
		 */
		override public function set skin(value:ISkin):void {
			if(value != null) {
				super.skin = value;

				if(value.settings != null) {
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

					textField.setTextFormat(_textFormat);
					textField.defaultTextFormat = _textFormat;
					textField.position = new Point(settings["paddingLeft"], settings["paddingTop"]);
					textField.filters = settings["filters"];
					textField.sharpness = settings["sharpness"];
					textField.thickness = settings["thickness"];
					textField.alpha = settings["alpha"];
					textField.embedFonts = (settings["font"] != "");
				}

				if(_skin.bitmapSize != null) {
					if(_size.width == 0) _size.width = _skin.bitmapSize.width;
					if(_size.height == 0) _size.height = _skin.bitmapSize.height;
				}
			}
		}



		/**
		 * Get current text.
		 * @return Current text
		 */
		public function get text():String {
			return textField.text;
		}



		/**
		 * Set current text
		 * @param value Current text
		 */
		public function set text(value:String):void {
			if(textField != null) {
				textField.defaultTextFormat = _textFormat;

				if(value == "") {
					// fix alignment problem when empty string was applied to the html enabled TextField
					value = " ";
				}

				textField.text = value;

				invalidate();
			}
		}



		/**
		 * Get widget width.
		 * @return Widget width
		 */
		override public function get width():Number {
			if(_skin != null && _skin.settings != null) {
				var settings:Dictionary = _skin.settings;

				return (_isWidthOverriden) ? textField.width : textField.textWidth + settings["paddingLeft"] + settings["paddingRight"];
			}

			else {
				return 0;
			}
		}



		/**
		 * Get widget height.
		 * @return Widget height
		 */
		override public function get height():Number {
			if(_skin != null && _skin.settings != null) {
				var settins:Dictionary = _skin.settings;

				return (_isHeightOverriden) ? textField.height : textField.textHeight + settins["paddingTop"] + settins["paddingBottom"];
			}

			else {
				return 0;
			}
		}



		/**
		 * Get widget X position (including optional horizontal padding)
		 * @return Widget X position
		 */
		override public function get x():Number {
			return (_skin != null && _skin.settings != null) ? (super.x - _skin.settings["paddingLeft"]) : 0;
		}



		/**
		 * Get widget Y position (including optional vertical padding).
		 * @return Widget Y position
		 */
		override public function get y():Number {
			return (_skin != null && _skin.settings != null) ? (super.y - _skin.settings["paddingTop"]) : 0;
		}



		/**
		 * Get input flag.
		 * @return true if widget is an input field.
		 */
		public function get isInput():Boolean {
			return _isInput;
		}



		/**
		 * Set input flag.
		 * @param value true if widget is an input field.
		 */
		public function set isInput(value:Boolean):void {
			if(textField != null) {
				textField.type = (value) ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
				textField.selectable = value;
				textField.multiline = false;
				textField.condenseWhite = !value;

				if(value) textField.autoSize = TextFieldAutoSize.NONE;

				_textFormat.kerning = !value;
				textField.setTextFormat(_textFormat);
			}

			_isInput = value;

			invalidate();
		}



		/**
		 * Get password flag.
		 * @return true if widget is a password field.
		 */
		public function get isPassword():Boolean {
			return textField.displayAsPassword;
		}



		/**
		 * Set password flag.
		 * @param value true if widget is a password field.
		 */
		public function set isPassword(value:Boolean):void {
			textField.displayAsPassword = value;

			invalidate();
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

			textField = new QTextField({width:2880, autoSize:(_isWidthOverriden) ? TextFieldAutoSize.NONE : Align.LEFT, multiline:false, borderColor:_debugColor, border:(_debugLevel == DebugLevel.ALWAYS)}, contentSpr);
		}



		override protected function removeChildren():void {
			super.removeChildren();

			DisplayUtils.removeChildren(contentSpr, textField);
		}



		override protected function onDebugOver(e:MouseEvent):void {
			super.onDebugOver(e);

			if(_debugLevel == DebugLevel.HOVER) {
				textField.border = true;
			}
		}



		override protected function onDebugOut(e:MouseEvent):void {
			super.onDebugOut(e);

			if(_debugLevel == DebugLevel.HOVER) {
				textField.border = false;
			}
		}
	}
}
