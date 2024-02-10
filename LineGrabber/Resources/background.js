browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    console.log("Received request: ", request);

    if (request.greeting === "hello")
        sendResponse({ farewell: "goodbye" });
});

console.log("hello from background.js")


//https://developer.apple.com/documentation/safariservices/safari_web_extensions/messaging_a_web_extension_s_native_app
browser.runtime.sendNativeMessage("application.id", {message: "Hello from background page"}, function(response) {
    console.log("Received sendNativeMessage response:");
    console.log(response);
});

// Set up a connection to receive messages from the native app.
let port = browser.runtime.connectNative("application.id");
port.postMessage("Hello from JavaScript Port");
port.onMessage.addListener(function(message) {
    console.log("Received native port message:");
    console.log(message);
});

port.onDisconnect.addListener(function(disconnectedPort) {
    console.log("Received native port disconnect:");
    console.log(disconnectedPort);
});
