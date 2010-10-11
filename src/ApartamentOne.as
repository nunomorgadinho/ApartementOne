package {
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	import org.papervision3d.cameras.FreeCamera3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.MaterialsList;
	import org.papervision3d.objects.Cube;
	import org.papervision3d.scenes.Scene3D;
	
	import utils.Settings;
  	
	[SWF(backgroundColor = "0x000000", frameRate="120")]
	
	public class ApartamentOne extends Sprite
	{
		static public var SCREEN_WIDTH  :int = 1024;
		static public var SCREEN_HEIGHT :int = 768;

		private var container :Sprite;
		private var scene     :Scene3D;
		private var camera    :FreeCamera3D;
		private var cube      :Cube;
		private var doForward:Boolean = false;
		private var doBackward:Boolean = false;
		private var doLeft:Boolean = false;
		private var doRight:Boolean = false;
		private var loader:BulkLoader;
		private var loaderText:TextField;
		private var loaderSprite:Sprite = new Sprite();
		
		public function ApartamentOne()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
	
			Settings.getInstance().loadSettings("apartament_config.xml");
			Settings.getInstance().addEventListener(Settings.INIT, onSettingsInit, false, 0, true);
		}
		
		/*
			Private
		*/
		private function onSettingsInit(e:Event):void
		{
			init3D();
			
			stage.quality = StageQuality.LOW;
	
			this.addEventListener( Event.ENTER_FRAME, loop );
			
			//Listen to the keyboard events
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function init3D():void
		{
			// add the pre loader sprite before the container
			addChild(loaderSprite);
			
			// Create container sprite and center it in the stage
			container = new Sprite();
			addChild( container );
			container.x = SCREEN_WIDTH  /2 ;
			container.y = SCREEN_HEIGHT /2 ;
			
			// Create scene
			scene = new Scene3D( container );
	
			// Create camera
			camera = new FreeCamera3D();
			camera.zoom = 1;
			camera.focus = 1000;
			//camera.x = 1000;
			camera.z = 100;
			//camera.y = 1000;
			
			// creates a BulkLoader instance with a name of "main-site", that can be used to retrieve items without having a reference to this instance
			loader = new BulkLoader("main-site");

			loader.add( (Settings.getInstance().data.back.@path).toString(), {type:"image", id: "back"});
			loader.add( (Settings.getInstance().data.front.@path).toString(), {type:"image", id: "front"});
			loader.add( (Settings.getInstance().data.right.@path).toString(), {type:"image", id: "right"});
			loader.add( (Settings.getInstance().data.left.@path).toString(), {type:"image", id: "left"});
			loader.add( (Settings.getInstance().data.top.@path).toString(), {type:"image", id: "top"});
			loader.add( (Settings.getInstance().data.down.@path).toString(), {type:"image", id: "down"});

			loader.addEventListener(BulkProgressEvent.PROGRESS, onLoaderProgress);	
			loader.addEventListener(BulkProgressEvent.COMPLETE, onAllLoaded);	
		
			loaderText = new TextField();
			loaderText.textColor = 0xFFFFFF;
			loaderText.text = "Loading..";
			
			loaderSprite.addChild(loaderText);
			
			
			loaderSprite.x = 200;
			loaderSprite.y = 200;
			
			// place the text 20 above the loading bar..
			loaderText.y = -20;
			
			loader.start();
		}

		private function onLoaderProgress(evt:BulkProgressEvent):void
		{
			var percent:Number = evt._percentLoaded;

			loaderSprite.graphics.beginFill(0xFFFFFF);
			loaderSprite.graphics.drawRect(0, 0, stage.stageWidth/6 * percent, 20);
			loaderSprite.graphics.endFill();
		}
		
		private function onAllLoaded(evt:Event):void
		{						
			createCube();
		}
		
		private function createCube():void
		{
			// Attributes
			//var size :Number = 5000;
			var quality :Number = 24;
					
			var b_bitmap:Bitmap = loader.getBitmap("back");
			var f_bitmap:Bitmap = loader.getBitmap("front");
			var r_bitmap:Bitmap = loader.getBitmap("right");
			var l_bitmap:Bitmap = loader.getBitmap("left");
			var t_bitmap:Bitmap = loader.getBitmap("top");
			var d_bitmap:Bitmap = loader.getBitmap("down");

			var b:BitmapMaterial = new BitmapMaterial( b_bitmap.bitmapData );
			var f:BitmapMaterial = new BitmapMaterial( f_bitmap.bitmapData );
			var r:BitmapMaterial = new BitmapMaterial( r_bitmap.bitmapData );
			var l:BitmapMaterial = new BitmapMaterial( l_bitmap.bitmapData );
			var t:BitmapMaterial = new BitmapMaterial( t_bitmap.bitmapData );
			var d:BitmapMaterial = new BitmapMaterial( d_bitmap.bitmapData );

			b.smooth = true;
			f.smooth = true;
			r.smooth = true;
			l.smooth = true;
			t.smooth = true;
			d.smooth = true;
			
			b.oneSide = true;
			f.oneSide = true;
			r.oneSide = true;
			l.oneSide = true;
			t.oneSide = true;
			d.oneSide = true;
					
			var materials:MaterialsList = new MaterialsList(
			{
				//all:
				front: f,
				back:  b,
				right: r,
				left:  l,
				top:   t,
				bottom: d
			} );
			
		
		
			// Cube face settings
			// You can add or sustract faces to your selection. For examples: Cube.FRONT+Cube.BACK or Cube.ALL-Cube.Top.
	
			// On single sided materials, all faces will be visible from the inside.
			var insideFaces  :int = Cube.ALL;
	
			// Front and back cube faces will not be created.
			var excludeFaces :int = Cube.NONE;
	
			// Create the cube.
			cube = new Cube( materials, 5000, 5000, 5000, quality, quality, quality, insideFaces, excludeFaces );
			
			scene.addChild( cube, "Cube" );
		}

		private function loop(event:Event):void
		{
			update3D();
		}

		private function update3D():void
		{
			//keyboard
			if(doForward){
				camera.moveForward(30);
			}
			if(doBackward){
				camera.moveBackward(30);
			}
			if(doLeft){
				//camera.moveDown(10);
			}
			if(doRight){
				//camera.moveUp(10);
			}
			
			
			// Pan
			var pan:Number = camera.rotationY - 210 * container.mouseX/(stage.stageWidth/2);
			pan = Math.max( -100, Math.min( pan, 100 ) ); // Max speed
			camera.rotationY -= pan / 12;
	
			// Tilt
			var tilt:Number = 90 * container.mouseY/(stage.stageHeight/2);
			camera.rotationX -= (camera.rotationX + tilt) / 12;
	
			// Render
			scene.renderCamera( this.camera );
		}
		
		/**
		 * onKeyDown
		 * 
		 * Handles the key events from the stage
		 */
		private function onKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode){
				case Keyboard.UP:
					doForward = true;	
				break;
				case Keyboard.DOWN:
					doBackward = true;
				break;
				case Keyboard.LEFT:
					doLeft = true;
				break;
				case Keyboard.RIGHT:
					doRight = true;
				break;
			}
		}
		
		/**
		 * onKeyUp
		 * 
		 * Handles the key events from the stage
		 */
		private function onKeyUp(event:KeyboardEvent):void
		{
			switch(event.keyCode){
				case Keyboard.UP:
					doForward = false;	
				break;
				case Keyboard.DOWN:
					doBackward = false;
				break;
				case Keyboard.LEFT:
					doLeft = false;
				break;
				case Keyboard.RIGHT:
					doRight = false;
				break;
			}
		}
		
	}
}
