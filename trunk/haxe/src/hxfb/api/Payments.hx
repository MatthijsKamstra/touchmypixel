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
 * Payments API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONDecoder;
import hxjson2.JSONEncoder;

class Payments 
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
	* Set Payments properties for an app.
	*
	* @param  properties  a map from property names to  values
	* @return             true on success
	*/
	public function setProperties(properties:Hash<Dynamic>):Bool
	{
		var propertiesEncoder:JSONEncoder = new JSONEncoder(properties);
		params.set("properties", propertiesEncoder.getString());
		
		return hnf.callMethod("facebook.payments.setProperties", params);
	}
	
	public function getOrderDetails(orderId:Int):Dynamic
	{
		params.set("order_id", orderId);
		var results:Dynamic = hnf.callMethod("facebook.payments.getOrderDetails", params);
		
		var orderDetailsDecode:JSONDecoder = new JSONDecoder(results, true);
		return orderDetailsDecode.getValue();
	}
	
	public function updateOrder(orderId:Int, status:Bool, orderParams:Dynamic):Dynamic
	{
		var orderParamsEncoder:JSONEncoder = new JSONEncoder(orderParams);
		
		params.set("order_id", orderId);
		params.set("status", status);
		params.set("params", orderParamsEncoder.getString());
		
		return hnf.callMethod("facebook.payments.updateOrder", params);
	}
	
	public function getOrders(status:Bool, startTime:Int, endTime:Int, ?testMode:Bool = false):Dynamic
	{
		params.set("status", status);
		params.set("start_time", startTime);
		params.set("end_time", endTime);
		params.set("test_mode", testMode);
		
		var results:Dynamic = hnf.callMethod("facebook.payments.getOrders", params);
		
		var ordersDecode:JSONDecoder = new JSONDecoder(results, true);
		return ordersDecode.getValue();
	}
	
}