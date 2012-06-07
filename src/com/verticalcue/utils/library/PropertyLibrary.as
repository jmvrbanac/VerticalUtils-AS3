package com.verticalcue.utils.library 
{
	import com.verticalcue.errors.NotImplementedError;
	/**
	 * Stores and retrieves values through a basic XPath like stucture.
	 * @version 1.0
	 * @author John Vrbanac
	 */
	public class PropertyLibrary 
	{
		private var _library:Vector.<PropertyLibraryCategory>;
		public function PropertyLibrary() 
		{
			_library = new Vector.<PropertyLibraryCategory>();
		}
		public function addValue(path:String, blob:*):void
		{
			if (isPathValid(path)) {
				var workingPath:String = path.substring(1);
				var catArray:Array = workingPath.split("/");
				
				// Get local category or create new one
				var category:PropertyLibraryCategory = getLocalCategory(catArray[1]);
				if (category == null) {
					category = new PropertyLibraryCategory(catArray[1]);
					_library.push(category);
				} 
				
				// Stripping out current category
				workingPath = workingPath.substring(workingPath.indexOf("/", 1));
				category.store(workingPath, blob);
			}
		}
		/**
		 * Allows quick insertion of a full path //path/to/key=value.
		 * @param	pathAndValue
		 */
		public function addKeyValueString(pathAndValue:String):void
		{
			var splitIndex:int = pathAndValue.lastIndexOf("=");
			var path:String = pathAndValue.substring(0, splitIndex);
			var value:String = pathAndValue.substring(splitIndex + 1)
			addValue(path, value);
		}
		public function getValue(path:String):*
		{
			if (isPathValid(path)) {
				var workingPath:String = path.substring(1);
				var catArray:Array = workingPath.split("/");
				
				// Get local category or create new one
				var category:PropertyLibraryCategory = getLocalCategory(catArray[1]);
				if (category) {
					return category.getEntry(workingPath.substring(workingPath.indexOf("/", 1))).payload;
				}
			}
			return null;
		}
		
		/**
		 * Retrieves a specific category's stored values
		 * @param	path
		 * @return
		 */
		public function getCategory(path:String):PropertyLibraryCategory
		{
			throw new NotImplementedError();
			return null;
		}
		
		private function isPathValid(path:String):Boolean
		{
			var result:Boolean = true;
			
			if (path.indexOf("//") != 0) {
				result = false;
			}
			
			if (path.indexOf("/", 3) < 3) {
				result = false;
			}
			
			return result;
		}
		private function getLocalCategory(name:String):PropertyLibraryCategory
		{
			var category:PropertyLibraryCategory = null;
			for (var i:int = 0; i < _library.length; i++)
			{
				if (_library[i].name == name) {
					category = _library[i];
				}
			}
			return category;
		}
		
		/**
		 * This method is designed to translate a very basic xml structure into key value pairs //path/to/xml=value
		 * @param	xml
		 * @param	currentPaths
		 * @return
		 */
		public static function getKeyValuesFromXML(xml:XML, currentPaths:Vector.<String> = null):Vector.<String>
		{
			var nodeChildren:XMLList = xml.children();
			var result:String = "";
			
			if (currentPaths == null) {
				currentPaths = new Vector.<String>();
			}
			
			// Add the value for the lowest key
			if (nodeChildren.length() == 1 && nodeChildren[0].children().length() == 0 && nodeChildren[0].nodeKind() == "text") {
				currentPaths.push(getPathFromParents(xml) + "=" + xml.text());
			} 
			// Recursively dive into the elements
			else {
				for (var i:int = 0; i < nodeChildren.length(); i++) {
					currentPaths = getKeyValuesFromXML(nodeChildren[i], currentPaths);
				}
			}
			
			return currentPaths;
		}
		
		internal static function getPathFromParents(currentNode:XML):String
		{
			var result:String = currentNode.localName();
			
			var parentNode:XML = currentNode.parent();
			while (parentNode != null) {
				result = parentNode.localName() + "/" + result;
				parentNode = parentNode.parent();
			}
			
			return "//" + result;
		}
		
	}
}