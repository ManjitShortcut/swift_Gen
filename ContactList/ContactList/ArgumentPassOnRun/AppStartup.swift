//
//  ArgumentPassOnLunch.swift
//  DNB_TASK
//
//  Created by Manjit on 04/04/2021.
//

import Foundation

struct AppStartup {
  static let shared = AppStartup()
  static func shouldRunMock() -> Bool {
    return CommandLine.arguments.contains("MOCK")
  }
}
