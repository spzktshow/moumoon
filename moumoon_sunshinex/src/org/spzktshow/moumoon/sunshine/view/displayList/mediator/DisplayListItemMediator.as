package org.spzktshow.moumoon.sunshine.view.displayList.mediator
{
	import feathers.controls.Label;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommand;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommandData;
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	import org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent;
	import org.spzktshow.moumoon.sunshine.core.proxy.touch.TouchProxy;
	
	import starling.display.Sprite;

	/**
	 *显示列表item mediator 
	 * @author rocklee
	 * 
	 */	
	public class DisplayListItemMediator extends Mediator
	{	
		protected var _touchProxy:TouchProxy;
		
		private var _component:IListComponent;
		
		private var _label:Label;//组件名称
		
		public function DisplayListItemMediator(component:IListComponent, viewComponent:Object=null)
		{
			_component = component;
			super(_component.name, viewComponent);
		}
		
		override public function onRemove():void
		{
			_label.removeEventListener(MouseEvent.MOUSE_CLICK, onMouseClickHandler);
			_touchProxy.dispose();
		}
		
		override public function onRegister():void
		{
			_label = displayListItem.getChildByName(DisplayItemFactory.LABEL) as Label;
			_touchProxy = new TouchProxy(_label);
			_label.addEventListener(MouseEvent.MOUSE_CLICK, onMouseClickHandler);
		}
		
		protected function onMouseClickHandler(e:MouseEvent):void
		{
			var componentListCommandData:ComponentListCommandData = new ComponentListCommandData;
			componentListCommandData.componentName = _component.name;
			this.sendNotification(ComponentListCommand.FOCUS, componentListCommandData);
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