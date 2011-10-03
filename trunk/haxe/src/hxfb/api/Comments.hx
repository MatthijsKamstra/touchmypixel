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
 * Comments API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;

class Comments 
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
	* Add a comment to a particular xid on behalf of a user. If called
	* without an app_secret (with session secret), this will only work
	* for the session user.
	*
	* @param string $xid   external id associated with the comments
	* @param string $text  text of the comment
	* @param String $uid   user adding the comment (def: session user)
	* @param string $title optional title for the stream story
	* @param string $url   optional url for the stream story
	* @param bool   $publish_to_stream publish a feed story about this comment?
	*                      a link will be generated to title/url in the story
	*
	* @return string comment_id associated with the comment
	*/
	public function add(xid:String, text:String, ?uid:String = "0", ?title:String = "", ?url:String = "", ?publishToStream:Bool = false):String
	{
		params.set("xid", xid);
		params.set("text", text);
		params.set("uid", uid);
		params.set("title", title);
		params.set("url", url);
		params.set("publish_to_stream", publishToStream);
		return hnf.callMethod("facebook.comments.add", params);
	}
	
	/**
	* Gets the comments for a particular xid. This is essentially a wrapper
	* around the comment FQL table.
	*
	* @param string $xid external id associated with the comments
	*
	* @return array of comment objects
	*/
	public function get(xid:String):Dynamic
	{
		params.set("xid", xid);
		return hnf.callMethod("facebook.comments.get", params);
	}
	
	/**
	* Remove a particular comment.
	*
	* @param string $xid        the external id associated with the comments
	* @param string $comment_id id of the comment to remove (returned by
	*                           comments.add and comments.get)
	*
	* @return boolean
	*/
	public function remove(xid:String, commentID:String):Bool
	{
		params.set("xid", xid);
		params.set("comment_id", commentID);
		return hnf.callMethod("facebook.comments.remove", params);
	}
	
}