//
//  UIViewController+Extensions.swift
//  ROBCalculator
//
//  Created by arkhyp on 18.04.2022.
//

import Foundation
import UIKit

extension UIViewController {
    private static var originalAdditionalSafeAreaInsetsStore = [String: UIEdgeInsets]()
        
    var originalAdditionalSafeAreaInsets: UIEdgeInsets? {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIViewController.originalAdditionalSafeAreaInsetsStore[tmpAddress]
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIViewController.originalAdditionalSafeAreaInsetsStore[tmpAddress] = newValue
        }
    }
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidAppear(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardDidAppear(notification: NSNotification) {
        if originalAdditionalSafeAreaInsets == nil {
            originalAdditionalSafeAreaInsets = additionalSafeAreaInsets
        }
        let keyboardSize: CGSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size

        let height = keyboardSize.height
        
        var currentSafeAreaInsets = originalAdditionalSafeAreaInsets ?? .zero
        currentSafeAreaInsets.bottom += height
        
        self.additionalSafeAreaInsets = currentSafeAreaInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.additionalSafeAreaInsets = self.originalAdditionalSafeAreaInsets ?? .zero
        } completion: { _ in

        }
    }
}
