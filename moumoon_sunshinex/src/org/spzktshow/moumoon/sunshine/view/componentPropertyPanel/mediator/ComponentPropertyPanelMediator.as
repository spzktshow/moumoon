package org.spzktshow.moumoon.sunshine.view.componentPropertyPanel.mediator
{
	import feathers.controls.Panel;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.core.componentValue.IComponentPropertyValue;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommand;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommandData;
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	import org.spzktshow.moumoon.sunshine.core.componentInput.ComponentInputFactory;
	import org.spzktshow.moumoon.sunshine.core.componentInput.proxy.IComponentInputProxy;
	import org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.IEditorComponentProperty;

	/**
	 *组件属性面板 
	 * @author rocklee
	 * 
	 */	
	public class ComponentPropertyPanelMediator extends Mediator
	{
		public static const NAME:String = "componentPropertyPanelMediatorName";
		
		protected var _componentInputList:Vector.<IComponentInputProxy>;
		
		public function ComponentPropertyPanelMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			_componentInputList = new Vector.<IComponentInputProxy>;
		}
		
		override public function onRemove():void
		{
			for each(var componentInputProxy:IComponentInputProxy in _componentInputList)
			{
				componentPropertyPanel.removeChild(componentInputProxy.componentInput);
			}
			_componentInputList = null;
		}
		
		override public function listNotificationInterests():Array
		{
			return [ComponentListCommand.DISPLAY_LAYER_OPERATION_REFRESHED, ComponentListCommand.FOCUS_OPREATION_REFRESHED];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (notification.getName() == ComponentListCommand.DISPLAY_LAYER_OPERATION_REFRESHED && notification.getType() == ComponentListCommand.TYPE_DISPLAY_LAYER_OPERATION_FOCUS)
			{
				var componentListCommandData:ComponentListCommandData = notification.getBody() as ComponentListCommandData;
				if (componentListCommandData)
				{
					for each(var componentInputProxy:IComponentInputProxy in _componentInputList)
					{
						componentPropertyPanel.removeChild(componentInputProxy.componentInput);
					}
					_componentInputList.splice(0, _componentInputList.length);
					var component:IListComponent = componentListCommandData.focus as IListComponent;
					var index:int = 0;
					for each(var componentProperty:IEditorComponentProperty in component.componentTemplate.componentPropertys)
					{
						var componentPropertyValue:IComponentPropertyValue = component.componentValueList.getItem(componentProperty.name) as IComponentPropertyValue;
						var input:IComponentInputProxy = ComponentInputFactory.create(componentProperty, componentPropertyValue);
						if (!input) continue;
						componentPropertyPanel.addChild(input.componentInput);
						input.componentInput.y = index * 30;
						_componentInputList.push(input);
						index ++;
					}
				}
			}
			else if (notification.getName() == ComponentListCommand.FOCUS_OPREATION_REFRESHED)
			{
				componentListCommandData = notification.getBody() as ComponentListCommandData;
				if (componentListCommandData)
				{
					for each(componentPropertyValue in componentListCommandData.componentPropertyValueList.total)
					{
						for each(input in _componentInputList)
						{
							if (input.componentProperty.name == componentPropertyValue.name)
							{
								input.componentPropertyValue = componentPropertyValue;
								break;
							}
						}
					}
				}
			}
		}
		
		public function get componentPropertyPanel():Panel
		{
			return this.viewComponent as Panel;
		}
	}
}