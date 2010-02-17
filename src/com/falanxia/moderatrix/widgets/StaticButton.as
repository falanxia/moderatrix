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
	import com.falanxia.utilitaris.display.QBitmap;
	import com.falanxia.utilitaris.utils.DisplayUtils;
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;

	import flash.display.DisplayObjectContainer;



	/** @todo Comment */
	public class StaticButton extends ButtonCore implements IWidget {


		private var _outBM:QBitmap;
		private var _hoverBM:QBitmap;
		private var _focusBM:QBitmap;



		/** @todo Comment */
		public function StaticButton(skin:ButtonSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                             debugLevel:String = null) {
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			super(skin, c, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
		}



		/** @todo Comment */
		override public function draw():void {
			super.draw();

			_activeSpr.size = _size;
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		override public function set skin(skin:ButtonSkin):void {
			super.skin = skin;

			_outBM.bitmapData = _skin.outBD;
			_hoverBM.bitmapData = _skin.hoverBD;
			_focusBM.bitmapData = _skin.focusBD;

			draw();
		}



		/* ★ PROTECTED METHODS ★ */


		/** @todo Comment */
		override protected function _init():void {
			super._init();

			isMorphWidthEnabled = false;
			isMorphHeightEnabled = false;
			isChangeWidthEnabled = false;
			isChangeHeightEnabled = false;
		}



		/** @todo Comment */
		override protected function _addChildren():void {
			super._addChildren();

			_outBM = new QBitmap({}, _contentSpr);
			_hoverBM = new QBitmap({alpha:0}, _contentSpr);
			_focusBM = new QBitmap({alpha:0}, _contentSpr);
		}



		/** @todo Comment */
		override protected function _removeChildren():void {
			super._removeChildren();

			DisplayUtils.removeChildren(_contentSpr, _outBM, _hoverBM, _focusBM);
		}



		/** @todo Comment */
		override protected function _hoverInTween():void {
			new TweenMax(_outBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverBM, _skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_focusBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super._hoverInTween();
		}



		/** @todo Comment */
		override protected function _hoverOutTween():void {
			new TweenMax(_outBM, _skin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_hoverBM, _skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_focusBM, _skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});

			super._hoverOutTween();
		}



		/** @todo Comment */
		override protected function _focusInTween():void {
			new TweenMax(_outBM, _skin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverBM, _skin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_focusBM, _skin.focusInDuration, {alpha:1, ease:Sine.easeOut});

			super._focusInTween();
		}



		/** @todo Comment */
		override protected function _dragConfirmedTween():void {
			new TweenMax(_outBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverBM, _skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_focusBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super._dragConfirmedTween();
		}



		/** @todo Comment */
		override protected function _releasedInsideTween():void {
			new TweenMax(_outBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverBM, _skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_focusBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			super._releasedInsideTween();
		}



		/** @todo Comment */
		override protected function _releasedOutsideTween():void {
			new TweenMax(_outBM, _skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_hoverBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_focusBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			super._releasedOutsideTween();
		}
	}
}
