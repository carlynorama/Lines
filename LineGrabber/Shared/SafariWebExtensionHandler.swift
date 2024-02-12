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
    
    let shellMessageService = AppGroupService(appGroupID: AppGroupSettings.id)!
    
    func setMessageForApp(_ message:String) {
        shellMessageService.setFromExtensionMessage(to: message)
    }
    
    func confirmMessageForApp() -> String {
        shellMessageService.getFromExtensionMessage() ?? "No Message"
    }
    
    var udKey:String {
        shellMessageService.fromExtensionKey
    }
    
    func beginRequest(with context: NSExtensionContext) {
        var responseContent: [ String : Any ] = [ : ]
        defer {
            let response = NSExtensionItem()
            response.userInfo = [ SFExtensionMessageKey: responseContent ]
            context.completeRequest(returningItems: [ response ], completionHandler: nil)
        }
        
        print("Hello?") //NOT SEEN DEBUG B/C THIS IS NOT OUR CONTEXT.
        
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

        os_log(.default, "Received message from browser.runtime.sendNativeMessage: %@ (profile: %@)", String(describing: message), profile?.uuidString ?? "none")
        
        if let messageDictionary = message as? Dictionary<String,String> {
            if let _ = messageDictionary["isClip"] {
                responseContent["receivedClip"] = "true"
                setMessageForApp(messageDictionary["message"]!)
                responseContent["updatedForKey"] = udKey
                responseContent["updatedWith"] = confirmMessageForApp()
            }
        }
        responseContent["echo"] = message
    }

}
