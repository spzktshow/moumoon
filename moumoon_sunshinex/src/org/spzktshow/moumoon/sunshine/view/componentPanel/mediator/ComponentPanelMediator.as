package org.spzktshow.moumoon.sunshine.view.componentPanel.mediator
{
	import flash.geom.Point;
	
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.Scroller;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.core.componentTemplate.IComponentTemplate;
	import org.spzktshow.moumoon.sunshine.controller.component.ComponentCommand;
	import org.spzktshow.moumoon.sunshine.controller.component.ComponentCommandData;
	import org.spzktshow.moumoon.sunshine.controller.floatlayer.FloatLayerCommand;
	import org.spzktshow.moumoon.sunshine.controller.floatlayer.FloatLayerCommandData;
	import org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent;
	import org.spzktshow.moumoon.sunshine.core.proxy.touch.TouchProxy;
	
	import starling.core.Starling;
	
	public class ComponentPanelMediator extends Mediator
	{
		public static const NAME:String = "componentPanelMediatorName";
		/**
		 *组件label显示的行距 
		 */		
		private static const COMPONENT_LABEL_ROW_GAP:int = 25;
		
		private var _touchList:Vector.<TouchProxy>;
		
		public function ComponentPanelMediator(viewComponent:Object=null)
		{
			_touchList = new Vector.<TouchProxy>;
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			componentPanel.interactionMode = Scroller.INTERACTION_MODE_MOUSE;
			componentPanel.scrollBarDisplayMode = Scroller.SCROLL_BAR_DISPLAY_MODE_FIXED;
			super.onRegister();
			this.sendNotification(ComponentCommand.UPDATE);
		}
		
		override public function onRemove():void
		{
			for each(var touchProxy:TouchProxy in _touchList)
			{
				touchProxy.dispose();
			}
		}
		
		override public function listNotificationInterests():Array
		{
			return [ComponentCommand.UPDATED, ComponentCommand.ADDED, ComponentCommand.REMOVED];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (notification.getName() == ComponentCommand.UPDATED)
			{
				componentPanel.removeChildren();
				var componentCommandData:ComponentCommandData = notification.getBody() as ComponentCommandData;
				var index:int = 0;
				for each(var componentTemplate:IComponentTemplate in componentCommandData.componentTemplates)
				{
					var label:Label = new Label();
					label.text = componentTemplate.name;
					label.name = componentTemplate.name;
					componentPanel.addChild(label);
					label.y = index * COMPONENT_LABEL_ROW_GAP;
					var touchProxy:TouchProxy = new TouchProxy(label);
					_touchList.push(touchProxy);
					label.addEventListener(org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent.MOUSE_DOWN, onMouseDownHandler);
					index ++;
				}
			}
			else if (notification.getName() == ComponentCommand.ADDED)
			{
				componentTemplate = notification.getBody() as IComponentTemplate;
				label = new Label;
				label.text = componentTemplate.name;
				label.name = componentTemplate.name;
				componentPanel.addChild(label);
				label.y = (componentPanel.numChildren - 1) * COMPONENT_LABEL_ROW_GAP;
			}
			else if (notification.getName() == ComponentCommand.REMOVED)
			{
				componentTemplate = notification.getBody() as IComponentTemplate;
				var n:int = componentPanel.numChildren;
				var bool:Boolean = false;
				for (var i:int = 0; i < n; i ++)
				{
					label = componentPanel.getChildAt(i) as Label;
					if (bool)
					{
						label.y -= COMPONENT_LABEL_ROW_GAP;
						continue;
					}
					if (label.name == componentTemplate.name)
					{
						componentPanel.removeChild(label);
						bool = true;
					}
				}
			}
		}
		
		private function onMouseOverHandler(e:org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent):void
		{
			
		}
		
		private function onMouseDownHandler(e:org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent):void
		{
			//trace ("mouseDown");
			var data:FloatLayerCommandData = new FloatLayerCommandData;
			data.point = new Point(Starling.current.nativeStage.mouseX, Starling.current.nativeStage.mouseY);
			data.componentName = Label(e.currentTarget).name;
			sendNotification(FloatLayerCommand.FLOAT_COMPONENT, data);
		}
		
		public function get componentPanel():Panel
		{
			return this.viewComponent as Panel;
		}
	}
}