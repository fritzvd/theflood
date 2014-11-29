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
    }

    private function handleTouch(touch:Touch) {
        var touchEntity = new Entity(touch.x, touch.y);
        if (this.collideWith(touchEntity, this.x, this.y) == touchEntity) {
            this.filled = !this.filled;
        }
    }



    public override function update() {
        super.update();

        Input.touchPoints(handleTouch);
        
        if (filled) {
            this.graphic = full;
        } else {
            this.graphic = empty;
        }
    }
}
