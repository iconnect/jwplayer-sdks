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

		[Embed(source="left-inactive.png")]
		private const PanLeftIcon:Class;

		[Embed(source="left-active.png")]
		private const PanLeftSelectedIcon:Class;

		[Embed(source="right-inactive.png")]
		private const PanRightIcon:Class;

		[Embed(source="right-active.png")]
		private const PanRightSelectedIcon:Class;

		[Embed(source="stereo-inactive.png")]
		private const PanStereoIcon:Class;

		[Embed(source="stereo-active.png")]
		private const PanStereoSelectedIcon:Class;

		private var api:IPlayer;
		private var field:TextField;
		private var infoBox:TextField;
		private var panLeftBtn:Sprite;
		private var panStereoBtn:Sprite;
		private var panRightBtn:Sprite;
		private var playerWidth:Number;
		private var playerHeight:Number;

                /* Icons */
                private var panLeftIcon:DisplayObject;
                private var panLeftSelectedIcon:DisplayObject;
                private var panStereoIcon:DisplayObject;
                private var panStereoSelectedIcon:DisplayObject;
                private var panRightIcon:DisplayObject;
                private var panRightSelectedIcon:DisplayObject;


		/** Let the player know what the name of your plugin is. **/
		public function get id():String {
			return "audiopanning";
		};

		public function get target():String {
			return "6.0";
		}


		/** Constructor **/
		public function AudioPanning() {

                        panLeftIcon = new PanLeftIcon();
                        panLeftSelectedIcon = new PanLeftSelectedIcon();
			panLeftBtn = new Sprite();
			panLeftBtn.addChild(panLeftIcon);
			panLeftBtn.y = 10;
			panLeftBtn.x = 10;
			panLeftBtn.buttonMode = true;
			panLeftBtn.height = 25;
			panLeftBtn.width = 25;
			addChild(panLeftBtn);

                        panStereoIcon = new PanStereoIcon();
                        panStereoSelectedIcon = new PanStereoSelectedIcon();
			panStereoBtn = new Sprite();
			panStereoBtn.addChild(panStereoIcon);
			panStereoBtn.x = 35;
			panStereoBtn.y = 10;
			panStereoBtn.buttonMode = true;
			panStereoBtn.height = 25;
			panStereoBtn.width = 25;
			addChild(panStereoBtn);

                        panRightIcon = new PanRightIcon();
                        panRightSelectedIcon = new PanRightSelectedIcon();
			panRightBtn = new Sprite();
			panRightBtn.addChild(panRightIcon);
			panRightBtn.x = 60;
			panRightBtn.y = 10;
			panRightBtn.buttonMode = true;
			panRightBtn.height = 25;
			panRightBtn.width = 25;
			addChild(panRightBtn);

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
			panLeftBtn.visible = status;
			panStereoBtn.visible = status;
			panRightBtn.visible = status;
                }


		/** Called by the player after the plugin has been created. **/
		public function initPlugin(player:IPlayer, config:PluginConfig):void {
			api = player;
                        api.controls.display.addEventListener(MouseEvent.MOUSE_OUT, hidePanButtons);
                        api.controls.display.addEventListener(MouseEvent.MOUSE_OVER, showPanButtons);
                        api.addEventListener(MediaEvent.JWPLAYER_MEDIA_PAN, highlightButtons);
			panLeftBtn.addEventListener(MouseEvent.CLICK, panLeftClicked);
			panLeftBtn.addEventListener(MouseEvent.MOUSE_OVER, showPanButtons);
			panStereoBtn.addEventListener(MouseEvent.CLICK, panStereoClicked);
			panStereoBtn.addEventListener(MouseEvent.MOUSE_OVER, showPanButtons);
			panRightBtn.addEventListener(MouseEvent.CLICK, panRightClicked);
			panRightBtn.addEventListener(MouseEvent.MOUSE_OVER, showPanButtons);
                        // By default, stereo must be active
                        this.clickStereoIcon();
		};


		/** If the player resizes itself, this gets called (including on setup). **/
		public function resize(wid:Number, hei:Number):void {
                  this.playerWidth = wid;
                  this.playerHeight = hei;
		};


                private function clickLeftIcon():void {
			panLeftBtn.removeChildAt(0);
			panLeftBtn.addChild(panLeftSelectedIcon);
                }

                private function unClickLeftIcon():void {
			panLeftBtn.removeChildAt(0);
			panLeftBtn.addChild(panLeftIcon);
                }

                private function clickStereoIcon():void {
			panStereoBtn.removeChildAt(0);
			panStereoBtn.addChild(panStereoSelectedIcon);
                }

                private function unClickStereoIcon():void {
			panStereoBtn.removeChildAt(0);
			panStereoBtn.addChild(panStereoIcon);
                }

                private function clickRightIcon():void {
			panRightBtn.removeChildAt(0);
			panRightBtn.addChild(panRightSelectedIcon);
                }

                private function unClickRightIcon():void {
			panRightBtn.removeChildAt(0);
			panRightBtn.addChild(panRightIcon);
                }

		private function panLeftClicked(event:MouseEvent):void {
		        api.pan(-100);
                        clickLeftIcon();
                        unClickRightIcon();
                        unClickStereoIcon();
		};

		private function panRightClicked(event:MouseEvent):void {
			api.pan(100);
                        clickRightIcon();
                        unClickLeftIcon();
                        unClickStereoIcon();
		};

		private function panStereoClicked(event:MouseEvent):void {
			api.pan(0);
                        clickStereoIcon();
                        unClickRightIcon();
                        unClickLeftIcon();
		};

		private function hidePanButtons(event:MouseEvent):void {
		        setPanningVisible(false);
		};

		private function showPanButtons(event:MouseEvent):void {
		        setPanningVisible(true);
		};

		private function highlightButtons(event:MediaEvent):void {
                        if (event.pan == -100) {
                            this.panLeftClicked(null);
                            return;
                        }
                        if (event.pan == 100) {
                            this.panRightClicked(null);
                            return;
                        }
                        
                        this.panStereoClicked(null);
		};

		private function timeHandler(event:MediaEvent):void {
		};


	}
}
