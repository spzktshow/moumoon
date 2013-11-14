package org.spzktshow.moumoon.sunshine.view.displayList.mediator
{	
	import feathers.controls.Panel;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.core.component.IComponent;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommand;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommandData;
	import org.spzktshow.moumoon.sunshine.controller.file.FileCommand;
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	import org.spzktshow.moumoon.sunshine.core.file.IEditorFile;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	
	public class DisplayListMediator extends Mediator
	{
		private static const X_GAP:int = 50;
		
		public static const NAME:String = "displayListMediatorName";
		
		private var _yIndex:int = 0;
		
		private var _displayListItemMediators:Vector.<DisplayListItemMediator>;
		
		public function DisplayListMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			_displayListItemMediators = new Vector.<DisplayListItemMediator>;
		}
		
		override public function onRemove():void
		{
			_displayListItemMediators = null;
		}
		
		override public function listNotificationInterests():Array
		{
			return [FileCommand.FOCUSED_FILE, ComponentListCommand.REFRESHED];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (notification.getName() == FileCommand.FOCUSED_FILE)
			{
//				this.panel.visible = true;
				
//				var component:ListComponent = new ListComponent;
//				component.name = "1";
//				
//				var next:ListComponent = new ListComponent;
//				next.name = "2";
//				component.children.push(next);
//				next.parent = component;
//				
//				next = new ListComponent;
//				next.name = "3";
//				component.children.push(next);
//				next.parent = component;
//				
//				var next1:ListComponent = new ListComponent;
//				next1.name = "10";
//				next.children.push(next1);
//				next1.parent = next;
//
//				next = new ListComponent;
//				next.name = "4";
//				component.children.push(next);
//				next.parent = component;
//				
//				var panelData:EditorFile = new EditorFile();
//				panelData.component = component;
//				this.setPanelData(panelData);
			}
			else if (notification.getName() == ComponentListCommand.REFRESHED)
			{
				var sComponentListCommandData:ComponentListCommandData = notification.getBody() as ComponentListCommandData;
				setPanelData(sComponentListCommandData.component as IListComponent, sComponentListCommandData.editorFile);
			}
		}
		
		protected var _listComponent:IListComponent;
		protected var _editorFile:IEditorFile;
		protected function setPanelData(value:IListComponent, editorFile:IEditorFile):void
		{
			_listComponent = value;
			_editorFile = editorFile;
			
			destoryPanel();
			refreshPanel();
		}
		/**
		 *将panel还原成出厂状态 
		 * 
		 */		
		protected function destoryPanel():void
		{
			_yIndex = 0;
			panel.removeChildren();
			for each(var itemMediator:DisplayListItemMediator in _displayListItemMediators)
			{
				facade.removeMediator(itemMediator.getMediatorName());
			}
			_displayListItemMediators.splice(0, _displayListItemMediators.length);
		}
		
		protected function refreshPanel():void
		{
			if (_listComponent)
			{
				var xIndex:int = calculateComponentLayerCount(_listComponent, _listComponent);
				var view:Sprite = DisplayItemFactory.getTitle();
				DisplayItemFactory.renderTitle(_listComponent, view);
//				view.addEventListener(TouchEvent.TOUCH, onTouchNadler);
				view.x = xIndex * X_GAP;
				view.y = _yIndex * DisplayItemFactory.ROW_GAP;
				view.name = _listComponent.name;
				panel.addChild(view);
				var mediator:DisplayListItemMediator = new DisplayListItemMediator(_listComponent, view);
				facade.registerMediator(mediator);
				_displayListItemMediators.push(mediator);
				_yIndex ++;
				if (_listComponent.isOpen && _listComponent.entity is DisplayObjectContainer && DisplayObjectContainer(_listComponent.entity).numChildren > 0)
				{
					roundDownPanelData(_listComponent);
				}
			}
		}
		
		protected function roundDownPanelData(component:IListComponent):void
		{
			var n:int = DisplayObjectContainer(component.entity).numChildren;
			for (var i:int = 0; i < n; i ++)
			{
				var entity:DisplayObject = DisplayObjectContainer(component.entity).getChildAt(i);
				var currentComponent:IListComponent = _editorFile.componentGroup.getItem(entity.name) as IListComponent;
				var xIndex:int = calculateComponentLayerCount(_listComponent, currentComponent);
				var view:Sprite = DisplayItemFactory.getTitle();
				DisplayItemFactory.renderTitle(currentComponent, view);
//				view.addEventListener(TouchEvent.TOUCH, onTouchNadler);
				view.x = xIndex * X_GAP;
				view.y = _yIndex * DisplayItemFactory.ROW_GAP;
				view.name = currentComponent.name;
				panel.addChild(view);
				var mediator:DisplayListItemMediator = new DisplayListItemMediator(currentComponent, view);
				facade.registerMediator(mediator);
				_displayListItemMediators.push(mediator);
				_yIndex ++;
				if (currentComponent.isOpen && currentComponent.entity is DisplayObjectContainer && DisplayObjectContainer(currentComponent.entity).numChildren > 0)
				{
					roundDownPanelData(currentComponent);
				}
			}
		}
		
		private function onTouchNadler(e:TouchEvent):void
		{
			trace ("fdafds");
		}
		
		/**
		 *计算当前组件与顶层组件相差多少层 
		 * @param entirtyComponent
		 * @param currentComponent
		 * @return 
		 * 
		 */		
		private function calculateComponentLayerCount(entirtyComponent:IComponent, currentComponent:IComponent):int
		{
			var entirtyEntity:DisplayObject = entirtyComponent.entity;
			var currentEntity:DisplayObject = currentComponent.entity;
			if (currentEntity.name == entirtyEntity.name)
			{
				return 0;
			}
			var index:int = 1;
			while(currentEntity.parent)
			{
				if (currentEntity.parent.name == entirtyEntity.name)
				{
					return index;
				}
				currentEntity = currentEntity.parent;
				index ++;
			}
			return -1;
		}
		/**
		 *创建一个测试用的quad 
		 * @return 
		 * 
		 */		
		private function createTestRect():Quad
		{
			var quad:Quad = new Quad(200, 20, uint(Math.random() * 200));
			return quad;
		}
		
		public function get panel():Panel
		{
			return this.viewComponent as Panel;
		}
	}
}