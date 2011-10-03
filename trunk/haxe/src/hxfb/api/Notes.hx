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
 * Notes API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Notes 
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
	* Creates a note with the specified title and content.
	*
	* @param string $title   Title of the note.
	* @param string $content Content of the note.
	* @param String $uid     (Optional) The user for whom you are creating a
	*                        note; defaults to current session user
	*
	* @return String	The ID of the note that was just created.
	*/
	public function create(title:String, content:String, ?uId:String):String
	{
		params.set("title", title);
		params.set("content", content);
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.notes.create", params);
	}
	
	/**
	* Deletes the specified note.
	*
	* @param String $note_id  ID of the note you wish to delete
	* @param String $uid      (Optional) Owner of the note you wish to delete;
	*                      defaults to current session user
	*
	* @return bool
	*/
	public function delete(noteId:String, ?uId:String):Bool
	{
		params.set("note_id", noteId);
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.notes.delete", params);
	}
	
	/**
	* Edits a note, replacing its title and contents with the title
	* and contents specified.
	*
	* @param String $note_id  ID of the note you wish to edit
	* @param string $title    Replacement title for the note
	* @param string $content  Replacement content for the note
	* @param String $uid      (Optional) Owner of the note you wish to edit;
	*                         defaults to current session user
	*
	* @return bool
	*/
	public function edit(noteId:String, title:String, content:String, ?uId:String):Bool
	{
		params.set("note_id", noteId);
		params.set("title", title);
		params.set("content", content);
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.notes.edit", params);
	}
	
	/**
	* Retrieves all notes by a user. If note_ids are specified,
	* retrieves only those specific notes by that user.
	*
	* @param String $uid      User whose notes you wish to retrieve
	* @param array  $note_ids (Optional) List of specific note
	*                         IDs by this user to retrieve
	*
	* @return array A list of all of the given user's notes, or an empty list
	*               if the viewer lacks permissions or if there are no visible
	*               notes.
	*/
	public function get(uId:String, ?noteIds:Array<String>):Dynamic
	{
		params.set("uid", uId);
		params.set("note_ids", noteIds);
		
		return hnf.callMethod("facebook.notes.get", params);
	}
}