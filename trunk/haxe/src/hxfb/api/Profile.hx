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
 * Profile API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Profile 
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
	* Sets the FBML for the profile of the user attached to this session.
	*
	* @param   String   markup           The FBML that describes the profile
	*                                     presence of this app for the user
	* @param   String   uid              The user
	* @param   String   profile          Profile FBML
	* @param   String   profile_action   Profile action FBML (deprecated)
	* @param   String   mobile_profile   Mobile profile FBML
	* @param   String   profile_main     Main Tab profile FBML
	*
	* @return  Dynamic  A list of strings describing any compile errors for the
	*                 	submitted FBML
	*/
	public function setFBML(markup:String, ?uId:String, ?profile:String = "", ?profileAction:String = "", ?mobileProfile:String = "", ?profileMain:String = ""):Dynamic
	{
		params.set("markup", markup);
		params.set("uid", uId);
		params.set("profile", profile);
		params.set("profile_action", profileAction);
		params.set("mobile_profile", mobileProfile);
		params.set("profile_main", profileMain);
		
		return hnf.callMethod("facebook.profile.setFBML", params);
	}
	
	/**
	* Gets the FBML for the profile box that is currently set for a user's
	* profile (your application set the FBML previously by calling the
	* profile.setFBML method).
	*
	* @param String	uid   (Optional) User id to lookup; defaults to session.
	* @param Int	type  (Optional) 1 for original style, 2 for profile_main boxes
	*
	* @return string  The FBML
	*/
	public function getFBML(?uId:String, ?type:Int):String
	{
		params.set("uid", uId);
		params.set("type", type);
		
		return hnf.callMethod("facebook.profile.getFBML", params);
	}
	
	/**
	* Returns the specified user's application info section for the calling
	* application. These info sections have either been set via a previous
	* profile.setInfo call or by the user editing them directly.
	*
	* @param int $uid  (Optional) User id to lookup; defaults to session.
	*
	* @return array  Info fields for the current user.  See wiki for structure:
	*
	*  http://wiki.developers.facebook.com/index.php/Profile.getInfo
	*
	*/
	public function getInfo(?uId:String):Dynamic
	{
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.profile.getInfo", params);
	}
	
	/**
	* Returns the options associated with the specified info field for an
	* application info section.
	*
	* @param string $field  The title of the field
	*
	* @return array  An array of info options.
	*/
	public function getInfoOptions(field:Array<String>):Dynamic
	{
		params.set("field", field);
		
		return hnf.callMethod("facebook.profile.getInfoOptions", params);
	}
	
	/**
	* Configures an application info section that the specified user can install
	* on the Info tab of her profile.  For details on the structure of an info
	* field, please see:
	*
	*  http://wiki.developers.facebook.com/index.php/Profile.setInfo
	*
	* @param String			title       Title / header of the info section
	* @param Int			type           1 for text-only, 5 for thumbnail views
	* @param Hash<Dynamic>	info_fields  An array of info fields. See wiki for details.
	* @param String			uid            (Optional)
	*
	* @return bool  true on success
	*/
	public function setInfo(title:String, type:Int, infoFields:Hash<Dynamic>, ?uId:String):Bool
	{
		var infoFieldsEncoder:JSONEncoder = new JSONEncoder(infoFields);
		
		params.set("title", title);
		params.set("type", type);
		params.set("info_field", infoFieldsEncoder.getString());
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.profile.setInfo", params);
	}
	
	public function setInfoOptions(field:String, options:Hash<Dynamic>):Bool
	{
		var optionsEncoder:JSONEncoder = new JSONEncoder(options);
		
		params.set("field", field);
		params.set("options", optionsEncoder.getString());
		
		return hnf.callMethod("facebook.profile.setInfoOptions", params);
	}
	
}