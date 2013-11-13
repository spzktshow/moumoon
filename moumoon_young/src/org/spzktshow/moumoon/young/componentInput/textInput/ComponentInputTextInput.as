package org.spzktshow.moumoon.young.componentInput.textInput
{
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	
	import org.spzktshow.moumoon.young.core.YoungControl;

	/**
	 *带标题的输入框 
	 * @author rocklee
	 * 
	 */	
	public class ComponentInputTextInput extends YoungControl
	{
		/**
		 *title值发生变化 
		 */		
		public static const INVALIDATION_FLAG_TITLE:String = "title";
		
		/**
		 *title label 
		 */		
		protected var _label:Label;
		protected var _textInput:TextInput;
		
		public function ComponentInputTextInput()
		{
			super();
		}
		/**
		 *textInput 
		 */
		public function get textInput():TextInput
		{
			return _textInput;
		}
		/**
		 *设置标题 
		 * @param value
		 * 
		 */		
		public function set title(value:String):void
		{
			_label.text = value;
			
			this.invalidate(INVALIDATION_FLAG_TITLE);
		}
		/**
		 *输入框发生改变 
		 * @param value
		 * 
		 */		
		public function set text(value:String):void
		{
			_textInput.text = value;
		}
		
		override protected function init():void
		{
			_label = new Label();
			_textInput = new TextInput();
			_textInput.width = 100;
			_textInput.height = 25;
		}
		
		override protected function initialize():void
		{
			addChild(_label);
			addChild(_textInput);
			super.initialize();
		}
		
		override protected function draw():void
		{
			super.draw();
			
			if (INVALIDATION_FLAG_TITLE)
			{
				this.layoutTextInput();
			}
		}
		
		protected function layoutTextInput():void
		{
			_textInput.x = _label.x + _label.width + 20;
		}
	}
}