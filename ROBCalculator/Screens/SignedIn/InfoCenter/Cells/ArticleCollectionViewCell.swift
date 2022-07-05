//  ArticleCollectionViewCell.swift
//  ROBCalculator
//
//  Created by arkhyp on 10.04.2022.
//  
//

import UIKit

struct ArticleViewData: ViewData {
    var viewType: ConfigurableView.Type = ArticleCollectionViewCell.self
    var title: String
    var formattedDate: String
    var image: String
}

class ArticleCollectionViewCell: ConfigurableCollectionViewCell {
    
    lazy var imageView: ImageView = {
        let view = ImageView()
        view.placeholder = UIImage(named: "articlePlaceholder")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .appFont(ofSize: 12, weight: .semibold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.numberOfLines = 4
        view.font = .appFont(ofSize: 24, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var readButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.mediumPrimary()
        config.title = "Read"
        config.cornerStyle = .capsule
        view.configuration = config
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(readButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 24),
            timeLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            
            readButton.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 16),
            readButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 24),
            readButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 75),
            imageView.bottomAnchor.constraint(equalTo: readButton.bottomAnchor, constant: 24),
        ])
    }
    
    func configure(viewData: ViewData) {
        guard let model = modelFor(ArticleViewData.self, viewData) else { return }
        titleLabel.text = model.title
        timeLabel.text = model.formattedDate
        imageView.setupImage(model.image)
    }
}
