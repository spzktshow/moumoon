package org.spzktshow.moumoon.sunshine.view.floatLayer.mediator
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.core.componentTemplate.configData.ComponentPropertyEnum;
	import org.spzktshow.moumoon.core.componentTemplate.enum.ComponentTemplateEnum;
	import org.spzktshow.moumoon.core.componentValue.ComponentPropertyValue;
	import org.spzktshow.moumoon.core.componentValue.ComponentValueList;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommand;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommandData;
	import org.spzktshow.moumoon.sunshine.controller.floatlayer.FloatLayerCommand;
	import org.spzktshow.moumoon.sunshine.controller.floatlayer.FloatLayerCommandData;
	import org.spzktshow.moumoon.sunshine.core.assets.Assets;
	import org.spzktshow.moumoon.sunshine.view.floatLayer.ui.FloatLayer;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class FloatlayerMediator extends Mediator
	{
		public static const NAME:String = "floatLayerMediatorName";
		/**
		 *当前操作得image 
		 */		
		private var _currentImage:Image;
		private var _currentSourceName:String;
		
		public function FloatlayerMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array
		{
			return [FloatLayerCommand.FLOATED_SOURCE, FloatLayerCommand.FLOATED_COMPONENT];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (notification.getName() == FloatLayerCommand.FLOATED_SOURCE)
			{
				floatLayer.removeChildren();
				var handlerData:FloatLayerCommandData = notification.getBody() as FloatLayerCommandData;
				_currentSourceName = handlerData.sourceName;
				_currentImage = new Image(handlerData.source.data);
				floatLayer.addChild(_currentImage);
				_currentImage.x = handlerData.point.x;
				_currentImage.y = handlerData.point.y;
				
				Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
				Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpFloatSourceHandler);
			}
			else if (notification.getName() == FloatLayerCommand.FLOATED_COMPONENT)
			{
				floatLayer.removeChildren();
				handlerData = notification.getBody() as FloatLayerCommandData;
				var texture:Texture = Assets.getInstance().iconSource.getTexture(Assets.EYE);
				_currentImage = new Image(texture);
				floatLayer.addChild(_currentImage);
				_currentImage.x = handlerData.point.x;
				_currentImage.y = handlerData.point.y;
				Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler)
				Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpFloatComponentHandler)
			}
		}
		
		private function onMouseMoveHandler(e:MouseEvent):void
		{
			_currentImage.x = e.stageX;
			_currentImage.y = e.stageY;
		}
		
		private function onMouseUpFloatSourceHandler(e:MouseEvent):void
		{
			floatLayer.removeChildren();
			Starling.current.nativeStage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			Starling.current.nativeStage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpFloatSourceHandler);
			
			var sComponentListCommandData:ComponentListCommandData = new ComponentListCommandData;
			sComponentListCommandData.sourceName = _currentSourceName;
			sComponentListCommandData.componentTemplateType = ComponentTemplateEnum.IMAGE;
			var point:Point = new Point(e.stageX, e.stageY);
			sComponentListCommandData.globalMousePoint = point;
			point = new Point(_currentImage.x, _currentImage.y);
			sComponentListCommandData.componentPoint = point;
			var componentValueList:ComponentValueList = new ComponentValueList;
			var compoentPropertyValue:ComponentPropertyValue = new ComponentPropertyValue;
			compoentPropertyValue.name = ComponentPropertyEnum.X;
//			compoentPropertyValue.propertyValue = e.stageX;
			componentValueList.addItem(compoentPropertyValue);
			compoentPropertyValue = new ComponentPropertyValue;
			compoentPropertyValue.name = ComponentPropertyEnum.Y;
//			compoentPropertyValue.propertyValue = e.stageY;
			componentValueList.addItem(compoentPropertyValue);
			compoentPropertyValue = new ComponentPropertyValue;
			compoentPropertyValue.name = ComponentPropertyEnum.TEXTURE;
//			compoentPropertyValue.propertyValue = _currentSourceName;
			componentValueList.addItem(compoentPropertyValue);
			sComponentListCommandData.componentPropertyValueList = componentValueList;
			this.sendNotification(ComponentListCommand.ADD_CHILD, sComponentListCommandData);
		}
		
		private function onMouseUpFloatComponentHandler(e:MouseEvent):void
		{
			floatLayer.removeChildren();
			Starling.current.nativeStage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			Starling.current.nativeStage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpFloatComponentHandler);
			
			var sComponentListCommandData:ComponentListCommandData = new ComponentListCommandData;
			sComponentListCommandData.componentTemplateType = ComponentTemplateEnum.CONTAINER;
			var point:Point = new Point(e.stageX, e.stageY);
			sComponentListCommandData.globalMousePoint = point;
			point = new Point(_currentImage.x, _currentImage.y);
			sComponentListCommandData.componentPoint = point;
			
			var componentValueList:ComponentValueList = new ComponentValueList;
			var compoentPropertyValue:ComponentPropertyValue = new ComponentPropertyValue;
			compoentPropertyValue.name = ComponentPropertyEnum.X;
//			compoentPropertyValue.propertyValue = e.stageX;
			componentValueList.addItem(compoentPropertyValue);
			compoentPropertyValue = new ComponentPropertyValue;
			compoentPropertyValue.name = ComponentPropertyEnum.Y;
//			compoentPropertyValue.propertyValue = e.stageY;
			componentValueList.addItem(compoentPropertyValue);
			sComponentListCommandData.componentPropertyValueList = componentValueList;
			this.sendNotification(ComponentListCommand.ADD_CHILD, sComponentListCommandData);
		}
		
		public function get floatLayer():FloatLayer
		{
			return viewComponent as FloatLayer;
		}
	}
}