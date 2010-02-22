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

package com.falanxia.moderatrix.widgets {
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.ButtonSkin;
	import com.falanxia.utilitaris.display.ScaleBitmapSprite;
	import com.falanxia.utilitaris.utils.DisplayUtils;
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;

	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;



	/** @todo Comment */
	public class ScaleButton extends ButtonCore implements IWidget {


		private var outSBS:ScaleBitmapSprite;
		private var hoverSBS:ScaleBitmapSprite;
		private var focusSBS:ScaleBitmapSprite;



		/** @todo Comment */
		public function ScaleButton(skin:ButtonSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			super(skin, c, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);

			// TODO: Maybe needed in other classes
			if(config.width != undefined) this.width = config.width;
			if(config.height != undefined) this.height = config.height;
		}



		/**
		 * @todo Comment
		 * @todo Optimize
		 */
		override public function draw():void {
			super.draw();

			if(_size.width != 0) {
				outSBS.width = _size.width;
				hoverSBS.width = _size.width;
				focusSBS.width = _size.width;
			}
			if(_size.height != 0) {
				outSBS.height = _size.height;
				hoverSBS.height = _size.height;
				focusSBS.height = _size.height;
			}

			activeSpr.size = size;
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		override public function set skin(skin:ButtonSkin):void {
			super.skin = skin;

			var rect:Rectangle = _skin.guideBD.getColorBoundsRect(0x00FF0000, 0x00000000, false);

			// TODO: Outer rect

			outSBS.setData(_skin.outBD, rect);
			outSBS.setData(_skin.outBD, rect);
			hoverSBS.setData(_skin.hoverBD, rect);
			focusSBS.setData(_skin.focusBD, rect);

			draw();
		}



		/* ★ PROTECTED METHODS ★ */


		/** @todo Comment */
		override protected function init():void {
			super.init();

			isMorphWidthEnabled = true;
			isMorphHeightEnabled = true;
			isChangeWidthEnabled = true;
			isChangeHeightEnabled = true;
		}



		/** @todo Comment */
		override protected function addChildren():void {
			super.addChildren();

			outSBS = new ScaleBitmapSprite();
			hoverSBS = new ScaleBitmapSprite();
			focusSBS = new ScaleBitmapSprite();

			hoverSBS.alpha = 0;
			focusSBS.alpha = 0;

			outSBS.mouseEnabled = false;
			hoverSBS.mouseEnabled = false;
			focusSBS.mouseEnabled = false;

			DisplayUtils.addChildren(contentSpr, outSBS, hoverSBS, focusSBS);
		}



		/** @todo Comment */
		override protected function removeChildren():void {
			super.removeChildren();

			DisplayUtils.removeChildren(contentSpr, outSBS, hoverSBS, focusSBS);
		}



		/** @todo Comment */
		override protected function hoverInTween():void {
			new TweenMax(outSBS, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(hoverSBS, _skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(focusSBS, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super.hoverInTween();
		}



		/** @todo Comment */
		override protected function hoverOutTween():void {
			new TweenMax(outSBS, _skin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(hoverSBS, _skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(focusSBS, _skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});

			super.hoverOutTween();
		}



		/** @todo Comment */
		override protected function focusInTween():void {
			new TweenMax(outSBS, _skin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(hoverSBS, _skin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(focusSBS, _skin.focusInDuration, {alpha:1, ease:Sine.easeOut});

			super.focusInTween();
		}



		/** @todo Comment */
		override protected function dragConfirmedTween():void {
			new TweenMax(outSBS, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(hoverSBS, _skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(focusSBS, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super.dragConfirmedTween();
		}



		/** @todo Comment */
		override protected function releasedInsideTween():void {
			new TweenMax(outSBS, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(hoverSBS, _skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(focusSBS, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			super.releasedInsideTween();
		}



		/** @todo Comment */
		override protected function releasedOutsideTween():void {
			new TweenMax(outSBS, _skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(hoverSBS, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(focusSBS, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			super.releasedOutsideTween();
		}
	}
}
