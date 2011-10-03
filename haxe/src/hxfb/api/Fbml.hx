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
 * FBML API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Fbml 
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
	* Fetches and re-caches the image stored at the given URL, for use in images
	* published to non-canvas pages via the API (for example, to user profiles
	* via profile.setFBML, or to News Feed via feed.publishUserAction).
	*
	* @param 	String	url		The absolute URL from which to refresh the image.
	*
	* @return 	Bool  			True on success
	*/
	public function refreshImgSrc(url:String):Bool
	{
		params.set("url", url);
		return hnf.callMethod("facebook.fbml.refreshImgSrc", params);
	}
	
	/**
	* Fetches and re-caches the content stored at the given URL, for use in an
	* fb:ref FBML tag.
	*
	* @param 	String	url		The absolute URL from which to fetch content. This URL
	*                     		should be used in a fb:ref FBML tag.
	*
	* @return 	Bool  			True on success
	*/
	public function refreshRefUrl(url:String):Bool
	{
		params.set("url", url);
		return hnf.callMethod("facebook.fbml.refreshRefUrl", params);
	}
	
	/**
	* Associates a given "handle" with FBML markup so that the handle can be
	* used within the fb:ref FBML tag. A handle is unique within an application
	* and allows an application to publish identical FBML to many user profiles
	* and do subsequent updates without having to republish FBML on behalf of
	* each user.
	*
	* @param	String	handle	The handle to associate with the given FBML.
	* @param	String	fbml	The FBML to associate with the given handle.
	*
	* @return	Bool			true on success
	*/
	public function setRefHandle(handle:String, fbml:String):Bool
	{
		params.set("handle", handle);
		params.set("fbml", fbml);
		
		return hnf.callMethod("facebook.fbml.setRefHandle", params);
	}
	
	/**
	* Register custom tags for the application. Custom tags can be used
	* to extend the set of tags available to applications in FBML
	* markup.
	*
	* IMPORTANT: This function overwrites the values of
	* existing tags if the names match. Use this function with care because
	* it may break the FBML of any application that is using the
	* existing version of the tags.
	* 
	* @link http://wiki.developers.facebook.com/index.php/Fbml.RegisterCustomTags
	* 
	* @param	mixed	tags a hash of tag objects (the full description is on the wiki page)
	* 
	* @return	Int		The number of tags that were registered
	*/
	public function registerCustomTags(tags:Hash<Dynamic>):Int
	{
		var tagEncoder:JSONEncoder = new JSONEncoder(tags);
		
		params.set("tags", tagEncoder.getString());
		
		return hnf.callMethod("facebook.fbml.registerCustomTags", params);
	}
	
	/**
	* Get the custom tags for an application. If appId
	* is not specified, the calling app's tags are returned.
	* If appId is different from the id of the calling app,
	* only the app's public tags are returned.
	* The return value is an array of the same type as
	* the tags parameter of fbml_registerCustomTags().
	*
	* @param	Int		appId	the application's id (optional)
	*
	* @return	Dynamic			an array containing the custom tag objects
	*/
	public function getCustomTags(?appId:String):Dynamic
	{
		params.set("app_id", appId);
		
		return hnf.callMethod("facebook.fbml.getCustomTags", params);
	}
	
	/**
	* Delete custom tags the application has registered. If
	* tagNames is null, all the application's custom tags will be
	* deleted.
	*
	* IMPORTANT: If your application has registered public tags
	* that other applications may be using, don't delete those tags!
	* Doing so can break the FBML ofapplications that are using them.
	*
	* @param	Array<String>	tagNames	the names of the tags to delete (optinal)
	* @return	Bool						true on success
	*/
	public function deleteCustomTags(?tagNames:Array<String>):Bool
	{
		var tagnameEncoder:JSONEncoder = new JSONEncoder(tagNames);
		
		params.set("tag_names", tagnameEncoder.getString());
		
		return hnf.callMethod("facebook.fbml.deleteCustomTags", params);
	}
}