/**
 * 
 Copyright (c) 2010 SoybeanSoft

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 *
 * Gifts API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONDecoder;
import hxjson2.JSONEncoder;

class Gifts 
{
	private var hnf:HxFb;
	private var params(getParams, null):Hash<Dynamic>;
	private function getParams():Hash<Dynamic>
	{
		return new Hash<Dynamic>();
	}
	
	public function new(hnf:HxFb) 
	{
		this.hnf = hnf;
	}
	
	/**
	* Get Gifts associated with an app
	*
	* @return             array of gifts
	*/
	public function get():Dynamic
	{
		var result:String = hnf.callMethod("facebook.gifts.get");
		var getDecoder:JSONDecoder = new JSONDecoder(result, true);
		
		return getDecoder.getValue();
	}
	
	public function update(updateArray:IntHash<String>):Dynamic
	{
		var updateArrayEncoder:JSONEncoder = new JSONEncoder(updateArray);
		params.set("updaet_str", updateArrayEncoder.getString());
		var result:String = hnf.callMethod("facebook.gifts.update", params);
		var updateDecoder:JSONDecoder = new JSONDecoder(result, true);
		
		return updateDecoder.getValue();
	}
	
}