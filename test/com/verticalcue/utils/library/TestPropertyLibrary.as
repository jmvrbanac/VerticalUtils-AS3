package com.verticalcue.utils.library 
{
	import flexunit.framework.Assert;
	/**
	 * @author John Vrbanac
	 */
	public class TestPropertyLibrary 
	{
		private var _library:PropertyLibrary;
		public function TestPropertyLibrary() 
		{
			
		}
		
		[Before]
		public function setUp():void
		{
			_library = new PropertyLibrary();
		}
		
		[Test(timeout="10000", description="", issueID="")]
		public function testBasicSetGet():void
		{
			_library.addValue("//basePath1/basePath2/entry", "TEST STRING");
			Assert.assertEquals("TEST STRING", _library.getValue("//basePath1/basePath2/entry"));
		}
		
		[Test(async, timeout="10000", description="", issueID="")]
		public function testGetSetWithTopLevelCategory():void
		{
			_library.addValue("//basePath1/entry", "TEST STRING");
			Assert.assertEquals("TEST STRING", _library.getValue("//basePath1/entry"));
		}
		
		[Test(async, timeout="10000", description="", issueID="")]
		public function testGetSetXML():void
		{
			_library.addValue("//basePath1/entry", new XML("<root><tempNode>contentOfTemp</tempNode></root>"));
			
			var result:XML = _library.getValue("//basePath1/entry");
			Assert.assertNotNull(result);
			Assert.assertTrue(result is XML);
			Assert.assertEquals("contentOfTemp", result.tempNode.text().toString());
		}
		
		[Test(async, timeout="10000", description="", issueID="")]
		public function testAddingValueFromKeyValueString():void
		{
			_library.addKeyValueString("//keyBase/secondCat/boom=test");
			Assert.assertEquals("test", _library.getValue("//keyBase/secondCat/boom"));
		}
		
		
		[Test(async, timeout="10000", description="", issueID="")]
		public function testGettingKeyValuesFromXML():void
		{
			var xml:XML = <root><child1><subChild><enabled>true</enabled></subChild></child1><child2><subChild><otherChild><enabled>true</enabled></otherChild></subChild></child2></root>;

			var results:Vector.<String> = PropertyLibrary.getKeyValuesFromXML(xml);
			
			Assert.assertEquals(2, results.length);
			Assert.assertEquals("//root/child1/subChild/enabled=true", results[0]);
			Assert.assertEquals("//root/child2/subChild/otherChild/enabled=true", results[1]);
		}
		
		[Test(timeout="10000", description="", issueID="")]
		public function testReAddingValue():void
		{
			_library.addValue("//basePath1/entry", "TEST STRING");
			Assert.assertEquals("TEST STRING", _library.getValue("//basePath1/entry"));
			
			_library.addValue("//basePath1/entry", "TEST STRING1");
			Assert.assertEquals("TEST STRING1", _library.getValue("//basePath1/entry"));
		}
		
		[Test(timeout="10000", description="", issueID="")]
		public function testReAddingValueFromKeyValueString():void
		{
			_library.addKeyValueString("//keyBase/secondCat/boom=test");
			Assert.assertEquals("test", _library.getValue("//keyBase/secondCat/boom"));
			
			_library.addKeyValueString("//keyBase/secondCat/boom=test1");
			Assert.assertEquals("test1", _library.getValue("//keyBase/secondCat/boom"));
		}
		
		[Test(timeout = "10000", description = "", issueID = "")]
		public function testGetValueBeforeAssignment():void
		{
			var result:XML = _library.getValue("//basePath1/entry");
			Assert.assertNull(result);			
		}
		
		[Test(timeout = "10000", description = "", issueID = "")]
		public function testAddingMultipleValuesToCategory():void
		{
			_library.addValue("//basePath1/entry", "TEST STRING");
			_library.addValue("//basePath1/entry1", "TEST STRING");
			
			Assert.assertEquals("TEST STRING", _library.getValue("//basePath1/entry"));
			Assert.assertEquals("TEST STRING", _library.getValue("//basePath1/entry1"));
		}
	}

}