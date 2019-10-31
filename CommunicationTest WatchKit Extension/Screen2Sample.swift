//
//  Screen2Sample.swift
//  CommunicationTest WatchKit Extension
//
//  Created by Parrot on 2019-10-31.
//  Copyright © 2019 Parrot. All rights reserved.
//

import Foundation
import WatchKit
import WatchConnectivity

@available(watchOSApplicationExtension 6.0, *)
class Screen2Sample: WKInterfaceController, WCSessionDelegate {

    
    // MARK: Outlets
    // ---------------------

    // 1. Outlet for the image view
    @IBOutlet var pokemonImageView: WKInterfaceImage!
    
    @IBOutlet var pokemonName: WKInterfaceTextField!
    
    // 2. Outlet for the label
   
    
    // MARK: Delegate functions
    // ---------------------
    
    // Default function, required by the WCSessionDelegate on the Watch side
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //@TODO
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
           print("WATCH: Got message from Phone")
           // Message from phone comes in this format: ["course":"MADT"]
           //let messageBody = message["course"] as! String
           
          // messageLabel.setText("Give the pokemon a name!")
           pokemonImageView.setImageNamed("\(message["selection"] as! String)")
        print("\(message["selection"] as! String)")
       }
    
    
    // MARK: WatchKit Interface Controller Functions
    // ----------------------------------
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
        // 1. Check if the watch supports sessions
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    // MARK: Actions
    @IBAction func startButtonPressed() {
        var name:String!
        name = "Pokemon"
        print("Start button pressed")
        
        if (WCSession.default.isReachable) {
            let message = ["course": "\(String(describing: name))",]
                   WCSession.default.sendMessage(message, replyHandler: nil)
                  
            print(message["name"]!)
               }
               else {
                   print("PHONE: Cannot reach watch")
                
               }
    }
    
    
    @IBAction func selectNameButtonPressed() {
        print("select name button pressed")
    }
    
    

}
