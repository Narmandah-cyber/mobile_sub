import UIKit
import Flutter
import GoogleMaps // 1. ADD THIS IMPORT

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // 2. ADD THIS INITIALIZATION LINE BEFORE THE PLUGIN REGISTRANT
    GMSServices.provideAPIKey("YOUR_API_KEY")

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}