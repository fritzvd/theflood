
import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Spritemap;

class IntroScene extends Scene
{
    private var time:Float;

    public override function begin() {
        super.begin();

        time = 0.0;
        var scale = HXP.screen.width / 640;
        var bg = new Image('graphics/sunsetbg.png');
        bg.scale = scale;
        addGraphic(bg);

        var jean = new Spritemap('graphics/man.png', 48, 56);
        jean.scale = scale * 3;
        jean.smooth = false;
        jean.add("walking", [0,1,2,3],12);
        jean.play("walking");
        addGraphic(jean, 40 * scale, 320 * scale);

        var kombatText:Text = new Text("iasdfsdaf", {color: 0xCFFFFFF});
        kombatText.size = Std.int(16 * scale);
        kombatText.scale = scale;
        addGraphic(kombatText, 400 * scale, 120 * scale);

 
    }

    public override function update () {
        super.update();
        time += HXP.elapsed;
        if (time > 3) {
            HXP.scene = new MainScene(); 
/*            #if mobile*/
            //Input.touchPoints(handleTouch);
            //#else
            //if (Input.mousePressed ||
                //Input.pressed(Key.ANY) {
                //handleMouse();
            //}
            /*#end*/
        }
     }
}
