
import com.haxepunk.graphics.Emitter;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Ease;
import com.haxepunk.Entity;

class EmitController extends Entity
{
	private var _emitter:Emitter;

	public function new()
	{
		super(x, y);
		// var circle:Image = Image.createCircle(3);
        _emitter = new Emitter("graphics/particle.png", 4, 4);
        _emitter.newType("flood", [0]);
        _emitter.setMotion("flood",  		// name
		        	0, 				// angle
		        	20, 			// distance
		        	0.3, 				// duration
		        	20, 			// ? angle range
		        	-30, 			// ? distance range
		        	1, 				// ? Duration range
		        	Ease.quadOut	// ? Easing	
		        	);
        _emitter.setAlpha("flood", 20, 0.1);
        _emitter.setGravity("flood", 5, 1);
        // emitEnergy.render("thisOne", x,y);
        graphic = _emitter;
        layer = -1;
	}

	public function flood(x:Float, y:Float)
	{
		for (i in 0...100)
		{
			_emitter.emit("flood", x, y);
		}
	}


}
