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
 * Pages API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Pages 
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
	* Returns the requested info fields for the requested set of pages.
	*
	* @param array/string $page_ids  an array of page ids (csv is deprecated)
	* @param array/string  $fields    an array of strings describing the
	*                           info fields desired (csv is deprecated)
	* @param String $uid       (Optional) limit results to pages of which this
	*                          user is a fan.
	* @param string type       limits results to a particular type of page.
	*
	* @return array  An array of pages
	*/
	public function getInfo(pageIds:Array<String>, fields:Hash<String>, uId:String, type:String):Dynamic
	{
		params.set("page_ids", pageIds);
		params.set("fields", fields);
		params.set("uid", uId);
		params.set("type", type);
		
		return hnf.callMethod("facebook.pages.getInfo", params);
	}
	
	/**
	* Returns true if the given user is an admin for the passed page.
	*
	* @param String $page_id  target page id
	* @param String $uid      (Optional) user id (defaults to the logged-in user)
	*
	* @return bool  true on success
	*/
	public function isAdmin(pageId:String, ?uId:String):Bool
	{
		params.set("page_id", pageId);
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.pages.isAdmin", params);
	}
	
	/**
	* Returns whether or not the given page has added the application.
	*
	* @param int $page_id  target page id
	*
	* @return bool  true on success
	*/
	public function isAppAdded(pageId:String):Bool
	{
		params.set("page_id", pageId);
		
		return hnf.callMethod("facebook.pages.isAppAdded", params);
	}
	
	/**
	* Returns true if logged in user is a fan for the passed page.
	*
	* @param String $page_id target page id
	* @param String $uid user to compare.  If empty, the logged in user.
	*
	* @return bool  true on success
	*/
	public function isFan(pageId:String, ?uId:String):Bool
	{
		params.set("page_id", pageId);
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.pages.isFan", params);
	}
	
}