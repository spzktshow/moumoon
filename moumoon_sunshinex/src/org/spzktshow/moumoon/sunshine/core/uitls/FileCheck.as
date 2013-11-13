package org.spzktshow.moumoon.sunshine.core.uitls
{
	import flash.filesystem.File;

	public class FileCheck
	{
		public function FileCheck()
		{
		}
		/**
		 *检测文件类型是否匹配 
		 * @param file
		 * @param type
		 * @return 
		 * 
		 */		
		public static function check(file:File, type:String):Boolean
		{
			if (file.extension == type) return true;
			return false;
		}
	}
}