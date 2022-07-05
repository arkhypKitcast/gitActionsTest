//
//  WelcomeViewModel.swift
//  ROBCalculator
//
//  Created by arkhyp on 22.03.2022.
//

import Foundation
import Combine

class WelcomeViewModel {
    let signedInResponder: SignedInResponder
    
    @Published
    public var currentPage: Int = 0
    public var pages: Int = 3
    
    init(signedInResponder: SignedInResponder) {
        self.signedInResponder = signedInResponder
    }
    
    @objc
    func next() {
        if currentPage >= pages - 1 {
            signedInResponder.didSignedIn()
        } else {
            currentPage += 1
        }
    }
}
