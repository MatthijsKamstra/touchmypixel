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
 * Intl API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Intl 
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
	* Gets the best translations for native strings submitted by an application
	* for translation. If $locale is not specified, only native strings and their
	* descriptions are returned. If $all is true, then unapproved translations
	* are returned as well, otherwise only approved translations are returned.
	*
	* A mapping of locale codes -> language names is available at
	* http://wiki.developers.facebook.com/index.php/Facebook_Locales
	*
	* @param string $locale the locale to get translations for, or 'all' for all
	*                       locales, or 'en_US' for native strings
	* @param bool   $all    whether to return all or only approved translations
	*
	* @return array (locale, array(native_strings, array('best translation
	*                available given enough votes or manual approval', approval
	*                                                                  status)))
	* @error API_EC_PARAM
	* @error API_EC_PARAM_BAD_LOCALE
	*/
	public function getTranslations(?locale:String = "en_US", ?all:Bool = false):Dynamic
	{
		params.set("locale", locale);
		params.set("all", all);
		
		hnf.callMethod("facebook.intl.getTransaltions", params);
	}
	
	/**
	* Lets you insert text strings in their native language into the Facebook
	* Translations database so they can be translated.
	*
	* @param array $native_strings  An array of maps, where each map has a 'text'
	*                               field and a 'description' field.
	*
	* @return int  Number of strings uploaded.
	*/
	public function uploadNativeStrings(nativeStrings:Array<Hash<String>> ):Int
	{
		var nativeStringsEncoder:JSONEncoder = new JSONEncoder(nativeStrings);
		params.set("native_strings", nativeStringsEncoder.getString());
		
		return hnf.callMethod("facebook.intl.uploadNativeStrings", params);
	}
	
}