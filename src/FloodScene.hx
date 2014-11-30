
import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import EmitController;

class FloodScene extends Scene
{
    private var time:Float;
    private var storyText:Text;
    private var story:String;
    private var storyIndex:Int;
    private var emitCtrl1:EmitController;
    private var emitCtrl2:EmitController;
    private var emitCtrl3:EmitController;
    private var scale:Float;

    public override function begin() {
        super.begin();

        time = 0.0;
        scale = HXP.screen.width / 640;
        var bg = new Image('graphics/hoover.png');
        bg.scale = scale;
        addGraphic(bg);

        emitCtrl1 = add(new EmitController());
        emitCtrl2 = add(new EmitController());
        emitCtrl3 = add(new EmitController());

        /*var jean = new Spritemap('graphics/man.png', 48, 56);*/
        //jean.scale = scale * 3;
        //jean.smooth = false;
        //jean.add("walking", [0,1,2,3],12);
        //jean.play("walking");
        //addGraphic(jean, 40 * scale, 320 * scale);

        storyText = new Text("", {color: 0xCFFFFFF});
        storyText.size = Std.int(16 * scale);
        storyText.scale = scale;
        addGraphic(storyText, 20 * scale, 20 * scale);
        
        
        story = "The Hoover dam is about to burst\n";
        story += "All of the world will now flood.\n";
        story += "                               \n";
        story += "To help Jason feed his family, help him\n";
        story += "to stack his cupboard with soup.\n";
        story += "          \n";
        story += "And fend of anyone who might steal some.\n";
        storyIndex = 0;
 
    }

    private function nextScene() {
        HXP.scene = new MainScene(); 
    }

    public override function update () {
        super.update();
        
        emitCtrl1.flood(313 * scale, 279 * scale);
        emitCtrl1.flood(272 * scale, 221 * scale);
        emitCtrl1.flood(392 * scale, 281 * scale);
        if (storyIndex < story.length) {
            storyText.text += story.charAt(storyIndex);
            storyIndex++;
        } else {
            time += HXP.elapsed;
        }

        if (time > 3) {
       }
        #if mobile
        Input.touchPoints(nextScene);
        #else
        if (Input.mousePressed ||
            Input.pressed(Key.ANY)) {
            nextScene();
        }
        #end
     }
}
