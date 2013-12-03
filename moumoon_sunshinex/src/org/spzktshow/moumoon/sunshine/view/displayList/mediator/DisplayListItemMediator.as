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
		
		public function DisplayListItemMediator(component:IListComponent, viewComponent:Object=null)
		{
			_component = component;
			super(_component.name, viewComponent);
		}
		
		override public function onRemove():void
		{
			_labelTouchProxy.dispose();
			_eyeTouchProxy.dispose();
			
			_label.removeEventListener(MouseEvent.MOUSE_CLICK, onMouseClickHandler);
			_label = null;
			_eye.removeEventListener(MouseEvent.MOUSE_CLICK, onMouseClickEyeHandler);
			_eye = null;
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
			
			_labelTouchProxy = new TouchProxy(_label);
			_eyeTouchProxy = new TouchProxy(_eye);
		}
		
		override public function listNotificationInterests():Array
		{
			return [ComponentListCommand.DISPLAY_LAYER_OPERATION_REFRESHED];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (notification.getName() == ComponentListCommand.DISPLAY_LAYER_OPERATION_REFRESHED && notification.getType() == ComponentListCommand.DISPLAY_LAYER_OEPRATION_TYPE_ISOPEN)
			{
				var sComponentListCommandData:ComponentListCommandData = notification.getBody() as ComponentListCommandData;
				if (displayListItem.name == sComponentListCommandData.component.name)
				{
					DisplayItemFactory.renderTitle(_component, displayListItem);
				}
			}
		}
		
		protected function onMouseClickHandler(e:MouseEvent):void
		{
			var componentListCommandData:ComponentListCommandData = new ComponentListCommandData;
			componentListCommandData.componentName = _component.name;
			this.sendNotification(ComponentListCommand.DISPLAY_LAYER_OPERATION, componentListCommandData, ComponentListCommand.DISPLAY_LAYER_OPERATION_TYPE_FOCUS);
		}
		
		protected function onMouseClickEyeHandler(e:MouseEvent):void
		{
			var sCommandListData:ComponentListCommandData = new ComponentListCommandData;
			sCommandListData.componentName = _component.name;
			sendNotification(ComponentListCommand.DISPLAY_LAYER_OPERATION, sCommandListData, ComponentListCommand.DISPLAY_LAYER_OPERATION_TYPE_VISIBLE);
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