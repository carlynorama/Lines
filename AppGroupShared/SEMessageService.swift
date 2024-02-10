//
//  SEMessageService.swift
//  Lines
//
//  Created by Carlyn Maw on 2/10/24.
//

import Foundation

protocol SEMessageService {
    var fromExtensionKey: String { get }
    var fromNativeKey: String { get }
    
    func setToExtensionMessage(to:some StringProtocol)
    func getFromExtensionMessage() -> String?
    func clearFromExtensionMessage()
    func setToNativeMessage(to:some StringProtocol)
    func getFromNativeMessage() -> String?
}

enum AppGroupSettings {
#if os(macOS)
    static let id = "KH3G9PXA68.com.carlynorama.lines"
#else
    static let id = "group.com.carlynorama.safariextensionland"
#endif
}



struct AppGroupService {
    private let appGroupID: String
    private let userDefaults: UserDefaults
    
    //
    var containerURL:URL? {
        FileManager.default.containerURL(forSecurityApplicationGroupIdentifier:appGroupID)
    }
    
    private func dumpUserDefaults() {
        print(userDefaults.dictionaryRepresentation())
    }
    
    private func stringForKey(_ key:some StringProtocol) -> String? {
        userDefaults.string(forKey: key as! String) //as? String
    }
    
    private func setString(_ value: some StringProtocol, forKey key: some StringProtocol) {
        userDefaults.set(value as! String, forKey: key as! String)
    }
    
    private func allDefaults() -> Dictionary<String, Any> {
        userDefaults.dictionaryRepresentation()
    }
    
    private func removeKey(_ key: some StringProtocol) {
        userDefaults.removeObject(forKey: key as! String)
    }

    //for sharedContainerIdentifier if needed.
    private var storageLocation:URL? {
        FileManager.default.containerURL(forSecurityApplicationGroupIdentifier:appGroupID)
    }
}

extension AppGroupService {
    init?(appGroupID: String) {
        self.appGroupID = appGroupID
        guard let userDefs = UserDefaults(suiteName: appGroupID) else {
            return nil
        }
        self.userDefaults = userDefs
    }
}

extension AppGroupService:SEMessageService {

    
    var fromExtensionKey:String { "toShell" }
    var fromNativeKey:String { "toExtension" }
    

    func setToExtensionMessage(to message: some StringProtocol) {
        setString(message, forKey:fromNativeKey)
    }
    
    func clearFromExtensionMessage() {
        removeKey(fromExtensionKey)
    }
    
    func getFromExtensionMessage() -> String? {
        setString("test", forKey: fromNativeKey)
        print(userDefaults.string(forKey:fromExtensionKey))
        print(userDefaults.string(forKey: fromNativeKey))
        print(containerURL)
        //print(userDefaults.attributeKeys)
        print(userDefaults)
        
        
        return stringForKey(fromExtensionKey)
    }
    
    func setToNativeMessage(to message: some StringProtocol) {
        setString(message, forKey:fromExtensionKey)
    }
    
    func getFromNativeMessage() -> String? {
        stringForKey(fromNativeKey)
    }
    
}

