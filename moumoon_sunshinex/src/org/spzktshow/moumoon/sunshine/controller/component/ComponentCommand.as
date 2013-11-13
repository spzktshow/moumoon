package org.spzktshow.moumoon.sunshine.controller.component
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.spzktshow.moumoon.sunshine.model.component.ComponentModel;

	/**
	 *组件的命令 
	 * @author rocklee
	 * 
	 */	
	public class ComponentCommand extends SimpleCommand
	{
		/**
		 *初始化model 
		 */		
		public static const INIT:String = "componentCommandInit";
		/**
		 *初始化model完成 
		 */		
		public static const INITED:String = "componentCommandInited";
		/**
		 *获取 
		 */		
		public static const UPDATE:String = "componentCommandGet";
		/**
		 *获取信息 
		 */		
		public static const UPDATED:String = "componentCommandGot";
		/**
		 *添加item 
		 */		
		public static const ADD:String = "componentCommandAdd";
		/**
		 *添加item完成 
		 */		
		public static const ADDED:String = "componentCommandAdded";
		/**
		 *移除item 
		 */		
		public static const REMOVE:String = "componentCommandRemove";
		/**
		 *移除item完成 
		 */		
		public static const REMOVED:String = "componentCommandRemoved";
		
		public function ComponentCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			if (notification.getName() == INIT)
			{
				var componentModel:ComponentModel = new ComponentModel;
				facade.registerProxy(componentModel);
			}
			else if (notification.getName() == UPDATE)
			{
				componentModel = facade.retrieveProxy(ComponentModel.NAME) as ComponentModel;
				componentModel.getComponentInfo();
			}
		}
	}
}