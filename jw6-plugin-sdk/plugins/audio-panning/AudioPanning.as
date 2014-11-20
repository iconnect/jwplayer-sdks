package {
	import com.longtailvideo.jwplayer.events.*;
	import com.longtailvideo.jwplayer.player.*;
	import com.longtailvideo.jwplayer.plugins.*;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/** An example plugin that tests various player integrations. **/
	public class AudioPanning extends Sprite implements IPlugin6 {

		[Embed(source="pan_left.png")]
		private const PanLeftIcon:Class;

		[Embed(source="pan_right.png")]
		private const PanRightIcon:Class;

		[Embed(source="pan_stereo.png")]
		private const PanStereoIcon:Class;

		private var api:IPlayer;
		private var field:TextField;
		private var infoBox:TextField;
		private var panLeftButton:Sprite;
		private var panStereoButton:Sprite;
		private var panRightButton:Sprite;
		private var playerWidth:Number;
		private var playerHeight:Number;


		/** Let the player know what the name of your plugin is. **/
		public function get id():String {
			return "audiopanning";
		};

		public function get target():String {
			return "6.0";
		}


		/** Constructor **/
		public function AudioPanning() {
			panLeftButton = new Sprite();
			panLeftButton.addChild(new PanLeftIcon());
			panLeftButton.y = 10;
			panLeftButton.x = 10;
			panLeftButton.buttonMode = true;
			panLeftButton.height = 20;
			panLeftButton.width = 20;
			addChild(panLeftButton);

			panStereoButton = new Sprite();
			panStereoButton.addChild(new PanStereoIcon());
			panStereoButton.x = 30;
			panStereoButton.y = 10;
			panStereoButton.buttonMode = true;
			panStereoButton.height = 20;
			panStereoButton.width = 20;
			addChild(panStereoButton);

			panRightButton = new Sprite();
			panRightButton.addChild(new PanRightIcon());
			panRightButton.x = 50;
			panRightButton.y = 10;
			panRightButton.buttonMode = true;
			panRightButton.height = 20;
			panRightButton.width = 20;
			addChild(panRightButton);

			infoBox = new TextField();
			infoBox.background = false;
			infoBox.textColor = 0x0000ff;
			infoBox.x = 300;
			infoBox.y = 10;
			infoBox.height = 20;
			infoBox.width = 300;
			addChild(infoBox);
		};


                private function setPanningVisible(status:Boolean):void {
			panLeftButton.visible = status;
			panStereoButton.visible = status;
			panRightButton.visible = status;
                }


		/** Called by the player after the plugin has been created. **/
		public function initPlugin(player:IPlayer, config:PluginConfig):void {
			api = player;
                        api.controls.display.addEventListener(MouseEvent.MOUSE_OUT, hidePanButtons);
                        api.controls.display.addEventListener(MouseEvent.MOUSE_OVER, showPanButtons);
			panLeftButton.addEventListener(MouseEvent.CLICK, panLeftClicked);
			panLeftButton.addEventListener(MouseEvent.MOUSE_OVER, showPanButtons);
			panStereoButton.addEventListener(MouseEvent.CLICK, panStereoClicked);
			panStereoButton.addEventListener(MouseEvent.MOUSE_OVER, showPanButtons);
			panRightButton.addEventListener(MouseEvent.CLICK, panRightClicked);
			panRightButton.addEventListener(MouseEvent.MOUSE_OVER, showPanButtons);
                        // Add pan handlers to show enabled/disabled
		};


		/** If the player resizes itself, this gets called (including on setup). **/
		public function resize(wid:Number, hei:Number):void {
                  this.playerWidth = wid;
                  this.playerHeight = hei;
		};


		private function panLeftClicked(event:MouseEvent):void {
		        api.pan(-100);
		};

		private function panRightClicked(event:MouseEvent):void {
			api.pan(100);
		};

		private function panStereoClicked(event:MouseEvent):void {
			api.pan(0);
		};

		private function hidePanButtons(event:MouseEvent):void {
		        setPanningVisible(false);
		};

		private function showPanButtons(event:MouseEvent):void {
		        setPanningVisible(true);
		};


		private function timeHandler(event:MediaEvent):void {
		};


	}
}
