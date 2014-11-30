import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;

class Slot extends Entity
{
    public var filled:Bool;
    public var scale:Float;

    private var empty:Image;
    private var full:Image;
    private var main:MainScene;
    
    public function new (x, y) {
        super(x, y);
        empty = new Image('graphics/empty.png');
        full = new Image('graphics/full.png');

        filled = false;
        this.graphic = empty;
    }

    public override function added () {
        super.added();
        empty.scale = scale;
        full.scale = scale;
        main = cast(this.scene, MainScene);
    }

    #if mobile
    private function handleTouch(touch:Touch) {
        var touchEntity = new Entity(touch.x, touch.y);
        if (this.collideWith(touchEntity, this.x, this.y) == touchEntity &&
            touch.pressed) {
            this.filled = !this.filled;
            main.fillOrEmpty(this.filled);
        }
    }
    #end

    #if !mobile
    private function handleMouse () {
        var mouseEntity = new Entity(Input.mouseX, Input.mouseY);
        if (this.collideWith(mouseEntity, this.x, this.y) == mouseEntity) {
            this.filled = !this.filled;
            main.fillOrEmpty(this.filled);
        }
    }
    #end

    public override function update() {
        super.update();

    #if mobile
        Input.touchPoints(handleTouch);
    #else
        if (Input.mousePressed) {
            handleMouse();
        }
    #end
        if (filled) {
            this.graphic = full;
        } else {
            this.graphic = empty;
        }
    }
}
