package org.spzktshow.moumoon.sunshine.core.proxy.touch
{
	import starling.events.Event;
	
	public class MouseEvent extends Event
	{
		/**
		 *鼠标over 
		 */		
		public static const MOUSE_OVER:String = "mouseEventMouseOver";
		/**
		 *鼠标out 
		 */		
		public static const MOUSE_OUT:String = "mouseEventMouseOut";
		/**
		 *鼠标按下 
		 */		
		public static const MOUSE_DOWN:String = "mouseEventMouseDown";
		/**
		 *鼠标放开 
		 */		
		public static const MOUSE_UP:String = "mouseEventMouseUp";
		/**
		 *鼠标点击 
		 */		
		public static const MOUSE_CLICK:String = "mouseEventMouseClick";
		/**
		 *鼠标over不冒泡 
		 */		
		public static const ROLL_OVER:String = "mouseEventRollOver";
		/**
		 *鼠标out不冒泡 
		 */		
		public static const ROLL_OUT:String = "mouseEventRollOut";
		/**
		 *鼠标移动 
		 */		
		public static const MOUSE_MOVE:String = "mouseEventMouseMove";
		
		public function MouseEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}