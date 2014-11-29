
import com.haxepunk.Scene;
import com.haxepunk.HXP;
import Slot;

class MainScene extends Scene
{
    private var time:Float = 20;
    private var cupboard:Array<Slot>;
    private var scale:Float;
    private var xOff:Float;
    private var yOff:Float;

	public override function begin()
	{
        super.begin();
        scale = HXP.screen.width / 640;
        xOff = HXP.screen.width / 10;
        yOff = HXP.screen.height / 4;
        cupboard = [];
        newMap();
	}

    private function newMap() {
        //private var mapDef:Array<Array<Int>>;
        for (i in 0...4) {
            for (j in 0...10) {
                var filled = Std.int(Math.round(Math.random()));
                var newSlot = new Slot(j * xOff, i * yOff);
                if (filled == 0) {
                    newSlot.filled = false;
                } else {
                    newSlot.filled = true;
                }
                newSlot.height = Std.int(yOff);
                newSlot.width = Std.int(xOff);
                newSlot.scale = scale;
                add(newSlot);
                cupboard[i + j * i] = newSlot;
            }
        }
        //return mapDef;
    }


    public override function update () {
        super.update();
        time -= HXP.elapsed;
    }
}
