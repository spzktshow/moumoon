package org.spzktshow.moumoon.sunshine.model.file
{
	/**
	 *这个数据结构用来在程序运行的生命周期中记录创建的名称是否有重复，如果有重复则index＋1,并且实际记录在内存中的名称后缀为相应的index 
	 * @author rocklee
	 * 
	 */	
	public class FileNameCacheData
	{
		public function FileNameCacheData()
		{
		}
		
		public var name:String;
		public var index:int;
	}
}