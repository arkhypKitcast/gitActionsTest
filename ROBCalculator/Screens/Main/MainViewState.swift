//
//  MainViewState.swift
// 
//
//  Created by arkhyp.
//

import Foundation

public enum MainViewState {
  case launching
  case onboarding
  case signedIn
}

extension MainViewState: Equatable {
  
  public static func ==(lhs: MainViewState, rhs: MainViewState) -> Bool {
    switch (lhs, rhs) {
    case (.launching, .launching):
      return true
        
    case (.onboarding, .onboarding):
      return true
        
    case (.signedIn, .signedIn):
      return true
        
    case (.launching, _),
         (.onboarding, _),
         (.signedIn, _):
      return false
    }
  }
}
