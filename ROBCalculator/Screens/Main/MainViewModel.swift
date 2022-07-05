//
//  MainViewModel.swift
//  ROBCalculator
//
//  Created by arkhyp on 22.03.2022.
//

import Foundation
import Combine

public class MainViewModel: ObservableObject, SignedInResponder {
    
    @Published
    public var state: MainViewState = .launching
    
    @UserDefault("didShowWelcome", defaultValue: false)
    var didShowWelcome: Bool
    
    public init() {
        state = didShowWelcome ? .signedIn : .onboarding
    }
    
    public func didSignedIn() {
        didShowWelcome = true
        state = .signedIn
    }
}
