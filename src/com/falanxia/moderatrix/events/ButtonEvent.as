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

package com.falanxia.moderatrix.events {
	import flash.events.Event;



	/** TODO: Documentation */
	public class ButtonEvent extends Event {



		/** TODO: Documentation */
		public static const DRAG_OVER:String = "buttonDragOver";

		/** TODO: Documentation */
		public static const DRAG_OUT:String = "buttonDragOut";

		/** TODO: Documentation */
		public static const DRAG_CONFIRM:String = "buttonDragConfirm";

		/** TODO: Documentation */
		public static const HOVER_IN:String = "buttonHoverIn";

		/** TODO: Documentation */
		public static const HOVER_OUT:String = "buttonHoverOut";

		/** TODO: Documentation */
		public static const FOCUS_IN:String = "buttonFocusIn";

		/** TODO: Documentation */
		public static const RELEASE_INSIDE:String = "buttonReleaseInside";

		/** TODO: Documentation */
		public static const RELEASE_OUTSIDE:String = "buttonReleaseOutside";

		/** TODO: Documentation */
		public static const HOVER_IN_TWEEN:String = "buttonHoverInTween";

		/** TODO: Documentation */
		public static const HOVER_OUT_TWEEN:String = "buttonHoverOutTween";

		/** TODO: Documentation */
		public static const FOCUS_IN_TWEEN:String = "buttonFocusInTween";

		/** TODO: Documentation */
		public static const DRAG_CONFIRMED_TWEEN:String = "buttonDragConfirmedTween";

		/** TODO: Documentation */
		public static const RELEASED_INSIDE_TWEEN:String = "buttonReleasedInsideTween";

		/** TODO: Documentation */
		public static const RELEASED_OUTSIDE_TWEEN:String = "buttonReleasedOutsideTween";



		/** TODO: Documentation */
		public function ButtonEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}



		/** TODO: Documentation */
		public override function clone():Event {
			return new ButtonEvent(type, bubbles, cancelable);
		}



		/** TODO: Documentation */
		public override function toString():String {
			return formatToString("ButtonEvent", "type", "bubbles", "cancelable");
		}
	}
}
