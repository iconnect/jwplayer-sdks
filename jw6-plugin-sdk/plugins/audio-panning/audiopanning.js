(function(jwplayer){

var template = function(player, config, div) {

    function readyHandler(event) {
        // Audio panning is not supported on html5.
        return;
    };
    player.onReady(readyHandler);

    function completeHandler(event) {};
    function pauseHandler(event) {};
    function timeHandler(event) {};
    this.resize = function(width, height) {};

};

jwplayer().registerPlugin('audiopanning', '6.0', template,'audiopanning.swf');

})(jwplayer);
