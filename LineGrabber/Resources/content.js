browser.runtime.sendMessage({ greeting: "hello" }).then((response) => {
    console.log("Received response: ", response);
});

browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    console.log("Received request: ", request);
});

console.log("hello from content.js");

//need other approach on FireFox..
//https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Interact_with_the_clipboard
function updateClipboard(newClip) {
    navigator.clipboard.writeText(newClip).then(
        () => {
            console.log("clipboard write success:", newClip)
        },
        () => {
            console.log("clipboard write failed:", newClip)
        },
    );
}


var copyable = Array.from(document.getElementsByTagName('p'))
.concat(Array.from(document.getElementsByTagName('li')));

for( var i = 0; i < copyable.length; ++i ) {
    copyable[i].onclick = function() {
        //This strips out all tags. If want something more attributed
        //strings friendly use .innerHTML or .innerText
        let text = this.textContent; //.innerHTML;
        let url = document.location.href;
        updateClipboard(text + "|" + url);
    }
}

