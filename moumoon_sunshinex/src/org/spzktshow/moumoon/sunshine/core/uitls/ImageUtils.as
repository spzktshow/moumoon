package org.spzktshow.moumoon.sunshine.core.uitls
{
	import starling.display.Image;

	public class ImageUtils
	{
		public function ImageUtils()
		{
		}
		
		public static function calculateImage(image:Image, max:Number):void
		{
			var scale:Number;
			if (image.width > image.height)
			{
				scale = max / image.width;
			}
			else
			{
				scale = max / image.height;
			}
			image.scaleX = scale;
			image.scaleY = scale;
		}
	}
}