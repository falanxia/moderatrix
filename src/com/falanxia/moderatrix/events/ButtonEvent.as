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

package com.falanxia.moderatrix.events {
	import flash.events.Event;



	/**
	 * Button event.
	 *
	 * Buttons dispatch all different kinds of events.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class ButtonEvent extends Event {


		/** Dragged over button */
		public static const DRAG_OVER:String = "buttonEvent:dragOver";

		/** Dragget out of the button */
		public static const DRAG_OUT:String = "buttonEvent:dragOut";

		/** Drag was confirmed */
		public static const DRAG_CONFIRM:String = "buttonEvent:dragConfirm";

		/** Hovering in */
		public static const HOVER_IN:String = "buttonEvent:hoverIn";

		/** Hovering out */
		public static const HOVER_OUT:String = "buttonEvent:hoverOut";

		/** Focusing in */
		public static const FOCUS_IN:String = "buttonEvent:focusIn";

		/** Releasing inside the button */
		public static const RELEASE_INSIDE:String = "buttonEvent:releaseInside";

		/** Releasing outside the button */
		public static const RELEASE_OUTSIDE:String = "buttonEvent:releaseOutside";

		/** Hover in tween starting (when a synchronized animation is needed) */
		public static const HOVER_IN_TWEEN:String = "buttonEvent:hoverInTween";

		/** Hover out tween starting (when a synchronized animation is needed) */
		public static const HOVER_OUT_TWEEN:String = "buttonEvent:hoverOutTween";

		/** Focus in tween starting (when a synchronized animation is needed) */
		public static const FOCUS_IN_TWEEN:String = "buttonEvent:focusInTween";

		/** Drag confirmed tween starting (when a synchronized animation is needed) */
		public static const DRAG_CONFIRMED_TWEEN:String = "buttonEvent:dragConfirmedTween";

		/** Released inside tween starting (when a synchronized animation is needed) */
		public static const RELEASED_INSIDE_TWEEN:String = "buttonEvent:releasedInsideTween";

		/** Released outside tween starting (when a synchronized animation is needed) */
		public static const RELEASED_OUTSIDE_TWEEN:String = "buttonEvent:releasedOutsideTween";



		/**
		 * Constructor.
		 * @param type Event type
		 * @param bubbles Bubbling flag
		 * @param cancelable Cancelable flag
		 */
		public function ButtonEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
