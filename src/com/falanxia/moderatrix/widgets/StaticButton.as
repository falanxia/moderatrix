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
	import com.falanxia.moderatrix.globals.*;
	import com.falanxia.moderatrix.interfaces.*;
	import com.falanxia.moderatrix.skin.*;
	import com.falanxia.utilitaris.display.*;
	import com.falanxia.utilitaris.utils.*;
	import com.greensock.*;
	import com.greensock.easing.*;

	import flash.display.*;



	public class StaticButton extends ButtonCore implements IWidget {


		private var outBM:QBitmap;
		private var hoverBM:QBitmap;
		private var focusBM:QBitmap;



		public function StaticButton(skin:ButtonSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object;

			if(config == null) {
				c = new Object();
			}
			else {
				c = config;
			}

			super(skin, c, parent, (debugLevel == null) ? SkinManager.defaultDebugLevel : debugLevel);
		}



		/**
		 * Destroys StaticButton instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			forceRelease();

			// removeChildren();
			// was removed due to multiple item removal
			// TODO: Test if it's needed

			outBM.destroy();
			hoverBM.destroy();
			focusBM.destroy();

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



		override public function set skin(skin:ButtonSkin):void {
			super.skin = skin;

			outBM.bitmapData = _skin.assetSources[ButtonSkin.OUT_ASSET];
			hoverBM.bitmapData = _skin.assetSources[ButtonSkin.HOVER_ASSET];
			focusBM.bitmapData = _skin.assetSources[ButtonSkin.FOCUS_ASSET];

			invalidate();
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
			var hoverInDuration:Number = _skin.settings["hoverInDuration"];

			new TweenLite(outBM, hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(hoverBM, hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(focusBM, hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super.hoverInTween();
		}



		override protected function hoverOutTween():void {
			var hoverOutDuration:Number = _skin.settings["hoverOutDuration"];

			new TweenLite(outBM, hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(hoverBM, hoverOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(focusBM, hoverOutDuration, {alpha:0, ease:Sine.easeIn});

			super.hoverOutTween();
		}



		override protected function focusInTween():void {
			var focusInDuration:Number = _skin.settings["focusInDuration"];

			new TweenLite(outBM, focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(hoverBM, focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(focusBM, focusInDuration, {alpha:1, ease:Sine.easeOut});

			super.focusInTween();
		}



		override protected function dragConfirmedTween():void {
			var hoverInDuration:Number = _skin.settings["hoverInDuration"];

			new TweenLite(outBM, hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(hoverBM, hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(focusBM, hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super.dragConfirmedTween();
		}



		override protected function releasedInsideTween():void {
			var focusOutDuration:Number = _skin.settings["focusOutDuration"];

			new TweenLite(outBM, focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(hoverBM, focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(focusBM, focusOutDuration, {alpha:0, ease:Sine.easeIn});

			super.releasedInsideTween();
		}



		override protected function releasedOutsideTween():void {
			var focusInDuration:Number = _skin.settings["focusOutDuration"];

			new TweenLite(outBM, focusInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(hoverBM, focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(focusBM, focusInDuration, {alpha:0, ease:Sine.easeIn});

			super.releasedOutsideTween();
		}
	}
}
