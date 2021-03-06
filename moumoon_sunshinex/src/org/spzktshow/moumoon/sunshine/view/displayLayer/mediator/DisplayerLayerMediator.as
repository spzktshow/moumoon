package org.spzktshow.moumoon.sunshine.view.displayLayer.mediator
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.core.component.utils.ComponentControlUtils;
	import org.spzktshow.moumoon.core.componentTemplate.configData.ComponentPropertyEnum;
	import org.spzktshow.moumoon.core.componentValue.ComponentPropertyValue;
	import org.spzktshow.moumoon.core.componentValue.ComponentValueList;
	import org.spzktshow.moumoon.core.componentValue.IComponentPropertyValue;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommand;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommandData;
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	import org.spzktshow.moumoon.sunshine.core.component.utils.ListComponentUtils;
	import org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.factory.ComponentDisplayFactory;
	import org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.utils.ComponentValueListUtils;
	import org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent;
	import org.spzktshow.moumoon.sunshine.core.proxy.touch.TouchProxy;
	import org.spzktshow.moumoon.sunshine.view.displayLayer.ui.DisplayLayer;
	import org.spzktshow.moumoon.sunshine.view.displayList.mediator.DisplayItemFactory;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;

	/**
	 *显示层mediator 
	 * @author rocklee
	 * 
	 */	
	public class DisplayerLayerMediator extends Mediator
	{
		public static const NAME:String = "displayLayerMediatorName";
		
		protected var _componentListCommandData:ComponentListCommandData;
		
		private var _displayLayerTouchProxy:TouchProxy;
		/**
		 *当前的焦点容器 
		 */		
		private var _currentContainerFocus:DisplayObject;
		/**
		 *当前的焦点 
		 */		
		private var _currentFocus:DisplayObject;
		/**
		 *旧的点 
		 */		
		private var _oldPoint:Point;
		/**
		 *这个列表很重要,他以一维的形式保存了,显示列表上所有的显示对象,这样方便了更改某个显示对象时不必遍历整个显示列表 
		 */		
		private var _displayCacheList:Vector.<DisplayObject>;
		
		public function DisplayerLayerMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			_displayCacheList = new Vector.<DisplayObject>;
			_displayLayerTouchProxy = new TouchProxy(displayLayer);
			displayLayer.addEventListener(org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent.MOUSE_DOWN, onMouseDownHandler);
		}
		
		override public function onRemove():void
		{
			displayLayer.removeEventListener(org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			_displayLayerTouchProxy.dispose();
			_displayCacheList = null;
		}
		
		private function onMouseDownHandler(e:org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent):void
		{
			if (_currentFocus)
			{
				var point:Point = _currentFocus.globalToLocal(new Point(Starling.current.nativeStage.mouseX, Starling.current.nativeStage.mouseY));
				trace ("currentFocuse");
				if (_currentFocus.hitTest(point))//当与当前焦点重合
				{
					trace ("currentFocuseHitTestTrue");
					_oldPoint = new Point(Starling.current.nativeStage.mouseX, Starling.current.nativeStage.mouseY);
					Starling.current.nativeStage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
					Starling.current.nativeStage.addEventListener(flash.events.MouseEvent.MOUSE_UP, onMouseUpHandler);
				}
			}
			else
			{
				trace ("currentFocuseNo");
			}
		}
		
		private function onMouseMoveHandler(e:flash.events.MouseEvent):void
		{
			_currentFocus.x += e.stageX - _oldPoint.x;
			_currentFocus.y += e.stageY - _oldPoint.y;
			
			_oldPoint.x = e.stageX;
			_oldPoint.y = e.stageY;
		}
		
		private function onMouseUpHandler(e:flash.events.MouseEvent):void
		{
			Starling.current.nativeStage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			Starling.current.nativeStage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, onMouseUpHandler);
			var transPoint:Point = new Point(0, 0);
			transPoint = _currentFocus.localToGlobal(transPoint, transPoint);
			transPoint = _componentListCommandData.focus.entity.parent.globalToLocal(transPoint, transPoint);
			var sCommandListData:ComponentListCommandData = new ComponentListCommandData;
			var componentPropertyValueList:ComponentValueList = new ComponentValueList;
			var componentPropertyValue:ComponentPropertyValue = new ComponentPropertyValue;
			componentPropertyValue.name = ComponentPropertyEnum.X;
			componentPropertyValue.propertyValue = transPoint.x;// + _componentListCommandData.focus.entity.x;
			componentPropertyValueList.addItem(componentPropertyValue);
			componentPropertyValue = new ComponentPropertyValue;
			componentPropertyValue.name = ComponentPropertyEnum.Y;
			componentPropertyValue.propertyValue = transPoint.y;// + _componentListCommandData.focus.entity.y;
			componentPropertyValueList.addItem(componentPropertyValue);
			sCommandListData.componentPropertyValueList = componentPropertyValueList;
			sendNotification(ComponentListCommand.FOCUS_OEPRATION, sCommandListData, ComponentListCommand.TYPE_MOVE);
		}
		
		override public function listNotificationInterests():Array
		{
			return [ComponentListCommand.REFRESHED, ComponentListCommand.COMPONENT_OPERATION_REFRESHED, ComponentListCommand.DISPLAY_LAYER_OPERATION_REFRESHED];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (notification.getName() == ComponentListCommand.REFRESHED)
			{
				displayLayer.removeChildren();
				_displayCacheList.splice(0, _displayCacheList.length);
				
				_currentContainerFocus = null;
				_currentFocus = null;
				
				var sComponentListCommandData:ComponentListCommandData = notification.getBody() as ComponentListCommandData;
				_componentListCommandData = sComponentListCommandData;
				
				roundFocusComponent(_componentListCommandData.containerFocus, displayLayer);
			}
			else if (notification.getName() == ComponentListCommand.COMPONENT_OPERATION_REFRESHED)
			{
				sComponentListCommandData = notification.getBody() as ComponentListCommandData;
				var displayObject:DisplayObject = this.getDisplayObjectFromCache(sComponentListCommandData.component.name);
				if (displayObject)
				{
					ComponentDisplayFactory.filterComponent(sComponentListCommandData.component, displayObject);
					if (notification.getType() == ComponentListCommand.TYPE_MOVE)
					{
						if (sComponentListCommandData.component.isFocusBeContainer)
						{
							fileFocusBeContainerPoint(sComponentListCommandData.component);
						}
					}
				}
				else
				{
					throw new Error("operation component = null");
				}
			}
			else if (notification.getName() == ComponentListCommand.DISPLAY_LAYER_OPERATION_REFRESHED && notification.getType() == ComponentListCommand.TYPE_DISPLAY_LAYER_OPERATION_VISIBLE)
			{
				sComponentListCommandData = notification.getBody() as ComponentListCommandData;
				displayObject = this.getDisplayObjectFromCache(sComponentListCommandData.component.name);
				if (displayObject) ComponentDisplayFactory.filterListComponent(sComponentListCommandData.component, displayObject);
			}
		}
		
		/**
		 *递归创建焦点的组件 
		 * @param component
		 * 
		 */		
		protected function roundFocusComponent(component:IListComponent, parent:DisplayObjectContainer):void
		{
			//
			var display:DisplayObject = ComponentDisplayFactory.createComponent(component);
			parent.addChild(display);
			_displayCacheList.push(display);
			ComponentDisplayFactory.filterListComponent(component, display);
			if (component.isFocusBeContainer)
			{
				_currentContainerFocus = display;
				fileFocusBeContainerPoint(component);
			}
			if (component.isFocus)
			{
				_currentFocus = display;
			}
			var containers:int = ListComponentUtils.checkIsContainer(component);
			if (containers > 0)
			{
				var n:int = DisplayObjectContainer(component.entity).numChildren;
				for (var i:int = 0; i < n; i ++)
				{
					var displayObject:DisplayObject = DisplayObjectContainer(component.entity).getChildAt(i);
					var tempComponent:IListComponent = ComponentControlUtils.getComponentByName(_componentListCommandData.editorFile.componentGroup, displayObject.name) as IListComponent;
					roundFocusComponent(tempComponent, display as DisplayObjectContainer);
					if (tempComponent.isFocus)
					{
						break;
					}
				}
			}
			if (containers >= 0)
			{
				var focusView:Image = new Image(DisplayItemFactory.EYE);
				DisplayObjectContainer(display).addChild(focusView);
			}
		}
		
		protected function fileFocusBeContainerPoint(component:IListComponent):void
		{
			var point:Point = new Point(0, 0);
			component.entity.localToGlobal(point, point);
			_currentContainerFocus.x = point.x;
			_currentContainerFocus.y = point.y;
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
		
		public function get displayLayer():DisplayLayer
		{
			return viewComponent as DisplayLayer;
		}
	}
}