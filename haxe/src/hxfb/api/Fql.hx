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
 * FQL API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Fql 
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
	* Makes an FQL query.  This is a generalized way of accessing all the data
	* in the API, as an alternative to most of the other method calls.  More
	* info at http://wiki.developers.facebook.com/index.php/FQL
	*
	* @param string $query  the query to evaluate
	*
	* @return array  generalized array representing the results
	*/
	public function query(q:String):Dynamic
	{
		params.set("query", q);
		
		return hnf.callMethod("facebook.fql.query", params);
	}
	
	/**
	* Makes a set of FQL queries in parallel.  This method takes a dictionary
	* of FQL queries where the keys are names for the queries.  Results from
	* one query can be used within another query to fetch additional data.  More
	* info about FQL queries at http://wiki.developers.facebook.com/index.php/FQL
	*
	* @param string $queries  JSON-encoded dictionary of queries to evaluate
	*
	* @return array  generalized array representing the results
	*/
	public function multiQuery(queries:Array<String>):Dynamic
	{
		params.set("queries", queries);
		
		return hnf.callMethod("facebook.fql.multiQuery", params);
	}
	
}