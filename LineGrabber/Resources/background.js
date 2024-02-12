
function sendNewClip(message) {
    console.log("something else")
    const nSend = browser.runtime.sendNativeMessage("application.id", {
        message: message, 
        isClip: "true"
    },
        function(response) {
            console.log("Received newClip response:");
            console.log(response);
        }
    );
    nSend
}


browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    console.log("Received request: ", request);

    if (request.greeting === "hello")
        sendResponse({ farewell: "goodbye" });

    if (request.greeting === "newClip") {
        console.log(request.message);
        sendNewClip(request.message);
        //sendResponse({ farewell: "goodbye" });
    }
});

console.log("hello from background.js")




//--------------------------------------------------- NATIVE MESSAGING DEMO CODE

//https://developer.apple.com/documentation/safariservices/safari_web_extensions/messaging_a_web_extension_s_native_app
//Use runtime.onMessageExternal to talk to other extensions or websites
    console.log("Received sendNativeMessage response:");
    console.log(response);
});

// Set up a connection to receive messages from the native app.

var messageHandler = (message) => {
    console.log("Received native port message:");
    console.log(message);
}
let port = browser.runtime.connectNative("application.id");
port.postMessage("Hello from JavaScript Port");

port.onMessage.addListener(messageHandler);

port.onDisconnect.addListener((p) => {
    console.log("Received native port disconnect:");
    console.log(p);
    if (p.error) {  //runtime.lastError in chrome
        console.log(`Disconnected due to an error: ${p.error.message}`);
    }
});


