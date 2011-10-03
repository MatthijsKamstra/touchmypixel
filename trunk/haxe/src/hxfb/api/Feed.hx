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
 * Feed API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Feed 
{
	public static inline var STORY_SIZE_ONE_LINE:Int = 1;
	public static inline var STORY_SIZE_SHORT:Int = 2;
	public static inline var STORY_SIZE_FULL:Int = 4;
	
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
	* This method is deprecated for calls made on behalf of users. This method
	* works only for publishing stories on a Facebook Page that has installed
	* your application. To publish stories to a user's profile, use
	* feed.publishUserAction instead.
	*
	* For more details on this call, please visit the wiki page.
	*
	* @link http://wiki.developers.facebook.com/index.php/Feed.publishTemplatizedAction
	*/
	public function publishTemplatizedAction(titleTemplate:String, titleData:String, bodyTemplate:String, bodyData:String, bodyGeneral:String, ?image1:String, ?image1Link:String, ?image2:String, ?image2Link:String, ?image3:String, ?image3Link:String, ?image4:String, ?image4Link:String, ?targetIds:String = "", ?pageActorId:Int):Dynamic
	{
		params.set("title_template", titleTemplate);
		params.set("title_data", titleData);
		params.set("body_template", bodyTemplate);
		params.set("body_data", bodyData);
		params.set("body_general", bodyGeneral);
		params.set("image_1", image1);
		params.set("image_1_link", image1Link);
		params.set("image_2", image2);
		params.set("image_2_link", image2Link);
		params.set("image_3", image1);
		params.set("image_3_link", image3Link);
		params.set("image_4", image1);
		params.set("image_4_link", image4Link);
		params.set("target_ids", targetIds);
		params.set("page_actor_id", pageActorId);
		
		return hnf.callMethod("facebook.feed.publishTemplatizedAction", params);
	}
	
	/**
	* Registers a template bundle.  Template bundles are somewhat involved, so
	* it's recommended you check out the wiki for more details:
	*
	*  http://wiki.developers.facebook.com/index.php/Feed.registerTemplateBundle
	*
	* @return string  A template bundle id
	*/
	public function registerTemplateBundle(oneLineStoryTemplates:Array<String>, ?shortStoryTemplates:Array<String>, ?fullStoryTemplate:Dynamic, ?actionLinks:Array<String>):String
	{
		var oneLineStoryTemplatesEncoder:JSONEncoder = new JSONEncoder(oneLineStoryTemplates);
		var shortStoryTemplatesEncoder:JSONEncoder = new JSONEncoder((shortStoryTemplates == null)? new Array<String>() : shortStoryTemplates);
		var fullStoryTemplateEncoder:JSONEncoder = new JSONEncoder((fullStoryTemplate == null)? { } : fullStoryTemplate);
		var actionLinksEncoder:JSONEncoder = new JSONEncoder((actionLinks == null)? new Array<String>() : actionLinks);
		
		params.set("one_line_story_templates", oneLineStoryTemplatesEncoder.getString());
		params.set("short_story_templates", shortStoryTemplatesEncoder.getString());
		params.set("full_story_template", fullStoryTemplateEncoder.getString());
		params.set("action_links", actionLinksEncoder.getString());
		
		return hnf.callMethod("facebook.feed.registerTemplateBundle", params);
	}
	
	/**
	* Retrieves the full list of active template bundles registered by the
	* requesting application.
	*
	* @return array  An array of template bundles
	*/
	public function getRegisteredTemplateBundles():Dynamic
	{
		return hnf.callMethod("facebook.feed.getRegisteredTemplateBundles");
	}
	
	public function getRegisteredTemplateBundleByID(templateBundleId:String):Dynamic
	{
		params.set("template_bundle_id", templateBundleId);
		
		return hnf.callMethod("facebook.feed.getRegisteredTemplateBundleByID", params);
	}
	
	public function deactivateTemplateBundleByID(templateBundleId:String):Bool
	{
		params.set("template_bundle_id", templateBundleId);
		
		return hnf.callMethod("facebook.feed.deactivateTemplateBundleByID", params);
	}
	
	/**
	* Publishes a story on behalf of the user owning the session, using the
	* specified template bundle. This method requires an active session key in
	* order to be called.
	*
	* The parameters to this method ($templata_data in particular) are somewhat
	* involved.  It's recommended you visit the wiki for details:
	*
	*  http://wiki.developers.facebook.com/index.php/Feed.publishUserAction
	*
	* @param int $template_bundle_id  A template bundle id previously registered
	* @param array $template_data     See wiki article for syntax
	* @param array $target_ids        (Optional) An array of friend uids of the
	*                                 user who shared in this action.
	* @param string $body_general     (Optional) Additional markup that extends
	*                                 the body of a short story.
	* @param int $story_size          (Optional) A story size (see above)
	* @param string $user_message     (Optional) A user message for a short
	*                                 story.
	*
	* @return bool  true on success
	*/
	public function publishUserAction(templateBundleId:String, templateData:Dynamic, ?targetIds:Array<String>, ?bodyGeneral:String = "", ?storySize:Int = STORY_SIZE_ONE_LINE, ?userMessage:String = ""):Bool
	{
		
		if (Std.is(templateData, Array))
		{
			var templateDataEncoder:JSONEncoder;
			templateDataEncoder = new JSONEncoder(templateData);
			params.set("template_data", templateDataEncoder.getString());
		}
		
		if (targetIds != null)
		{
			var targetIdsEncoder:JSONEncoder;
			targetIdsEncoder = new JSONEncoder(targetIds);
			params.set("target_ids", StringTools.trim(targetIdsEncoder.getString()));
		}
		
		params.set("template_bundle_id", templateBundleId);
		params.set("body_general", bodyGeneral);
		params.set("story_size", storySize);
		params.set("user_message", userMessage);
		
		return hnf.callMethod("facebook.feed.publishUserAction", params);
	}
	
}