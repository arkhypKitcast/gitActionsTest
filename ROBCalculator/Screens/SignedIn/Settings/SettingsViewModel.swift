//
//  SettingsViewModel.swift
//  ROBCalculator
//
//  Created by arkhyp on 26.03.2022.
//

import Foundation
import Combine

class SettingsViewModel {
    @Published
    var settings: [[ViewData]] = []
    
    init() {
        setupSettings()
    }
    
    func setupSettings() {
        settings = [
            [
                AppLinkViewData(image: "loremAppIcon", title: "App name 1", subtitle: "Super App try it!"),
                AppLinkViewData(image: "loremAppIcon", title: "App name 2", subtitle: "The best app ever")
            ],
            [
                SettingLinkViewData(title: "Help"),
                SettingLinkViewData(title: "Tutorial"),
                SettingLinkViewData(title: "Give us a Feedback"),
            ],
            [
                SettingLinkViewData(title: "Privacy Policy"),
            ]
        ]
    }
}
