package org.spzktshow.moumoon.young.alert
{
	import feathers.controls.Button;
	import feathers.core.FeathersControl;
	
	import starling.display.DisplayObject;

	public class ContentAlert extends BaseAlert
	{	
		//const
		protected static var buttonWidth:Number = 100;
		protected static var buttonHeight:Number = 25;
		protected static var buttonBorderGap:Number = 0.1;//10%
		protected static var buttonYGap:Number = -0.1;//10%
		/**
		 *内容列表 
		 */		
		protected var _contents:Vector.<DisplayObject>;
		/**
		 *按钮 
		 */		
		protected var _buttons:Vector.<String>;
		/**
		 *按钮item列表 
		 */		
		protected var _buttonItems:Vector.<Button>;
		
		private var _gap:Number = 10;

		/**
		 *contents间距 
		 */
		public function get gap():Number
		{
			return _gap;
		}

		/**
		 * @private
		 */
		public function set gap(value:Number):void
		{
			_gap = value;
		}
		
		public function ContentAlert(title:String)
		{
			_contents = new Vector.<DisplayObject>;
			_buttons = new Vector.<String>;
			_buttonItems = new Vector.<Button>;
			super(title);
		}
		/**
		 *加入内容 
		 * 
		 */		
		public function pushContent(content:DisplayObject):void
		{
			if (_contents.indexOf(content) != -1) return; 
			_contents.push(content);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.createContents();
			
			this.createButtons();
			
			this.layoutContents();
			this.layoutButtons();
		}
		
		override protected function draw():void
		{
			super.draw();
			
			const sizeFlag:Boolean = this.isInvalid(FeathersControl.INVALIDATION_FLAG_SIZE);
			if (sizeFlag)
			{
				this.layoutContents();
				this.layoutButtons();
			}
		}
		
		protected function createContents():void
		{
			for each(var displayObject:DisplayObject in _contents)
			{
				_panel.addChild(displayObject);
			}
		}
		
		/**
		 *布局内容 
		 * 
		 */		
		public function layoutContents():void
		{
			/**
			 *contents的totalwidht 
			 */		
			var _contentsTotalWidth:Number;
			_contentsTotalWidth = 0;
			var index:int = 0;
			for each(var displayObject:DisplayObject in _contents)
			{
				_contentsTotalWidth += displayObject.width;
				if (index != _contents.length - 1)
					_contentsTotalWidth += _gap;
				displayObject.y = this.height * .5 - displayObject.height * .5;
				index ++;
			}
			var widthIndex:Number = 0;
			for each(displayObject in _contents)
			{
				displayObject.x = widthIndex;
				widthIndex = displayObject.x + displayObject.width + _gap;
			}
		}
		/**
		 *加入button类型 
		 * @param type
		 * 
		 */		
		public function pushButtonType(type:String):void
		{
			_buttons.push(type);
		}
		
		protected function createButtons():void
		{
			for each(var type:String in _buttons)
			{
				var button:Button = this.createButton(type);
				_buttonItems.push(button);
				this.addChild(button);
			}
		}
		
		protected function createButton(type:String):Button
		{
			var button:Button = new Button();
			button.label = type;
			button.width = buttonWidth;
			button.height = buttonHeight;
			return button;
		}
		
		public function layoutButtons():void
		{
			var left:Number = this.width * buttonBorderGap;
			var right:Number = this.width - this.width * buttonBorderGap;
			var leftRightGap:Number = right - left;
			var buttonGap:Number = leftRightGap / _buttonItems.length;
			var buttonBottomHeightGap:Number = this.height + this.height * buttonYGap - buttonHeight;
			var index:int = 0;
			for each(var button:Button in _buttonItems)
			{
				button.x = index * buttonGap + buttonGap * .5 - buttonWidth * .5 + left;
				button.y = buttonBottomHeightGap;
				index ++;
			}
		}
	}
}