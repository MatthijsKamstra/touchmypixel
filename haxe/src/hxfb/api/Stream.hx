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
 * Stream API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Stream 
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
	* Publish a post to the user's stream.
	*
	* @param $message        the user's message
	* @param $attachment     the post's attachment (optional)
	* @param $action links   the post's action links (optional)
	* @param $target_id      the user on whose wall the post will be posted
	*                        (optional)
	* @param $uid            the actor (defaults to session user)
	* @return string the post id
	*/
	public function publish(message:String, ?attachment:String, ?actionLinks:Array<String>, ?targetId:Int, ?uId:String):String
	{
		params.set("message", message);
		params.set("attachment", attachment);
		params.set("action_links", actionLinks);
		params.set("target_id", targetId);
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.stream.publish", params);
	}
	
	/**
	* Remove a post from the user's stream.
	* Currently, you may only remove stories you application created.
	*
	* @param $post_id  the post id
	* @param $uid      the actor (defaults to session user)
	* @return bool
	*/
	public function remove(postId:String, ?uId:String):Bool
	{
		params.set("post_id", postId);
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.stream.remove", params);
	}
	
	/**
	* Add a comment to a stream post
	*
	* @param $post_id  the post id
	* @param $comment  the comment text
	* @param $uid      the actor (defaults to session user)
	* @return string the id of the created comment
	*/
	public function addComment(postId:String, comment:String, ?uId:String):String
	{
		params.set("post_id", postId);
		params.set("comment", comment);
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.stream.addComment", params);
	}
	
	/**
	* Remove a comment from a stream post
	*
	* @param $comment_id  the comment id
	* @param $uid      the actor (defaults to session user)
	* @return bool
	*/
	public function removeComment(commentId:String, ?uId:String):Bool
	{
		params.set("comment_id", commentId);
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.stream.removeComment", params);
	}
	
	/**
	* Add a like to a stream post
	*
	* @param $post_id  the post id
	* @param $uid      the actor (defaults to session user)
	* @return bool
	*/
	public function addLike(postId:String, ?uId:String):Bool
	{
		params.set("post_id", postId);
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.stream.addLike", params);
	}
	
	/**
	* Remove a like from a stream post
	*
	* @param $post_id  the post id
	* @param $uid      the actor (defaults to session user)
	* @return bool
	*/
	public function removeLike(postId:String, ?uId:String):Bool
	{
		params.set("post_id", postId);
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.stream.removeLike", params);
	}
	
	/**
	* Gets the stream on behalf of a user using a set of users. This
	* call will return the latest $limit queries between $start_time
	* and $end_time.
	*
	* @param String $viewer_id  user making the call (def: session)
	* @param array  $source_ids users/pages to look at (def: all connections)
	* @param int    $start_time start time to look for stories (def: 1 day ago)
	* @param int    $end_time   end time to look for stories (def: now)
	* @param int    $limit      number of stories to attempt to fetch (def: 30)
	* @param string $filter_key key returned by stream.getFilters to fetch
	* @param array  $metadata   metadata to include with the return, allows
	*                           requested metadata to be returned, such as
	*                           profiles, albums, photo_tags
	*
	* @return array(
	*           'posts'      => array of posts,
	*           // if requested, the following data may be returned
	*           'profiles'   => array of profile metadata of users/pages in posts
	*           'albums'     => array of album metadata in posts
	*           'photo_tags' => array of photo_tags for photos in posts
	*         )
	*/
	public function get(?viewerId:String, ?sourceIds:Array < String > , ?startTime:Int = 0, ?endTime:Int = 0, ?limit:Int = 30, ?filterKey:String = "", ?exportableOnly:Bool = false, ?metadata:Hash<Dynamic>, ?postIds:Array<String>):Dynamic
	{
		params.set("viewer_id", viewerId);
		params.set("sourced_ids", sourceIds);
		params.set("start_time", startTime);
		params.set("end_time", endTime);
		params.set("limit", limit);
		params.set("filter_key", filterKey);
		params.set("exportable_only", exportableOnly);
		params.set("metadata", metadata);
		params.set("post_ids", postIds);
		
		return hnf.callMethod("facebook.stream.get", params);
	}
	
	/**
	* Gets the filters (with relevant filter keys for stream.get) for a
	* particular user. These filters are typical things like news feed,
	* friend lists, networks. They can be used to filter the stream
	* without complex queries to determine which ids belong in which groups.
	*
	* @param int $uid user to get filters for
	*
	* @return array of stream filter objects
	*/
	public function getFilters(?uId:String):Dynamic
	{
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.stream.getFilters", params);
	}
	
	/**
	* Gets the full comments given a post_id from stream.get or the
	* stream FQL table. Initially, only a set of preview comments are
	* returned because some posts can have many comments.
	*
	* @param string $post_id id of the post to get comments for
	*
	* @return array of comment objects
	*/
	public function getComments(postId:String):Dynamic
	{
		params.set("post_id", postId);
		
		return hnf.callMethod("facebook.stream.getComments", params);
	}
	
}