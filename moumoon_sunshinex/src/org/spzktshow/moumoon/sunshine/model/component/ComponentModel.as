package org.spzktshow.moumoon.sunshine.model.component
{
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.spzktshow.moumoon.core.componentTemplate.IComponentTemplate;
	import org.spzktshow.moumoon.core.group.IGroup;
	import org.spzktshow.moumoon.core.group.IGroupItem;
	import org.spzktshow.moumoon.sunshine.controller.component.ComponentCommand;
	import org.spzktshow.moumoon.sunshine.controller.component.ComponentCommandData;
	import org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.ComponentTemplateConfig;
	
	public class ComponentModel extends Proxy implements IGroup
	{
		public static const NAME:String = "componentModelName";
		
		private var _group:ComponentTemplateConfig;
		public function ComponentModel()
		{
			super(NAME);
		}
		
		override public function onRegister():void
		{
			_group = ComponentTemplateConfig.getInstance();
			this.sendNotification(ComponentCommand.INITED);
		}
		/**
		 *获取组件数据 
		 * 
		 */		
		public function getComponentInfo():void
		{
			var data:ComponentCommandData = new ComponentCommandData;
			data.componentTemplates = _group.componentTemplates;
			this.sendNotification(ComponentCommand.UPDATED, data);
		}
		
		public function addItem(value:IGroupItem):int
		{
			var index:int = _group.addItem(value);
			var data:ComponentCommandData = new ComponentCommandData;
			data.componentTemplate = value as IComponentTemplate;
			this.sendNotification(ComponentCommand.ADDED, data);
			return index;
		}
		
		public function checkItem(name:String):int
		{
			return _group.checkItem(name);
		}
		
		public function getItem(name:String):IGroupItem
		{
			return _group.getItem(name);
		}
		
		public function removeItem(name:String):IGroupItem
		{
			var groupItem:IGroupItem = _group.removeItem(name);
			var data:ComponentCommandData = new ComponentCommandData;
			data.componentTemplate = groupItem as IComponentTemplate;
			this.sendNotification(ComponentCommand.REMOVED, data);
			return groupItem;
		}		
		
		public function get total():Vector.<IGroupItem>
		{
			return _group.total;
		}
			
		
	}
}