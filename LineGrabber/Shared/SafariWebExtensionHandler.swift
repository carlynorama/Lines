//
//  SafariWebExtensionHandler.swift
//  LineGrabber
//
//  Created by Carlyn Maw on 2/9/24.
//


import SafariServices
import os.log

//Handles Requests From Safari
class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {
    
    func beginRequest(with context: NSExtensionContext) {
        
        print("Hello?") //DO NOT SEE THIS IN DEBUG
        
        
        let helloContext = context.classDescription
        os_log(.default, "Tell me about the context %@", String(describing: helloContext))
        
        let request = context.inputItems.first as? NSExtensionItem

        //Does the request have an associated profile?
        let profile: UUID?
        if #available(iOS 17.0, macOS 14.0, *) {
            profile = request?.userInfo?[SFExtensionProfileKey] as? UUID
        } else {
            profile = request?.userInfo?["profile"] as? UUID
        }

        //Does the request have an associated profile?
        let message: Any?
        if #available(iOS 17.0, macOS 14.0, *) {
            message = request?.userInfo?[SFExtensionMessageKey]
        } else {
            message = request?.userInfo?["message"]
        }
        
        //request?.attachments //NSProvider, can scan for type (Image, etc)
        //request?.attributedContentText

        os_log(.default, "Received message from browser.runtime.sendNativeMessage: %@ (profile: %@)", String(describing: message), profile?.uuidString ?? "none")
        
        let response = NSExtensionItem()
        
        if let _ = request?.userInfo?["isClip"] {
            response.userInfo = [ SFExtensionMessageKey: [ "receivedClip": "true" ] ]
        }
        
        
        if let myMessage = message as? String, myMessage.contains("|") {
            response.userInfo = [ SFExtensionMessageKey: [ "echoClip": myMessage ] ]
        } else {
            response.userInfo = [ SFExtensionMessageKey: [ "echo": message ] ]
        }

        context.completeRequest(returningItems: [ response ], completionHandler: nil)
    }

}
