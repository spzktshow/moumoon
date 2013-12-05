package org.spzktshow.moumoon.sunshine.view.displayList.mediator
{
	import feathers.controls.Label;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommand;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommandData;
	import org.spzktshow.moumoon.sunshine.core.assets.Assets;
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	import org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent;
	import org.spzktshow.moumoon.sunshine.core.proxy.touch.TouchProxy;
	
	import starling.display.Image;
	import starling.display.Sprite;

	/**
	 *显示列表item mediator 
	 * @author rocklee
	 * 
	 */	
	public class DisplayListItemMediator extends Mediator
	{	
		private var _component:IListComponent;
		
		private var _label:Label;//组件名称
		private var _labelTouchProxy:TouchProxy;
		
		private var _eye:Image;//眼睛
		private var _eyeTouchProxy:TouchProxy;
		
		private var _isOpen:Image;//是否打开子集
		private var _isOpenTouchProxy:TouchProxy;//
		private var _noOpen:Image;
		private var _noOpenTouchProxy:TouchProxy;
		
		public function DisplayListItemMediator(component:IListComponent, viewComponent:Object=null)
		{
			_component = component;
			super(_component.name, viewComponent);
		}
		
		override public function onRemove():void
		{
			_labelTouchProxy.dispose();
			_eyeTouchProxy.dispose();
			_isOpenTouchProxy.dispose();
			_noOpenTouchProxy.dispose();
			
			_label.removeEventListener(MouseEvent.MOUSE_CLICK, onMouseClickHandler);
			_label = null;
			_eye.removeEventListener(MouseEvent.MOUSE_CLICK, onMouseClickEyeHandler);
			_eye = null;
			_isOpen.removeEventListener(MouseEvent.MOUSE_CLICK, onMouseClickEyeHandler);
			_isOpen = null;
			_noOpen.removeEventListener(MouseEvent.MOUSE_CLICK, onMouseClickEyeHandler);
			_noOpen = null;
		}
		
		override public function onRegister():void
		{
			DisplayItemFactory.renderTitle(_component, displayListItem);
			_label = displayListItem.getChildByName(DisplayItemFactory.LABEL) as Label;
			_label.addEventListener(MouseEvent.MOUSE_CLICK, onMouseClickHandler);
			
			//eye visible
			_eye = displayListItem.getChildByName(Assets.EYE) as Image;
			_eye.addEventListener(MouseEvent.MOUSE_CLICK, onMouseClickEyeHandler);
			_eye.useHandCursor = true;
			
			_isOpen = displayListItem.getChildByName(Assets.IS_OPEN) as Image;
			_isOpen.addEventListener(MouseEvent.MOUSE_CLICK, onMouseClickIsOpenHandler);
			_isOpen.useHandCursor = true;
			
			_noOpen = displayListItem.getChildByName(Assets.NO_OPEN) as Image;
			_noOpen.addEventListener(MouseEvent.MOUSE_CLICK, onMouseClickIsOpenHandler);
			_noOpen.useHandCursor = true;
			
			_labelTouchProxy = new TouchProxy(_label);
			_eyeTouchProxy = new TouchProxy(_eye);
			_isOpenTouchProxy = new TouchProxy(_isOpen);
			_noOpenTouchProxy = new TouchProxy(_noOpen);
		}
		
		override public function listNotificationInterests():Array
		{
			return [ComponentListCommand.DISPLAY_LAYER_OPERATION_REFRESHED];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (notification.getName() == ComponentListCommand.DISPLAY_LAYER_OPERATION_REFRESHED && notification.getType() == ComponentListCommand.TYPE_DISPLAY_LAYER_OPERATION_VISIBLE)
			{
				var sComponentListCommandData:ComponentListCommandData = notification.getBody() as ComponentListCommandData;
				if (ComponentListCommand.TYPE_DISPLAY_LAYER_OPERATION_VISIBLE == notification.getType())
				{
					if (displayListItem.name == sComponentListCommandData.component.name)
					{
						DisplayItemFactory.renderIsView(_component, displayListItem);
					}
				}
				else if (ComponentListCommand.TYPE_DISPLAY_LAYER_OEPRATION_ISOPEN == notification.getType())
				{
					if (displayListItem.name == sComponentListCommandData.component.name)
					{
						DisplayItemFactory.renderIsOpen(_component, displayListItem);
					}
				}
			}
		}
		
		protected function onMouseClickHandler(e:MouseEvent):void
		{
			var componentListCommandData:ComponentListCommandData = new ComponentListCommandData;
			componentListCommandData.componentName = _component.name;
			this.sendNotification(ComponentListCommand.DISPLAY_LAYER_OPERATION, componentListCommandData, ComponentListCommand.TYPE_DISPLAY_LAYER_OPERATION_FOCUS);
		}
		
		protected function onMouseClickEyeHandler(e:MouseEvent):void
		{
			var sCommandListData:ComponentListCommandData = new ComponentListCommandData;
			sCommandListData.componentName = _component.name;
			sendNotification(ComponentListCommand.DISPLAY_LAYER_OPERATION, sCommandListData, ComponentListCommand.TYPE_DISPLAY_LAYER_OPERATION_VISIBLE);
		}
		
		protected function onMouseClickIsOpenHandler(e:MouseEvent):void
		{
			var sCommandListData:ComponentListCommandData = new ComponentListCommandData;
			sCommandListData.componentName = _component.name;
			sendNotification(ComponentListCommand.DISPLAY_LAYER_OPERATION, sCommandListData, ComponentListCommand.TYPE_DISPLAY_LAYER_OEPRATION_ISOPEN);
		}
		/**
		 *显示列表item 
		 * @return 
		 * 
		 */		
		public function get displayListItem():Sprite
		{
			return this.viewComponent as Sprite;
		}
	}
}