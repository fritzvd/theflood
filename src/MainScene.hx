
import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Sfx;
import Slot;

class MainScene extends Scene
{
#if !mobile
    private var time:Float = 20;
#else
    private var time:Float = 15;
#end
    private var doneTime:Float = 0;
    private var cupboard:Array<Slot>;
    private var scale:Float;
    private var xOff:Float;
    private var yOff:Float;
    private var timeText:Text;
    private var soupBar:Image;
    private var geethanks:Sfx;
    private var stack:Sfx;
    private var done:Bool;

    public var cansOfSoup:Int = 0;

	public override function begin()
	{
        done = cast(HXP.engine, Main).done;
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

        var outerSoupBar = Image.createRect(Std.int(106 * scale ), Std.int(scale * 26), 0xDDDDDD);
        soupBar = Image.createRect(Std.int(100 * scale), Std.int(20 * scale), 0xc34528);
        addGraphic(outerSoupBar, 10 * scale, 10 * scale);
        addGraphic(soupBar, 13 * scale, 13 * scale);
 
        geethanks = new Sfx("audio/geethanks.wav");
        stack = new Sfx("audio/stack.wav");
	}

    public function fillOrEmpty(fill) {
        if (fill) {
            stack.play();
            cansOfSoup += 1;
        } else {
            cansOfSoup -= 1;
        }
    }

    private function newMap() {
        for (i in 0...4) {
            for (j in 0...10) {
                var count = (i == 0) ? i : i * 10;
                count += j;
                // make randomized map with a 0.3 bias to empty slots
                var filled = Std.int(Math.abs(Math.round(Math.random() - 0.3)));
                var newSlot = new Slot(j * xOff, i * yOff);
                cupboard[count] = newSlot;
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
            }
        }
    }

    private function shouldSteal() {
        // decide which one to steal
        var selector = Math.floor(Math.random() * 40);
        if (Math.random() > 0.98) {
            steal(selector);
        }
    }

    private function steal(selector:Int) {
        var slot = cast(cupboard[selector], Slot);
        if (slot.filled) {
            fillOrEmpty(false);
            slot.filled = false;
            geethanks.play();
        }
    }

    public override function update () {
        super.update();

        shouldSteal();

        soupBar.scaledWidth = Std.int(cansOfSoup / 40 * 100 * scale);
        if (time > 0) {
            time -= HXP.elapsed;
        } else {
            time = 0;
        }
        timeText.text = Std.string(Math.round(time * 100) / 100.0);
        if (time <= 0 && !done) {
            doneTime += HXP.elapsed;
            if (cansOfSoup == 40) {

                done = true;
                var wonText = new Text("Well Done", {color: 0xCFFFFFF});
                wonText.size = Std.int(40 * scale);
                wonText.scale = scale;
                addGraphic(wonText, HXP.screen.width / 2 - 200 * scale, HXP.screen.height / 2);
                var jean = new Spritemap('graphics/man.png', 48, 56);
                jean.scale = scale * 3;
                jean.smooth = false;
                jean.add("walking", [0,1,2,3],12);
                jean.play("walking");
                addGraphic(jean, 340 * scale, 320 * scale);



            } else {
                done = true;
                var wonText = new Text(":( Next time come prepared", {color: 0xCFFFFFF});
                wonText.size = Std.int(40 * scale);
                wonText.scale = scale;
                addGraphic(wonText, 20 * scale, HXP.screen.height / 2);
            }
            if (doneTime > 3) {
                HXP.scene = new IntroScene();
            }
        }
    }
}
