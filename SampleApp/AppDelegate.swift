//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Hyuntak Joo on 2020/03/28.
//  Copyright © 2020 Hyuntak Joo. All rights reserved.
//

import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow()
    let viewModel = SampleViewModel()
    // let viewController = SampleViewController(viewModel: viewModel)
    // let viewController = UIHostingController(rootView: SampleView_Failed(viewModel: viewModel))
    // let viewController = UIHostingController(rootView: SampleView_Succeed(viewModel: viewModel))
     let viewController = UIHostingController(rootView: SampleView_Final(viewModel: viewModel))
    window?.rootViewController = viewController
    window?.makeKeyAndVisible()

    return true
  }
}

