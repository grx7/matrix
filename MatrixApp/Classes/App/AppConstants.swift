//
//  AppConstants.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 14/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

struct ConfigKey {
    static let defaultHomeServer = "defaultHomeServer"
    static let defaultIdentityServer = "defaultIdentityServer"
}

struct Constants {
    static let service = "me.lumby.matrix.server-token"
    static let userAccounts = "userAccounts"
    static let activeAccount = "activeAccount"
    static let contentUriScheme  = "mxc://"
}

struct Notifications {
    static let accountAdded = Notification.Name("matrixAccountWasAddedNotification")
    static let accountRemoved = Notification.Name("matrixAccountWasRemovedNotification")
}

struct AppColors {
    static let darkBlue = UIColor.init(red: 28/255, green: 38/255, blue: 47/255, alpha: 1)
    static let blue = UIColor.init(red: 36/255, green: 47/255, blue: 59/255, alpha: 1)
}
