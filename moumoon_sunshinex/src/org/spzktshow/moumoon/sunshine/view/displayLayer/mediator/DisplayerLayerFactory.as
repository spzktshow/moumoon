package org.spzktshow.moumoon.sunshine.view.displayLayer.mediator
{
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	
	import starling.display.DisplayObject;

	/**
	 *显示层工厂 
	 * @author rocklee
	 * 
	 */
	public class DisplayerLayerFactory
	{
		public function DisplayerLayerFactory()
		{
		}
		
		public static function create(component:IListComponent):DisplayObject
		{
//			if (component.templateType == ComponentSourceTypeEnum.JPG || component.templateType == ComponentSourceTypeEnum.PNG)
//			{
//				var image:Image = new Image(component.source.data);
//				return image;
//			}
//			else if (component.templateType == ComponentSourceTypeEnum.CONTAINER)
//			{
//				return new Sprite;
//			}
			return null;
		}
		/**
		 *根据componentTemplate创建显示 
		 * @param component
		 * @return 
		 * 
		 */		
		public static function createComponentTemplate(component:IListComponent):DisplayObject
		{
			return null;
		}
	}
}