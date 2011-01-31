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

package com.falanxia.moderatrix.widgets.addons {
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.widgets.Label;

	import flash.display.DisplayObjectContainer;



	/**
	 * Rich text Label.
	 *
	 * @author Vaclav Vancura / Falanxia a.s.
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 2.0
	 */
	public class RichTextLabel extends Label implements IWidget {



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
		public function RichTextLabel(skin:ISkin, displayConfig:Object = null, text:String = "", displayParent:DisplayObjectContainer = null,
		                              debugLevel:String = null) {
			super(skin, displayConfig, text, displayParent, debugLevel);
		}



		/**
		 * Set input flag.
		 * @param value true if widget is an input field.
		 */
		override public function set isInput(value:Boolean):void {
			if(textField != null) {
				textField.multiline = !value;
			}

			super.isInput = value;
		}



		override protected function addChildren():void {
			super.addChildren();

			textField.multiline = true;
		}



		/**
		 * Set current text
		 * @param value Current text
		 */
		override public function set text(value:String):void {
			if(textField != null) {
				textField.defaultTextFormat = _textFormat;

				if(value == "") {
					// fix alignment problem when empty string was applied to the html enabled TextField
					value = "&nbsp;";
				}

				textField.htmlText = value;

				invalidate();
			}
		}
	}
}
