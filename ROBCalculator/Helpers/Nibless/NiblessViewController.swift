//
//  NiblessViewController.swift
//  ColumnUIKit
//
//  Created by arkhyp.
//

import Foundation
import UIKit

open class NiblessViewController: UIViewController {

    public var titleImage = UIImage(named: "Column_navigation_logo")
    
  // MARK: - Methods
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable,
                message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable,
                message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        if let titleImage = titleImage {
            let imView = UIImageView(image: titleImage)
            navigationItem.titleView = imView
        }
    }
}
