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
			panLeftButton.buttonMode = true;
			addChild(panLeftButton);

			infoBox = new TextField();
			infoBox.background = true;
			infoBox.textColor = 0xffffff;
			infoBox.backgroundColor = 0x000000;
			infoBox.x = 10;
			infoBox.y = 10;
			infoBox.height = 20;
			infoBox.width = 300;
			addChild(infoBox);
		};


		/** Called by the player after the plugin has been created. **/
		public function initPlugin(player:IPlayer, config:PluginConfig):void {
			api = player;
			infoBox.text = (config && config.message) ? config.message : "";
			panLeftButton.addEventListener(MouseEvent.CLICK, panLeftClicked);
                        // Add pan handlers to show different colours.
		};


		/** If the player resizes itself, this gets called (including on setup). **/
		public function resize(wid:Number, hei:Number):void {
			panLeftButton.x = wid - 50;
		};


		private function panLeftClicked(event:MouseEvent):void {
		        api.pan(-100);
		        infoBox.text = "Pan left";
		};

		private function panRightClicked(event:MouseEvent):void {
			api.pan(100);
		};

		private function panStereoClicked(event:MouseEvent):void {
			api.pan(0);
		};


		private function timeHandler(event:MediaEvent):void {
			infoBox.text = Math.round(event.duration - event.position) + " seconds left";
		};


	}
}
