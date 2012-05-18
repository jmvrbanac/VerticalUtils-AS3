package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;
	import com.verticalcue.utils.UtilitiesTestSuite;
	
	/**
	 * FlexUnit Test Runner for VerticalUtils-AS3
	 * @author John Vrbanac
	 */
	public class TestRunner extends Sprite
	{
		private var _core:FlexUnitCore;
		public function TestRunner() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_core = new FlexUnitCore();
			_core.addListener(new TraceListener());
			_core.run(UtilitiesTestSuite);
		}
		
	}

}