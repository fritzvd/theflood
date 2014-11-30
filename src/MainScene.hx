
import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Image;
import Slot;

class MainScene extends Scene
{
    private var time:Float = 20;
    private var cupboard:Array<Slot>;
    private var scale:Float;
    private var xOff:Float;
    private var yOff:Float;
    private var timeText:Text;
    private var soupBar:Image;

    public var cansOfSoup:Int = 0;

	public override function begin()
	{
        super.begin();
        scale = HXP.screen.width / 640;
        xOff = HXP.screen.width / 10;
        yOff = HXP.screen.height / 4;
        cupboard = [];
        newMap();
        timeText = new Text("", {color: 0xCFFFFFF});
        timeText.size = Std.int(16 * scale);
        timeText.scale = scale;
        timeText.text = Std.string(time);
        addGraphic(timeText, HXP.screen.width / 2 - 8 * scale, 20 * scale);

        var outerSoupBar = Image.createRect(106, 26, 0xDDDDDD);
        soupBar = Image.createRect(100, 20, 0xc34528);
        addGraphic(outerSoupBar, 10 * scale, 10 * scale);
        addGraphic(soupBar, 13 * scale, 13 * scale);
 
	}

    public function fillOrEmpty(fill) {
        if (fill) {
            cansOfSoup += 1;
        } else {
            cansOfSoup -= 1;
        }
    }

    private function newMap() {
        for (i in 0...4) {
            for (j in 0...10) {
                var filled = Std.int(Math.round(Math.random()));
                var newSlot = new Slot(j * xOff, i * yOff);
                if (filled == 0) {
                    newSlot.filled = false;
                } else {
                    newSlot.filled = true;
                    cansOfSoup += 1;
                }
                newSlot.height = Std.int(yOff);
                newSlot.width = Std.int(xOff);
                newSlot.scale = scale;
                add(newSlot);
                cupboard[i + j * i] = newSlot;
            }
        }
    }


    public override function update () {
        super.update();
        soupBar.scaledWidth = Std.int(cansOfSoup / 40 * 100 * scale);
        time -= HXP.elapsed;
        timeText.text = Std.string(Math.round(time * 100) / 100.0);
        if (time < 0) {
            if (cansOfSoup == 40) {
                trace('hoozaaah');
            } else {
                trace(':(');
            }
        }
    }
}
