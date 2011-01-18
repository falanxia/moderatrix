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
	import com.falanxia.moderatrix.skin.AtlasSkin;
	import com.falanxia.utilitaris.display.QBitmap;
	import com.falanxia.utilitaris.utils.DisplayUtils;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;



	/**
	 * Atlas.
	 *
	 * Atlas is basically an animated Image.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class Atlas extends Widget implements IWidget {


		protected var _phase:uint = 0;

		protected var imageBM:QBitmap;
		protected var loop:Boolean;
		protected var startPhase:uint;
		protected var endPhase:int;
		protected var durationMultiplier:Number;
		protected var spriteWidth:uint;



		/**
		 * Constructor.
		 * @param skin Initial skin
		 * @param displayConfig Config Object
		 * @param displayParent Parent DisplayObjectContainer
		 * @param debugLevel Initial debug level
		 * @see DebugLevel
		 */
		public function Atlas(skin:AtlasSkin, displayConfig:Object = null, displayParent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object = displayConfig == null ? new Object() : displayConfig;
			var dl:String = (debugLevel == null) ? DebugLevel.NONE : debugLevel;

			if(c.width == undefined && skin.settings != null) c.width = skin.settings["spriteWidth"];
			if(c.height == undefined) c.height = skin.bitmapSize.height;

			super(c, displayParent, dl);

			this.skin = skin;

			draw();
		}



		/**
		 * Destroys Atlas instance and frees it for GC.
		 */
		override public function destroy():void {
			imageBM.destroy();

			super.destroy();

			_skin = null;
			imageBM = null;
		}



		/**
		 * Draw the widget.
		 */
		override public function draw():void {
			if(_skin != null && _size != null) {
				super.draw();

				var w:uint = spriteWidth;
				var rect:Rectangle = new Rectangle(_phase * w, 0, w, _skin.bitmapSize.height);

				imageBM.bitmapData.copyPixels(AtlasSkin(_skin).bitmapSources[AtlasSkin.ATLAS_BITMAP], rect, new Point(0, 0));

				if(_debugLevel != DebugLevel.NONE) {
					DisplayUtils.strokeBounds(debugSpr, new Rectangle(0, 0, w, _skin.bitmapSize.height), _debugColor, 5);
				}
			}
		}



		/**
		 * Play from a certain phase to the end. If no phase is defined, plays from first one.
		 * @param durationMultiplier Duration multiplier (0.1 by default, means 10 phases will take 1 second to animate)
		 * @param startPhase Start phase
		 * @param endPhase End phase (if not defined, the last phase is used and final phase will be the first one when the animation ends
		 * @param loop true to set looping on
		 */
		public function playFromStart(durationMultiplier:Number = 0.1, startPhase:uint = 0, endPhase:int = -1, loop:Boolean = false):void {
			this.phase = startPhase;

			if(endPhase == -1) endPhase = this.length;

			this.durationMultiplier = durationMultiplier;
			this.startPhase = startPhase;
			this.endPhase = endPhase;
			this.loop = loop;

			TweenMax.to(this, durationMultiplier * (endPhase - startPhase + 1), {phase:endPhase, ease:Linear.easeNone, onComplete:checkReset, onCompleteParams:[endPhase]});
		}



		/**
		 * Reset to the first phase.
		 */
		public function reset():void {
			phase = startPhase;
		}



		/**
		 * Set skin.
		 * @param value Skin
		 */
		override public function set skin(value:ISkin):void {
			if(value != null) {
				super.skin = value;

				if(skin.settings != null) spriteWidth = _skin.settings["spriteWidth"];

				if(_size.width == 0) _size.width = spriteWidth;

				if(_skin.bitmapSize != null) {
					if(_size.height == 0) _size.height = _skin.bitmapSize.height;

					imageBM.bitmapData = new BitmapData(spriteWidth, _skin.bitmapSize.height);
					imageBM.smoothing = true;
				}
			}
		}



		/**
		 * Get current Atlas bitmap.
		 * @return Current Atlas bitmap
		 */
		public function get bitmap():QBitmap {
			return imageBM;
		}



		/**
		 * Set phase.
		 * @param value Phase
		 */
		public function set phase(value:uint):void {
			if(value != phase) {
				if(value > this.length) {
					throw new Error("Atlas phase too high (" + value + "), only " + this.length + " phases available");
				} else {
					_phase = value;
					invalidate();
				}
			}
		}



		/**
		 * Get current phase.
		 * @return Current phase
		 */
		public function get phase():uint {
			return _phase;
		}



		/**
		 * Get length of animation in frames.
		 * @return Length
		 */
		public function get length():uint {
			if(_skin == null) {
				return 0;
			} else {
				var skin:AtlasSkin = AtlasSkin(_skin);

				return (skin.bitmapSources == null) ? 0 : skin.bitmapSources[AtlasSkin.ATLAS_BITMAP].width / spriteWidth;
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

			imageBM = new QBitmap();

			DisplayUtils.addChildren(contentSpr, imageBM);
		}



		override protected function removeChildren():void {
			super.removeChildren();

			DisplayUtils.removeChildren(contentSpr, imageBM);
		}



		private function checkReset(endPhase:int):void {
			if(endPhase == length) {
				reset();

				dispatchEvent(new Event(Event.COMPLETE));

				if(loop) playFromStart(durationMultiplier, startPhase, endPhase, loop);
			}
		}
	}
}
