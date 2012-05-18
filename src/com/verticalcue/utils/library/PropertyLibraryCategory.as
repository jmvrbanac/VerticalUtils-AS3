package com.verticalcue.utils.library 
{
	/**
	 * ...
	 * @author John Vrbanac
	 */
	public class PropertyLibraryCategory 
	{
		private var _name:String;
		private var _childCategories:Vector.<PropertyLibraryCategory>;
		private var _entries:Vector.<PropertyLibraryEntry>;
		public function PropertyLibraryCategory(categoryName:String = "") 
		{
			if (categoryName.length > 0) {
				_name = categoryName;
			}
		}
		
		public function store(path:String, blob:*):void
		{
			// We are at the deepest point
			if (path.lastIndexOf("/") == 0) {
				// Create entry storage sollection when needed
				if (_entries == null) {
					_entries = new Vector.<PropertyLibraryEntry>();
				}
				var entry:PropertyLibraryEntry = new PropertyLibraryEntry();
				entry.name = path.substring(1);
				entry.payload = blob;
				_entries.push(entry);
				
			} else {
				// Create category child collection storage when needed
				if (_childCategories == null) {
					_childCategories = new Vector.<PropertyLibraryCategory>();
				}
				
				var modifiedPath:String = path.substring(path.indexOf("/", 1));
				var nCategory:PropertyLibraryCategory = new PropertyLibraryCategory(path.split("/")[1]);
				nCategory.store(modifiedPath, blob);
				_childCategories.push(nCategory);
			}
		}
		
		public function getEntry(path:String):PropertyLibraryEntry
		{
			var result:PropertyLibraryEntry = null;
			if (path.indexOf("/", 1) > 0) {
				var nextCatName:String = path.split("/")[1];
				for (var i:int = 0; i < _childCategories.length; i++)
				{
					if (nextCatName == _childCategories[i].name) {
						var nextPath:String = path.substring(path.indexOf("/", 1));
						result = _childCategories[i].getEntry(nextPath);
					}
				}
			} else {
				var entryName:String = path.substring(1);
				for (var j:int = 0; j < _entries.length; j++) {
					if (entryName == _entries[j].name) {
						result = _entries[j];
					}
				}
			}
			return result;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
	}

}