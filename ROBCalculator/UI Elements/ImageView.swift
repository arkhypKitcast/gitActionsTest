//
//  ImageView.swift
//  Column_UIKit
//
//  Created by arkhyp on 19.03.2022.
//

import UIKit
import Kingfisher

public class ImageView: UIImageView {
    public var placeholder: UIImage? {
        didSet {
            if image == nil {
                image = placeholder
            }
        }
    }
    
    public init() {
        super.init(frame: .zero)
        contentMode = .scaleAspectFill
        self.kf.indicatorType = .activity
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupImage(named: String) {
        image = UIImage(named: named) ?? placeholder
    }
    
    public func setupImage(_ urlStr: String?) {
        kf.cancelDownloadTask()
        if let urlStr = urlStr, let url = URL(string: urlStr) {
            setupImage(url)
        } else {
            image = placeholder
        }
    }
    
    func setupImage(_ url: URL) {
        kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(1))]
            
        ) { [weak self] result  in
            switch result {
            case .success:
//                debugPrint("[Kingfisher] Did load image: \(url.absoluteString)")
                break
            case .failure:
//                debugPrint("[Kingfisher] Did faild to load image: \(url.absoluteString)")
                self?.image = self?.placeholder
            }
        }
    }
}
