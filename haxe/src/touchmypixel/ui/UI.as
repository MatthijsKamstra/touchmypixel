package com.touchmypixel.ui 
{
	
	/**
	* ...
	* @author Default
	*/
	public class UI 
	{
		
		public function UI() 
		{
			
		}
		protected function importStageElement(id:String)
		{
			if (this["e_" + id] != null) {
				this["ui_"+id = this["e_" + id]
			} else {
				this["ui_" + id] = new MovieClip();
				addChild(this["ui_" + id]);
			}
		}
	}
	
}