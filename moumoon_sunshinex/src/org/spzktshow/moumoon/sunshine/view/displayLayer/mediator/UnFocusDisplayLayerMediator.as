package org.spzktshow.moumoon.sunshine.view.displayLayer.mediator
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.core.component.utils.ComponentControlUtils;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommand;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommandData;
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	import org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.factory.ComponentDisplayFactory;
	import org.spzktshow.moumoon.sunshine.view.displayLayer.ui.UnFocusDisplayLayer;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	
	public class UnFocusDisplayLayerMediator extends Mediator
	{
		public static const NAME:String = "unFocusDisplayLayerMediatorName";
		
		protected var _componentListCommandData:ComponentListCommandData;
		
		public function UnFocusDisplayLayerMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array
		{
			return [ComponentListCommand.REFRESHED]
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (notification.getName() == ComponentListCommand.REFRESHED)
			{
				unFocusDisplayLayer.removeChildren();
				var sComponentListCommandData:ComponentListCommandData = notification.getBody() as ComponentListCommandData;
				_componentListCommandData = sComponentListCommandData;
				
				roundUnFocusComponent(_componentListCommandData.component as IListComponent, unFocusDisplayLayer);
			}
		}
		
		/**
		 *递归创建未焦点的组件 
		 * @param component
		 * 
		 */		
		protected function roundUnFocusComponent(component:IListComponent, parent:DisplayObjectContainer):void
		{
			if (component.isFocusBeContainer) return;
			var display:DisplayObject = ComponentDisplayFactory.createComponent(component);
			parent.addChild(display);
//			var oldPoint:Point = new Point(Number(IComponentPropertyValue(component.componentValueList.getItem(ComponentPropertyEnum.X)).propertyValue), Number(IComponentPropertyValue(component.componentValueList.getItem(ComponentPropertyEnum.Y)).propertyValue));
//			var point:Point = parent.globalToLocal(oldPoint);
//			display.x = point.x;
//			display.y = point.y;
//			if (component.children && component.children.length > 0)
//			{
//				for each(var tempComponent:IListComponent in component.children)
//				{
//					roundUnFocusComponent(tempComponent, display as DisplayObjectContainer);
//				}
//			}
			if (component.entity is DisplayObjectContainer && DisplayObjectContainer(component.entity).numChildren > 0)
			{
				var n:int = DisplayObjectContainer(component.entity).numChildren;
				for (var i:int = 0; i < n; i ++)
				{
					var displayObject:DisplayObject = DisplayObjectContainer(component.entity).getChildAt(i);
					var tempcomponent:IListComponent = ComponentControlUtils.getComponentByName(_componentListCommandData.editorFile.componentGroup, displayObject.name) as IListComponent;
					roundUnFocusComponent(tempcomponent, display as DisplayObjectContainer);
				}
			}
		}
		
		public function get unFocusDisplayLayer():UnFocusDisplayLayer
		{
			return viewComponent as UnFocusDisplayLayer;
		}
	}
}