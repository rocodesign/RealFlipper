package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import ro.roco.geom.Line;
	
	public class RealFlipper extends Sprite
	{
		
		private var pr:ParticleRenderer;
		private var screen:BitmapData;
		private var screenHolder:Bitmap;
		private var helperDrawing:MovieClip;
		public function RealFlipper()
		{
			screen = new BitmapData(400,400,false,0xEEEEEE);
			pr = new ParticleRenderer(screen);
			screenHolder = new Bitmap(screen);
			screenHolder.smoothing = true;
			addChild(screenHolder);
			helperDrawing = new MovieClip();
			addChild(helperDrawing);
			init();
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
			addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
		}
		
		private function init():void {
			for (var i:int = 0; i < 100; i++) {
				var p:Particle = new Particle();
				p.x = i%10*20+100;
				p.y = Math.floor(i/10)*20+100;
				p.z = 0;
				pr.addParticle(p);
			}
			helperDrawing.addChild(new Sprite());
			(helperDrawing.getChildAt(0) as Sprite).graphics.beginFill(0x00FF00,0.3);
			(helperDrawing.getChildAt(0) as Sprite).graphics.drawRect(0,0,400,400);
		}
		
		private var folds:Array = [];
		
		private var drawLines:Boolean = true;
		private function mouseDownHandler(ev:MouseEvent):void {
			drawLines = true;
		}
		
		private function mouseUpHandler(ev:MouseEvent):void {
			drawLines = false;
		}
		
		private function enterFrameHandler(ev:Event):void {
			pr.render();
			if (drawLines) {
				var p1:Point = new Point(200,0);
				var p2:Point = new Point(mouseX,mouseY);
				var line:Line = Line.define2P(p1,p2);
				helperDrawing.graphics.clear();
				helperDrawing.graphics.lineStyle(1,0xFF0000);
				helperDrawing.graphics.moveTo(p1.x,p1.y);
				helperDrawing.graphics.lineTo(p2.x,p2.y);
				helperDrawing.graphics.lineStyle(1,0x00FF00);
				for (var i:int = 0; i < pr.particles.length; i++) {
					var p:Particle = pr.particles[i];
					var ptp:Point = new Point(p.x,p.y);
					var pt:Point = line.distanceTo(ptp);
					var dist:Number = Point.distance(pt,ptp);
					if (dist < 50) {
						var newpt:Point = Point.interpolate(pt,ptp,(50-dist)/50);
						p.x = newpt.x;
						p.y = newpt.y;
					}
					//helperDrawing.graphics.moveTo(p.x,p.y);
					//helperDrawing.graphics.lineTo(pt.x,pt.y);
				}
			}
		}
		
		
	}
}