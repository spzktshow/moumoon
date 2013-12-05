package org.spzktshow.moumoon.sunshine.view.displayList.mediator
{	
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	
	import org.spzktshow.moumoon.sunshine.core.assets.Assets;
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	import org.spzktshow.moumoon.sunshine.core.component.utils.ListComponentUtils;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class DisplayItemFactory
	{
		public function DisplayItemFactory()
		{
		}
		
		public static const INPUT_TEXT:String = "inputText";
		
		public static const LABEL:String = "label";
		
		public static const FOCUS_QUAD:String = "focusQuad";
		
		public static const FOCUS_CONTAINER_QUAD:String = "focusContainerQuad";
		
		public static var LOCK:Texture = Assets.getInstance().iconSource.getTexture(Assets.LOCK);
		
		public static var EYE:Texture = Assets.getInstance().iconSource.getTexture(Assets.EYE);
		
		private static var IS_OPEN:Texture = Assets.getInstance().iconSource.getTexture(Assets.IS_OPEN);
		
		private static var NO_OPEN:Texture = Assets.getInstance().iconSource.getTexture(Assets.NO_OPEN);
		
		private static const COL_GAP:int = 24;
		/**
		 *纵向的gap值 
		 */		
		public static const ROW_GAP:int = 35;
		//焦点的quad宽度，同时也作用于textInput和label
		public static const FOCUS_WIDTH:Number = 100;
		public static const FOCUS_HEIGHT:Number = 25;
		
		public static const FOCUS_COLOR:uint = 0xff8811;
		public static const FOCUS_CONTAINER_COLOR:uint = 0x6699ff;
		
		public static const LIGHT_TEXT_COLOR:uint = 0xe5e5e5;
		public static const DARK_TEXT_COLOR:uint = 0x1a1a1a;
		
		private static var itemList:Vector.<Sprite> = new Vector.<Sprite>;
		/**
		 *获取title 
		 * @return 
		 * 
		 */		
		public static function getTitle():Sprite
		{
			if (itemList.length > 0)
			{
				return itemList[0];
			}
			else
			{
				return createTitle();
			}
		}
		/**
		 *丢弃一个title 
		 * @param value
		 * 
		 */		
		public static function pullDownTitle(value:Sprite):void
		{
			if (itemList.indexOf(value) != -1) return;
			itemList.push(value);
		}
		/**
		 * 创建title
		 * @param listComponent lock view isOpen
		 * @return 
		 * 
		 */		
		public static function createTitle():Sprite
		{
			var container:Sprite = new Sprite;
			var lock:Image = new Image(LOCK);
			container.addChild(lock);
			lock.name = Assets.LOCK;
			lock.x = 0;
			lock.scaleX = .5;
			lock.scaleY = .5;
			var eye:Image = new Image(EYE);
			container.addChild(eye);
			eye.x = COL_GAP;
			eye.name = Assets.EYE;
			eye.scaleX = .5;
			eye.scaleY = .5;
			var isOpen:Image = new Image(IS_OPEN);
			container.addChild(isOpen);
			isOpen.x = COL_GAP * 2;
			isOpen.name = Assets.IS_OPEN;
			isOpen.scaleX = .5;
			isOpen.scaleY = .5;
			var noOpen:Image = new Image(NO_OPEN);
			container.addChild(noOpen);
			noOpen.x = COL_GAP * 2;
			noOpen.name = Assets.NO_OPEN;
			noOpen.scaleX = .5;
			noOpen.scaleY = .5;
			var textFiled:TextInput = new TextInput;
			textFiled.width = FOCUS_WIDTH;
			textFiled.height = FOCUS_HEIGHT;
			container.addChild(textFiled);
			textFiled.x = COL_GAP * 3;
			textFiled.name = INPUT_TEXT;
			var label:Label = new Label;
			label.width = FOCUS_WIDTH;
			label.height = FOCUS_HEIGHT;
			container.addChild(label);
			label.x = COL_GAP * 3;
			label.name = LABEL;
			return container;
		}
		
		public static function renderIsOpen(listComponent:IListComponent, title:Sprite):void
		{
			if (ListComponentUtils.checkIsContainer(listComponent) > 0)
			{
				if (listComponent.isOpen)
				{
					var isOpen:Image = title.getChildByName(Assets.IS_OPEN) as Image;
					var noOpen:Image = title.getChildByName(Assets.NO_OPEN) as Image;
					isOpen.visible = true;
					noOpen.visible = false;
					isOpen.touchable = true;
					noOpen.touchable = false;
				}
				else
				{
					isOpen = title.getChildByName(Assets.IS_OPEN) as Image;
					noOpen = title.getChildByName(Assets.NO_OPEN) as Image;
					isOpen.visible = false;
					noOpen.visible = true;
					noOpen.touchable = true;
					isOpen.touchable = false;
				}
			}
			else
			{
				isOpen = title.getChildByName(Assets.IS_OPEN) as Image;
				noOpen = title.getChildByName(Assets.NO_OPEN) as Image;
				isOpen.visible = false;
				noOpen.visible = false;
				noOpen.touchable = false;
				isOpen.touchable = false;
			}
		}
		
		public static function renderIsView(listComponent:IListComponent, title:Sprite):void
		{
			if (ListComponentUtils.checkTopUnView(listComponent) != null)
			{
				//
				var eye:Image = title.getChildByName(Assets.EYE) as Image;
				eye.alpha = .5;
			}
			else
			{
				eye = title.getChildByName(Assets.EYE) as Image;
				eye.alpha = 1;
			}
		}
		
		/**
		 *渲染一个title 
		 * @param listComponent
		 * @param title
		 * 
		 */		
		public static function renderTitle(listComponent:IListComponent, title:Sprite):void
		{
			if (ListComponentUtils.checkTopLock(listComponent) != null)
			{
				//lock
				var lock:Image = title.getChildByName(Assets.LOCK) as Image;
				lock.alpha = .5;
			}
			else
			{
				lock = title.getChildByName(Assets.LOCK) as Image;
				lock.alpha = 1;
			}
			
			renderIsOpen(listComponent, title);
			renderIsView(listComponent, title);
			
			var textFiled:TextInput = title.getChildByName(INPUT_TEXT) as TextInput;
			var label:Label = title.getChildByName(LABEL) as Label;
			textFiled.text = listComponent.name;
			label.text = listComponent.name;
			//unVisible input
			textFiled.visible = false;
			if (listComponent.isFocus)
			{
				label.textRendererProperties.background = true;
				label.textRendererProperties.backgroundColor = FOCUS_COLOR;
			}
			else if (listComponent.isFocusBeContainer)
			{
				label.textRendererProperties.background = true;
				label.textRendererProperties.backgroundColor = FOCUS_CONTAINER_COLOR;
			}
			else
			{
				label.textRendererProperties.background = false;
			}
		}
	}
}