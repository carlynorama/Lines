//
//  ExtensionManager.swift
//  Lines
//
//  Created by Carlyn Maw on 2/9/24.
//

import Foundation
import SafariServices.SFSafariApplication
#if os(macOS)
import SafariServices.SFSafariExtensionManager
#endif
import os.log


class ExtensionManager:ObservableObject {
    
    let extensionMessageService:SEMessageService = AppGroupService(appGroupID: AppGroupSettings.id)!
    
    func getExtensionMessage() -> String? {
        //"Not active."
        extensionMessageService.getFromExtensionMessage()
    }

    
#if os(macOS)
    var isEnabled = false
    func setExtensionStatus() async {
        do {
            isEnabled = try await SFSafariExtensionManager.stateOfSafariExtension(withIdentifier: Constants.macBundleID).isEnabled
        } catch {
            await NSApp.presentError(error)
        }
    }
    
    func openSafariSettings() async {
        do {
            try await SFSafariApplication.showPreferencesForExtension(withIdentifier: Constants.macBundleID)
            //kills the app.
            //If don't kill the app, rewrite so view with status is flagged as stale somehow.
            await NSApplication.shared.terminate(nil)
        } catch {
            await NSApp.presentError(error)
        }
    }
    
    func sendBackgroundMessageToExtension(title:some StringProtocol, message:Dictionary<String,String>) async {
        do {
            try await dispatchMessage(title: title, message: message)
            os_log(.default, "Dispatching message to the extension finished")
        } catch {
            os_log(.default, "\(error)")
        }
    }
    
    func sendBackgroundMessageToExtension(title:some StringProtocol, message:Dictionary<String,String>) {
        SFSafariApplication.dispatchMessage(withName: title as! String, toExtensionWithIdentifier: Constants.macBundleID, userInfo: message) { (error) -> Void in
            os_log(.default, "Dispatching message to the extension finished \(error)")
        }
    }
    
    //MARK: async wrappers on SFSafariApplication
    
    func dispatchMessage(title:some StringProtocol, message:Dictionary<String,String>) async throws {
        let result = await withCheckedContinuation { continuation in
            SFSafariApplication.dispatchMessage(withName: title as! String, toExtensionWithIdentifier: Constants.macBundleID, userInfo: message) { messages in
                continuation.resume(returning: messages)
            }
        }
        if result != nil { throw result! }
        
    }
#endif
}
