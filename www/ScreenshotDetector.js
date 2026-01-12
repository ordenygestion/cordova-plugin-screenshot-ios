var exec = require('cordova/exec');

var ScreenshotDetector = {
    /**
     * Inicia la detección de screenshots (automático al cargar)
     */
    startDetection: function(successCallback, errorCallback) {
        exec(successCallback, errorCallback, "ScreenshotDetector", "startDetection", []);
    }
};

module.exports = ScreenshotDetector;
