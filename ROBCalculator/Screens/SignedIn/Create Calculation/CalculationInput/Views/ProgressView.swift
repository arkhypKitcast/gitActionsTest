//
//  ProgressView.swift
//  ROBCalculator
//
//  Created by arkhyp on 14.04.2022.
//

import UIKit

class ProgressView: UIView {
    var progress: CGFloat = 0.0 {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.setupProgress()
            }
        }
    }
    
    lazy var fillView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        backgroundColor = .appGray5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(fillView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupProgress()
    }
    
    func setupProgress() {
        let frame = CGRect(x: 0, y: 0, width: bounds.width * progress, height: bounds.height)
        fillView.frame = frame
    }
}
