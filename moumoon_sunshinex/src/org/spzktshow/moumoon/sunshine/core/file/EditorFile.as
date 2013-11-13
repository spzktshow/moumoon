package org.spzktshow.moumoon.sunshine.core.file
{
	import flash.net.dns.AAAARecord;
	
	import org.spzktshow.file.dataStrcuture.File;
	import org.spzktshow.moumoon.core.component.ComponentGroup;
	import org.spzktshow.moumoon.core.component.IComponentGroup;
	import org.spzktshow.moumoon.core.source.ISource;
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	
	public class EditorFile extends File implements IEditorFile
	{
		private var _sources:Vector.<ISource>;
		
		private var _component:IListComponent;
		
		private var _defaultNameIndex:int;
		
		private var _componentGroup:IComponentGroup;
		
		public function EditorFile()
		{
			_sources = new Vector.<ISource>;
			_defaultNameIndex = 0;
			_componentGroup = new ComponentGroup;
			super();
		}
		
		public function get sources():Vector.<ISource>
		{
			return _sources;
		}
		
		public function set component(value:IListComponent):void
		{
			_component = value;
		}
		
		public function get component():IListComponent
		{
			return _component;
		}
		
		public function get defaultNameIndex():int
		{
			_defaultNameIndex ++;
			return _defaultNameIndex;
		}
		
		public function set componentGroup(value:IComponentGroup):void
		{
			_componentGroup = value;
		}
		
		public function get componentGroup():IComponentGroup
		{	
			return _componentGroup;
		}
		
		
	}
}