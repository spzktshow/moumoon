package org.spzktshow.moumoon.sunshine.view.displayLayer.mediator
{
	import flash.geom.Point;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.core.component.utils.ComponentControlUtils;
	import org.spzktshow.moumoon.core.componentTemplate.configData.ComponentPropertyEnum;
	import org.spzktshow.moumoon.core.componentValue.IComponentPropertyValue;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommand;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommandData;
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	import org.spzktshow.moumoon.sunshine.core.component.utils.ListComponentUtils;
	import org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.factory.ComponentDisplayFactory;
	import org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.utils.ComponentValueListUtils;
	import org.spzktshow.moumoon.sunshine.view.displayLayer.ui.UnFocusDisplayLayer;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	
	public class UnFocusDisplayLayerMediator extends Mediator
	{
		public static const NAME:String = "unFocusDisplayLayerMediatorName";
		
		protected var _componentListCommandData:ComponentListCommandData;
		
		/**
		 *这个列表很重要,他以一维的形式保存了,显示列表上所有的显示对象,这样方便了更改某个显示对象时不必遍历整个显示列表 
		 */		
		private var _displayCacheList:Vector.<DisplayObject>;
		
		public function UnFocusDisplayLayerMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			_displayCacheList = new Vector.<DisplayObject>;
		}
		
		override public function onRemove():void
		{
			_displayCacheList = null;
		}
		
		override public function listNotificationInterests():Array
		{
			return [ComponentListCommand.REFRESHED, ComponentListCommand.DISPLAY_LAYER_OPERATION_REFRESHED]
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (notification.getName() == ComponentListCommand.REFRESHED)
			{
				unFocusDisplayLayer.removeChildren();
				var sComponentListCommandData:ComponentListCommandData = notification.getBody() as ComponentListCommandData;
				_componentListCommandData = sComponentListCommandData;
				
				roundUnFocusComponent(_componentListCommandData.editorFile.component as IListComponent, unFocusDisplayLayer);
			}
			else if (notification.getName() == ComponentListCommand.DISPLAY_LAYER_OPERATION_REFRESHED && notification.getType() == ComponentListCommand.TYPE_DISPLAY_LAYER_OPERATION_VISIBLE)
			{
				sComponentListCommandData = notification.getBody() as ComponentListCommandData;
				var displayObject:DisplayObject = this.getDisplayObjectFromCache(sComponentListCommandData.component.name);
				if (displayObject)
				{
					if (notification.getType() == ComponentListCommand.TYPE_MOVE)
					{
						if (sComponentListCommandData.component.isFocusBeContainer)
						{
							//特殊处理如果是移动,如果component为containerFocus
							var xValue:IComponentPropertyValue = ComponentValueListUtils.getComponentPropertyValue(sComponentListCommandData.component.componentValueList, ComponentPropertyEnum.X);
							var yValue:IComponentPropertyValue = ComponentValueListUtils.getComponentPropertyValue(sComponentListCommandData.component.componentValueList, ComponentPropertyEnum.Y);
							var point:Point = new Point(Number(xValue.propertyValue), Number(yValue.propertyValue));
							point = sComponentListCommandData.component.entity.parent.localToGlobal(point);
							xValue.propertyValue = Number(point.x);
							yValue.propertyValue = Number(point.y);
						}
					}
					ComponentDisplayFactory.filterListComponent(sComponentListCommandData.component, displayObject);
				}
			}
		}
		
		/**
		 *递归创建未焦点的组件 
		 * @param component
		 * 
		 */		
		protected function roundUnFocusComponent(component:IListComponent, parent:DisplayObjectContainer):void
		{
			var display:DisplayObject = ComponentDisplayFactory.createComponent(component);
			parent.addChild(display);
			_displayCacheList.push(display);
			ComponentDisplayFactory.filterListComponent(component, display);
			if (ListComponentUtils.checkIsContainer(component) > 0)
			{
				var n:int = DisplayObjectContainer(component.entity).numChildren;
				for (var i:int = 0; i < n; i ++)
				{
					var displayObject:DisplayObject = DisplayObjectContainer(component.entity).getChildAt(i);
					var tempcomponent:IListComponent = ComponentControlUtils.getComponentByName(_componentListCommandData.editorFile.componentGroup, displayObject.name) as IListComponent;
					if (tempcomponent.isFocus) continue;
					roundUnFocusComponent(tempcomponent, display as DisplayObjectContainer);
				}
			}
		}
		
		/**
		 * 
		 * @param name
		 * @return 
		 * 
		 */		
		protected function getDisplayObjectFromCache(name:String):DisplayObject
		{
			for each(var displayObject:DisplayObject in _displayCacheList)
			{
				if (displayObject.name == name)
				{
					return displayObject;
				}
			}
			return null;
		}
		
		public function get unFocusDisplayLayer():UnFocusDisplayLayer
		{
			return viewComponent as UnFocusDisplayLayer;
		}
	}
}