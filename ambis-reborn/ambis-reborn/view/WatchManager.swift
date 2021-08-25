//
//  WatchManager.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 25/08/21.
//

import Foundation
import WatchConnectivity
class WatchManager: NSObject {
    static let shared: WatchManager = WatchManager()
    fileprivate var watchSession: WCSession?
    override init() {
        super.init()
        if (!WCSession.isSupported()) {
            watchSession = nil
            return
        }
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
    }
    
    func sendParamsToWatch(dict: [String: Any]) {
        do {
            try watchSession?.updateApplicationContext(dict)
        } catch {
            print("Error set context \(dict)")
        }
    }
}

extension WatchManager: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("DID COMPLETE")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("INACTIVE")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("DEACTIVE")
    }
}
