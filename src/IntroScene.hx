
import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class IntroScene extends Scene
{
    private var time:Float;
    private var storyText:Text;
    private var story:String;
    private var storyIndex:Int;

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

        storyText = new Text("", {color: 0xCFFFFFF});
        storyText.size = Std.int(16 * scale);
        storyText.scale = scale;
        addGraphic(storyText, 20 * scale, 20 * scale);
        
        
        story = "As Jason looked at the sunrise,\n";
        story += "he felt at peace.\n";
        story += "He saw himself, and where he was at in his life.\n";
        story += "For the first time in a long while, he could truly\n";
        story += "say that he was happy.\n \n\n\n\n";
        story += "But all that was about to change...";
        storyIndex = 0;
 
    }

    private function nextScene() {
        HXP.scene = new FloodScene(); 
    }

#if mobile
    private function handleTouch(touch:com.haxepunk.utils.Touch) {
        nextScene();
    }
#end
    
    public override function update () {
        super.update();
        
        if (storyIndex < story.length) {
            storyText.text += story.charAt(storyIndex);
            storyIndex++;
        } else {
            time += HXP.elapsed;
        }

        if (time > 3) {
            nextScene();
        }
        #if mobile
        Input.touchPoints(handleTouch);
        #else
        if (Input.mousePressed ||
            Input.pressed(Key.ANY)) {
            nextScene();
        }
        #end
     }
}
