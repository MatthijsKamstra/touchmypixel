/**
 * ...
 * @author Tarwin Stroh-Spijer
 */

package touchmypixel.utils;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

class BitmapDataTools 
{

	public static function offset(input:BitmapData, offsetX:Int, offsetY:Int):BitmapData
	{		
		var output = input.clone();
		
		if (offsetX != 0) {
			output.scroll(offsetX, 0);
			if (offsetX > 0) {
				output.copyPixels(input, new Rectangle(output.width - offsetX, 0, offsetX, output.height), new Point(0, 0));
			}else {
				output.copyPixels(input, new Rectangle(0, 0, -offsetX, output.height), new Point(output.width + offsetX, 0));
			}
		}
		if (offsetY != 0) {
			input = output.clone();
			output.scroll(0, offsetY);
			if (offsetY > 0) {
				output.copyPixels(input, new Rectangle(0, offsetY, output.width, output.height - offsetY), new Point(0, 0));
			}else {
				output.copyPixels(input, new Rectangle(0, 0, output.width, -offsetY), new Point(0, output.height + offsetY));
			}
		}
		
		input.dispose();
		
		return output;
	}
}