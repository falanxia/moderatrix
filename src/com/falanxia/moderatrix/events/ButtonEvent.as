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

package com.falanxia.moderatrix.events {
	import flash.events.Event;



	/** @todo Comment */
	public class ButtonEvent extends Event {



		/** @todo Comment */
		public static const DRAG_OVER:String = 'button_drag_over';

		/** @todo Comment */
		public static const DRAG_OUT:String = 'button_drag_out';

		/** @todo Comment */
		public static const DRAG_CONFIRM:String = 'button_drag_confirm';

		/** @todo Comment */
		public static const HOVER_IN:String = 'button_hover_in';

		/** @todo Comment */
		public static const HOVER_OUT:String = 'button_hover_out';

		/** @todo Comment */
		public static const FOCUS_IN:String = 'button_focus_in';

		/** @todo Comment */
		public static const RELEASE_INSIDE:String = 'button_release_inside';

		/** @todo Comment */
		public static const RELEASE_OUTSIDE:String = 'button_release_outside';

		/** @todo Comment */
		public static const HOVER_IN_TWEEN:String = 'button_hover_in_tween';

		/** @todo Comment */
		public static const HOVER_OUT_TWEEN:String = 'button_hover_out_tween';

		/** @todo Comment */
		public static const FOCUS_IN_TWEEN:String = 'button_focus_in_tween';

		/** @todo Comment */
		public static const DRAG_CONFIRMED_TWEEN:String = 'button_drag_confirmed_tween';

		/** @todo Comment */
		public static const RELEASED_INSIDE_TWEEN:String = 'button_released_inside_tween';

		/** @todo Comment */
		public static const RELEASED_OUTSIDE_TWEEN:String = 'button_released_outside_tween';



		/** @todo Comment */
		public function ButtonEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}



		/** @todo Comment */
		public override function clone():Event {
			return new ButtonEvent(type, bubbles, cancelable);
		}



		/** @todo Comment */
		public override function toString():String {
			return formatToString('ButtonEvent', 'type', 'bubbles', 'cancelable');
		}
	}
}
