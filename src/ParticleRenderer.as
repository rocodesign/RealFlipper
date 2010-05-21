package
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class ParticleRenderer
	{
		public var particles:Array = [];
		
		private var screen:BitmapData;
		public function ParticleRenderer(screen:BitmapData) {
			this.screen = screen;	
			var matrix:Array = new Array();
			matrix=matrix.concat([1,0,0,0,+50]);// red
			matrix=matrix.concat([0,1,0,0,+50]);// green
			matrix=matrix.concat([0,0,1,0,+50]);// blue
			matrix=matrix.concat([0,0,0,1,0]);// alpha
			filter = new ColorMatrixFilter(matrix);
		}
		
		public function addParticle(p:Particle):void {
			particles.push(p);
		}
		
		//private var filter:BlurFilter=new BlurFilter(8,8,1);
		private var filter:ColorMatrixFilter;
		public function render():void {
		
			screen.applyFilter(screen,screen.rect,new Point(0,0),filter);
			for (var i:int = 0; i < particles.length; i++) {
				var p:Particle = particles[i];
				
				
				//screen.fillRect(screen.rect,0xFFFFFF);
				screen.setPixel(p.x,p.y,0);
			}
		}
	}
}