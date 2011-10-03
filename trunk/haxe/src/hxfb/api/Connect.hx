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
 * Connect API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;

class Connect 
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
	  * Returns the number of unconnected friends that exist in this application.
	  * This number is determined based on the accounts registered through
	  * connect.registerUsers() (see below).
	  */
	public function getUnconnectedFriendsCount():Int
	{
		return hnf.callMethod("facebook.connect.getUnconnectedFriendsCount");
	}
	
	/**
	  * This method is used to create an association between an external user
	  * account and a Facebook user account, as per Facebook Connect.
	  *
	  * This method takes an array of account data, including a required email_hash
	  * and optional account data. For each connected account, if the user exists,
	  * the information is added to the set of the user's connected accounts.
	  * If the user has already authorized the site, the connected account is added
	  * in the confirmed state. If the user has not yet authorized the site, the
	  * connected account is added in the pending state.
	  *
	  * This is designed to help Facebook Connect recognize when two Facebook
	  * friends are both members of a external site, but perhaps are not aware of
	  * it.  The Connect dialog (see fb:connect-form) is used when friends can be
	  * identified through these email hashes. See the following url for details:
	  *
	  *   http://wiki.developers.facebook.com/index.php/Connect.registerUsers
	  *
	  * @param mixed $accounts A (JSON-encoded) array of arrays, where each array
	  *                        has three properties:
	  *                        'email_hash'  (req) - public email hash of account
	  *                        'account_id'  (opt) - remote account id;
	  *                        'account_url' (opt) - url to remote account;
	  *
	  * @return array  The list of email hashes for the successfully registered
	  *                accounts.
	  */
	public function registerUsers(accounts:Array<String>):Dynamic
	{
		params.set("accounts", accounts);
		return hnf.callMethod("facebook.connect.registerUsers", params);
	}
	
	/**
	  * Unregisters a set of accounts registered using connect.registerUsers.
	  *
	  * @param array $email_hashes  The (JSON-encoded) list of email hashes to be
	  *                             unregistered.
	  *
	  * @return array  The list of email hashes which have been successfully
	  *                unregistered.
	  */	
	public function unregisterUsers(emails:Array<String>):Dynamic
	{
		params.set("email_hashes", emails);
		return hnf.callMethod("facebook.connect.unregisterUsers", params);
	}
	
}