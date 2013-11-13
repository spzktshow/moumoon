package org.spzktshow.moumoon.sunshine.core.file
{
	import org.spzktshow.moumoon.core.source.ISource;
	
	public class EditorFileOperation implements IEditorFileOperation
	{	
		private static const DEFAULT_NAME_HEAD:String = "component";
		
		private var _editorFile:IEditorFile;
		
		public function EditorFileOperation()
		{
		}
		
		public function addSource(value:ISource):int
		{
			var index:int = this.getSourceIndex(value.name);
			if (index != -1) return -1;
			return _editorFile.sources.push(value);
		}
		
		public function getSourceIndex(value:String):int
		{
			var index:int = 0;
			for each(var source:ISource in _editorFile.sources)
			{
				if (source.name == value)
				{
					return index;
				}
				index ++;
			}
			return -1;
		}
		
		public function getSource(value:String):ISource
		{
			var index:int = this.getSourceIndex(value);
			if (index != -1) return _editorFile.sources[index];
			return null;
		}
		
		public function removeSource(value:String):ISource
		{
			var index:int = this.getSourceIndex(value);
			if (index != -1) return _editorFile.sources.splice(index, 1)[0] as ISource;
			return null;
		}
		
		public function get editorFile():IEditorFile
		{
			return _editorFile;
		}
		
		public function set editorFile(value:IEditorFile):void
		{
			_editorFile = value;
		}
		
		public function createComponentDefaultName():String
		{
			return DEFAULT_NAME_HEAD + String(editorFile.defaultNameIndex);
		}
		
		
	}
}