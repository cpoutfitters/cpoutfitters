/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

import UIKit

import Parse

// If you want to use any of the UI components, uncomment this line
// import ParseUI

let userDidLogoutNotification = "userDidLogoutNotification"
let userDidLoginNotification = "userDidLoginNotification"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)
    
  //--------------------------------------
  // MARK: - UIApplicationDelegate
  //--------------------------------------
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    // ****************************************************************************
    // Uncomment and fill in with your Parse credentials:
    Parse.initializeWithConfiguration(ParseClientConfiguration(block: { (configuration) -> Void in
      configuration.localDatastoreEnabled = true
      configuration.applicationId = "cpoutfitters"
      configuration.clientKey = "client"
      configuration.server = "https://cpoutfitters-server.herokuapp.com/parse"
    }))
    //
    // If you are using Facebook, uncomment and add your FacebookAppID to your bundle's plist as
    // described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
    // Uncomment the line inside ParseStartProject-Bridging-Header and the following line here:
    // PFFacebookUtils.initializeFacebook()
    // ****************************************************************************
    
//    PFUser.enableAutomaticUser()
    
    let defaultACL = PFACL();
    
    // If you would like all objects to be private by default, remove this line.
    defaultACL.publicReadAccess = true
    
    PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)
    
//    if application.applicationState != UIApplicationState.Background {
//      // Track an app open here if we launch with a push, unless
//      // "content_available" was used to trigger a background push (introduced in iOS 7).
//      // In that case, we skip tracking here to avoid double counting the app-open.
//      
//      let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
//      let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
//      var noPushPayload = false;
//      if let options = launchOptions {
//        noPushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil;
//      }
//      if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
//        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
//      }
//    }
//    
//    let types: UIUserNotificationType = [.Alert, .Badge, .Sound]
//    let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
//    application.registerUserNotificationSettings(settings)
//    application.registerForRemoteNotifications()
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: userDidLogoutNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogin", name: userDidLoginNotification, object: nil)
    
    if (PFUser.currentUser() != nil) {
        userDidLogin()
    }
    
    return true
  }
    
  
    func userDidLogin(){
        let tbController = storyboard.instantiateViewControllerWithIdentifier("TabBarController")
        window?.rootViewController = tbController
    }
    
    func userDidLogout(){
        let loginController = storyboard.instantiateViewControllerWithIdentifier("Login")
        window?.rootViewController = loginController
    }
    
  //--------------------------------------
  // MARK: Push Notifications
  //--------------------------------------
  
  func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
    let installation = PFInstallation.currentInstallation()
    installation.setDeviceTokenFromData(deviceToken)
    installation.saveInBackground()
    
    PFPush.subscribeToChannelInBackground("") { (succeeded: Bool, error: NSError?) in
      if succeeded {
        print("ParseStarterProject successfully subscribed to push notifications on the broadcast channel.\n");
      } else {
        print("ParseStarterProject failed to subscribe to push notifications on the broadcast channel with error = %@.\n", error)
      }
    }
  }
  
//  func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
//    if error.code == 3010 {
//      print("Push notifications are not supported in the iOS Simulator.\n")
//    } else {
//      print("application:didFailToRegisterForRemoteNotificationsWithError: %@\n", error)
//    }
//  }
//  
//  func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//    PFPush.handlePush(userInfo)
//    if application.applicationState == UIApplicationState.Inactive {
//      PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
//    }
//  }
  
  ///////////////////////////////////////////////////////////
  // Uncomment this method if you want to use Push Notifications with Background App Refresh
  ///////////////////////////////////////////////////////////
  // func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
  //     if application.applicationState == UIApplicationState.Inactive {
  //         PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
  //     }
  // }
  
  //--------------------------------------
  // MARK: Facebook SDK Integration
  //--------------------------------------
  
  ///////////////////////////////////////////////////////////
  // Uncomment this method if you are using Facebook
  ///////////////////////////////////////////////////////////
  // func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
  //     return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication, session:PFFacebookUtils.session())
  // }
}
