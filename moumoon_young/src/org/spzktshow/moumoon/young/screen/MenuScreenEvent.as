package org.spzktshow.moumoon.young.screen
{
	import org.spzktshow.moumoon.young.menu.IMenuListContext;
	
	import starling.events.Event;
	
	public class MenuScreenEvent extends Event
	{
		/**
		 *选择了list中的item，且item为末端，发送选择item事件 
		 */	
		public static const SELECT_ITEM:String = "menuScreenEventSelectItem";
		public var menuListContext:IMenuListContext;
		/**
		 *当变化list时发送的事件 
		 */		
		public static const TRANSTION_LIST:String = "menuScreenEventTransitionList";
		
		public function MenuScreenEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}