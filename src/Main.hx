import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.RenderMode;

class Main extends Engine
{
    public var done:Bool = false;

	override public function init()
	{
#if debug
		HXP.console.enable();
#end
		HXP.scene = new IntroScene();
	}

	public static function main() { new Main(); }

    override public function new(width:Int=0, height:Int=0, frameRate:Float=60, fixed:Bool=false, ?renderMode:RenderMode) {
        super(640, 480, frameRate, fixed, renderMode);
    }

}
