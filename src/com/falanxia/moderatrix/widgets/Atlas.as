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
	import com.falanxia.moderatrix.skin.*;
	import com.falanxia.utilitaris.display.*;
	import com.falanxia.utilitaris.helpers.*;
	import com.falanxia.utilitaris.utils.*;
	import com.greensock.*;
	import com.greensock.easing.*;

	import flash.display.*;
	import flash.geom.*;



	/**
	 * TODO: Documentation
	 */
	public class Atlas extends Widget {


		protected var _skin:AtlasSkin;
		protected var _phase:uint = 0;

		protected var imageBM:QBitmap;



		/**
		 * TODO: Documentation
		 * @param skin
		 * @param config
		 * @param parent
		 * @param debugLevel
		 */
		public function Atlas(skin:AtlasSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object;

			if(config == null) {
				c = new Object();
			}
			else {
				c = config;
			}

			if(c.width == undefined) c.width = skin.assetSize.width;
			if(c.height == undefined) c.height = skin.assetSize.height;

			//noinspection NegatedIfStatementJS
			if(skin != null) {
				super(c, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
			}
			else {
				throw new Error("No skin defined");
			}

			this.skin = skin;
		}



		/**
		 * Destroys {@code Atlas} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			imageBM.destroy();

			_skin = null;
			imageBM = null;
		}



		/**
		 * TODO: Documentation
		 * TODO: Optimize
		 */
		override public function draw():void {
			super.draw();

			var assetSize:Rectangle = _skin.assetSize;
			var w:uint = assetSize.width;
			var rect:Rectangle = new Rectangle(_phase * w, 0, w, assetSize.height);

			imageBM.bitmapData.copyPixels(_skin.imageBD, rect, new Point(0, 0));

			if(_skin != null) {
				if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) {
					if(!_size.isEmpty()) DisplayUtils.strokeBounds(debugSpr, new Rectangle(0, 0, assetSize.width, assetSize.height), _debugColor, 5);
				}
			}
		}



		/**
		 * Play from a certain phase to the end. If no phase is defined, plays from first one.
		 * @param durationMultiplier Duration multiplier (0.1 by default, means 10 phases will take 1 second to animate)
		 * @param startPhase Start phase
		 * @param endPhase End phase (if not defined, the last phase is used and final phase will be the first one when the animation ends
		 */
		public function playFromStart(durationMultiplier:Number = 0.1, startPhase:uint = 0, endPhase:int = -1):void {
			this.phase = startPhase;

			if(endPhase == -1) endPhase = this.length;

			TweenLite.to(this, durationMultiplier * (endPhase - startPhase + 1), {phase:endPhase, ease:Linear.easeNone, onComplete:checkReset, onCompleteParams:[endPhase]});
		}



		/**
		 * Reset to the first phase.
		 */
		public function reset():void {
			phase = 0;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get skin():AtlasSkin {
			return _skin;
		}



		/**
		 * TODO: Documentation
		 * @param skin
		 */
		public function set skin(skin:AtlasSkin):void {
			_skin = skin;

			if(_size.width == 0) _size.width = _skin.assetSize.width;
			if(_size.height == 0) _size.height = _skin.assetSize.height;

			imageBM.bitmapData = new BitmapData(_skin.assetSize.width, _skin.assetSize.height);
			imageBM.smoothing = true;

			draw();
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get bitmap():QBitmap {
			return imageBM;
		}



		/**
		 * TODO: Documentation
		 * @param value
		 */
		public function set phase(value:uint):void {
			if(value != phase) {
				if(value > this.length) {
					throw new Error(printf('Atlas phase too high (%d), only %d phases available', value, this.length));
				}
				else {
					_phase = value;
					draw();
				}
			}
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get phase():uint {
			return _phase;
		}



		/**
		 * TODO: Documentation
		 * @return
		 */
		public function get length():uint {
			return (_skin.imageBD == null) ? 0 : _skin.imageBD.width / _skin.assetSize.width;
		}



		/**
		 * TODO: Documentation
		 */
		override protected function init():void {
			super.init();

			isMorphWidthEnabled = false;
			isMorphHeightEnabled = false;
			isChangeWidthEnabled = false;
			isChangeHeightEnabled = false;
		}



		/**
		 * TODO: Documentation
		 */
		override protected function addChildren():void {
			super.addChildren();

			imageBM = new QBitmap();

			DisplayUtils.addChildren(contentSpr, imageBM);
		}



		/** TODO: Documentation */
		override protected function removeChildren():void {
			super.removeChildren();

			DisplayUtils.removeChildren(contentSpr, imageBM);
		}



		/**
		 * Check for reset.
		 * @param endPhase End phase
		 */
		private function checkReset(endPhase:int):void {
			if(endPhase == length) reset();
		}
	}
}
