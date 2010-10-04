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
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.ButtonSkin;
	import com.falanxia.utilitaris.display.QBitmap;
	import com.falanxia.utilitaris.utils.DisplayUtils;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;

	import flash.display.DisplayObjectContainer;



	public class StaticButton extends ButtonCore implements IWidget {


		private var outBM:QBitmap;
		private var hoverBM:QBitmap;
		private var focusBM:QBitmap;



		public function StaticButton(skin:ButtonSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object = config == null ? new Object() : config;
			var dl:String = (debugLevel == null) ? SkinManager.defaultDebugLevel : debugLevel;

			if(c.width == undefined) c.width = skin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.bitmapSize.height;

			super(skin, c, parent, dl);

			draw();
		}



		/**
		 * Destroys StaticButton instance and frees it for GC.
		 */
		override public function destroy():void {
			forceRelease();

			outBM.destroy();
			hoverBM.destroy();
			focusBM.destroy();

			super.destroy();

			outBM = null;
			hoverBM = null;
			focusBM = null;
		}



		override public function draw():void {
			if(_size != null) {
				super.draw();

				activeSpr.size = _size;
			}
		}



		/**
		 * Set skin.
		 * @param value Skin
		 */
		override public function set skin(value:ISkin):void {
			if(value != null) {
				super.skin = value;

				var skin:ButtonSkin = ButtonSkin(_skin);

				if(skin.bitmapSources != null) {
					outBM.bitmapData = skin.bitmapSources[ButtonSkin.OUT_BITMAP];
					hoverBM.bitmapData = skin.bitmapSources[ButtonSkin.HOVER_BITMAP];
					focusBM.bitmapData = skin.bitmapSources[ButtonSkin.FOCUS_BITMAP];
				}
			}
		}



		override protected function init():void {
			super.init();

			isMorphWidthEnabled = false;
			isMorphHeightEnabled = false;
			isChangeWidthEnabled = false;
			isChangeHeightEnabled = false;
		}



		override protected function addChildren():void {
			super.addChildren();

			outBM = new QBitmap({}, contentSpr);
			hoverBM = new QBitmap({alpha:0}, contentSpr);
			focusBM = new QBitmap({alpha:0}, contentSpr);
		}



		/**
		 * Remove children.
		 */
		override protected function removeChildren():void {
			super.removeChildren();

			DisplayUtils.removeChildren(contentSpr, outBM, hoverBM, focusBM);
		}



		override protected function hoverInTween():void {
			if(_skin != null && _skin.settings != null) {
				var hoverInDuration:Number = _skin.settings["hoverInDuration"];

				new TweenMax(outBM, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(hoverBM, hoverInDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(focusBM, hoverInDuration, {alpha:0, ease:Cubic.easeIn});

				super.hoverInTween();
			}
		}



		override protected function hoverOutTween():void {
			if(_skin != null && _skin.settings != null) {
				var hoverOutDuration:Number = _skin.settings["hoverOutDuration"];

				new TweenMax(outBM, hoverOutDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(hoverBM, hoverOutDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(focusBM, hoverOutDuration, {alpha:0, ease:Cubic.easeIn});

				super.hoverOutTween();
			}
		}



		override protected function focusInTween():void {
			if(_skin != null && _skin.settings != null) {
				var focusInDuration:Number = _skin.settings["focusInDuration"];

				new TweenMax(outBM, focusInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(hoverBM, focusInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(focusBM, focusInDuration, {alpha:1, ease:Cubic.easeOut});

				super.focusInTween();
			}
		}



		override protected function dragConfirmedTween():void {
			if(_skin != null && _skin.settings != null) {
				var hoverInDuration:Number = _skin.settings["hoverInDuration"];

				new TweenMax(outBM, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(hoverBM, hoverInDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(focusBM, hoverInDuration, {alpha:0, ease:Cubic.easeIn});

				super.dragConfirmedTween();
			}
		}



		override protected function releasedInsideTween():void {
			if(_skin != null && _skin.settings != null) {
				var focusOutDuration:Number = _skin.settings["focusOutDuration"];

				new TweenMax(outBM, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(hoverBM, focusOutDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(focusBM, focusOutDuration, {alpha:0, ease:Cubic.easeIn});

				super.releasedInsideTween();
			}
		}



		override protected function releasedOutsideTween():void {
			if(_skin != null && _skin.settings != null) {
				var focusInDuration:Number = _skin.settings["focusOutDuration"];

				new TweenMax(outBM, focusInDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(hoverBM, focusInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(focusBM, focusInDuration, {alpha:0, ease:Cubic.easeIn});

				super.releasedOutsideTween();
			}
		}
	}
}
