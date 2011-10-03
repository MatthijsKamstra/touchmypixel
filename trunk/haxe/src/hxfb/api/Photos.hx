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
 * Photos API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Photos 
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
	* Adds a tag with the given information to a photo. See the wiki for details:
	*
	*  http://wiki.developers.facebook.com/index.php/Photos.addTag
	*
	* @param String $pid          The ID of the photo to be tagged
	* @param String $tag_uid      The ID of the user being tagged. You must specify
	*                          either the $tag_uid or the $tag_text parameter
	*                          (unless $tags is specified).
	* @param String $tag_text  Some text identifying the person being tagged.
	*                          You must specify either the $tag_uid or $tag_text
	*                          parameter (unless $tags is specified).
	* @param float $x          The horizontal position of the tag, as a
	*                          percentage from 0 to 100, from the left of the
	*                          photo.
	* @param float $y          The vertical position of the tag, as a percentage
	*                          from 0 to 100, from the top of the photo.
	* @param array $tags       (Optional) An array of maps, where each map
	*                          can contain the tag_uid, tag_text, x, and y
	*                          parameters defined above.  If specified, the
	*                          individual arguments are ignored.
	* @param String $owner_uid    (Optional)  The user ID of the user whose photo
	*                          you are tagging. If this parameter is not
	*                          specified, then it defaults to the session user.
	*
	* @return bool  true on success
	*/
	public function addTag(pId:String, tagUId:String, tagText:String, x:Float, y:Float, ?tags:Array<Dynamic>, ?ownerUId:String = "0"):Bool
	{
		params.set("pid", pId);
		params.set("tag_uid", tagUId);
		params.set("tag_text", tagText);
		params.set("x", x);
		params.set("y", y);
		
		if (tags != null)
		{
			var tagsEncoder:JSONEncoder = new JSONEncoder(tags);
			params.set("tags", tagsEncoder.getString());
		}
		
		params.set("owner_id", hnf.getUID(ownerUId));
		
		return hnf.callMethod("facebook.photos.addTag", params);
	}
	
	/**
	* Creates and returns a new album owned by the specified user or the current
	* session user.
	*
	* @param string $name         The name of the album.
	* @param string $description  (Optional) A description of the album.
	* @param string $location     (Optional) A description of the location.
	* @param string $visible      (Optional) A privacy setting for the album.
	*                             One of 'friends', 'friends-of-friends',
	*                             'networks', or 'everyone'.  Default 'everyone'.
	* @param String $uid             (Optional) User id for creating the album; if
	*                             not specified, the session user is used.
	*
	* @return array  An album object
	*/
	public function createAlbum(name:String, ?description:String = "", ?location:String = "", ?visible:String = "", ?uId:String = "0"):Dynamic
	{
		params.set("name", name);
		params.set("description", description);
		params.set("location", location);
		params.set("visible", visible);
		params.set("uid", hnf.getUID(uId));
		
		hnf.callMethod("facebook.photos.createAlbum", params);
	}
	
	/**
	* Returns photos according to the filters specified.
	*
	* @param int $subj_id  (Optional) Filter by uid of user tagged in the photos.
	* @param int $aid      (Optional) Filter by an album, as returned by
	*                      photos_getAlbums.
	* @param array/string $pids   (Optional) Restrict to an array of pids
	*                             (csv is deprecated)
	*
	* Note that at least one of these parameters needs to be specified, or an
	* error is returned.
	*
	* @return array  An array of photo objects.
	*/
	public function get(subjId:String, aId:String, pIds:Array<String>):Dynamic
	{
		params.set("subj_id", subjId);
		params.set("aid", aId);
		params.set("pids", pIds);
		
		return hnf.callMethod("facebook.photos.get", params);
	}
	
	/**
	* Returns the albums created by the given user.
	*
	* @param String $uid      (Optional) The uid of the user whose albums you want.
	*                       A null will return the albums of the session user.
	* @param String $aids  (Optional) An array of aids to restrict
	*                       the query. (csv is deprecated)
	*
	* Note that at least one of the (uid, aids) parameters must be specified.
	*
	* @returns an array of album objects.
	*/
	public function getAlbums(uId:String, aIds:Array<String>):Dynamic
	{
		params.set("uid", uId);
		params.set("aids", aIds);
		
		return hnf.callMethod("facebook.photos.getAlbums", params);
	}
	
	/**
	* Returns the tags on all photos specified.
	*
	* @param string $pids  A list of pids to query
	*
	* @return array  An array of photo tag objects, which include pid,
	*                subject uid, and two floating-point numbers (xcoord, ycoord)
	*                for tag pixel location.
	*/
	public function getTags(pIds:Array<String>):Dynamic
	{
		params.set("pids", pIds);
		
		return hnf.callMethod("facebook.photos.getTags", params);
	}
	
	/**
	* Uploads a photo.
	*
	* @param string $file     The location of the photo on the local filesystem.
	* @param string $aid         (Optional) The album into which to upload the
	*                         photo.
	* @param string $caption  (Optional) A caption for the photo.
	* @param string uid          (Optional) The user ID of the user whose photo you
	*                         are uploading
	*
	* @return array  An array of user objects
	*/
	public function upload(file:String, ?aId:String, ?caption:String, ?uId:String):Dynamic
	{
		params.set("aid", aId);
		params.set("caption", caption);
		params.set("uid", uId);
		
		return hnf.callUploadMethod("facebook.photos.upload", params, file);
	}
	
}