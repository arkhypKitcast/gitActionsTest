//  PlaneHeaderTableViewCell.swift
//  ROBCalculator
//
//  Created by arkhyp on 18.04.2022.
//  
//

import UIKit

struct PlaneHeaderViewData: ViewData {
    var viewType: ConfigurableView.Type = PlaneHeaderTableViewCell.self

    let image: UIImage?
    let planeName: String?
    let registerNumber: String?

    let editAction: (() -> Void)?
    let hiedAction: (() -> Void)?
}

class PlaneHeaderTableViewCell: ConfigurableTableViewCell {
    var editAction: (() -> Void)?
    var hideAction: (() -> Void)?
    
    lazy var contentStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var aircraftImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .textColor
        view.font = .appFont(ofSize: 24, weight: .bold)
        view.text = "1974 Piper PA31-350 Navajo Chieftain"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var regNumberLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .textColor2
        view.font = .appFont(ofSize: 18, weight: .bold)
        view.text = "N2452G"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var buttonStack: UIStackView = {
        let view = UIStackView()
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var editButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.mediumPrimary()
        config.title = "Edit Info"
        config.image = UIImage(named: "Edit")?.withRenderingMode(.alwaysTemplate)
        config.imagePlacement = .leading
        config.cornerStyle = .capsule
        config.titleTextAttributesTransformer =
          UIConfigurationTextAttributesTransformer { incoming in
              var outgoing = incoming
              outgoing.font = .appFont(ofSize: 14, weight: .semibold)
              outgoing.foregroundColor = .appWhite
              return outgoing
          }
        view.configuration = config
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addAction(UIAction(handler: { [unowned self] _ in
            self.editAction?()
        }), for: .touchUpInside)
        return view
    }()
    
    lazy var hideButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.mediumSeconadry()
        config.title = "Hide Info"
        config.image = UIImage(named: "Hide")?.withRenderingMode(.alwaysTemplate)
        config.imagePlacement = .leading
        config.cornerStyle = .capsule
        config.titleTextAttributesTransformer =
          UIConfigurationTextAttributesTransformer { incoming in
              var outgoing = incoming
              outgoing.font = .appFont(ofSize: 14, weight: .semibold)
              outgoing.foregroundColor = .appBlue
              return outgoing
          }
        view.configuration = config
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addAction(UIAction(handler: { [unowned self] _ in
            self.hideAction?()
        }), for: .touchUpInside)
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(contentStack)
        contentView.addSubview(buttonStack)
        
        contentStack.addArrangedSubview(aircraftImageView)
        contentStack.addArrangedSubview(nameLabel)
        contentStack.addArrangedSubview(regNumberLabel)
        
        buttonStack.addArrangedSubview(editButton)
        buttonStack.addArrangedSubview(hideButton)
        
        contentStack.setCustomSpacing(24, after: aircraftImageView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            buttonStack.topAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 24),
            buttonStack.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            contentView.trailingAnchor.constraint(greaterThanOrEqualTo: buttonStack.trailingAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            buttonStack.heightAnchor.constraint(equalToConstant: 36),
            aircraftImageView.heightAnchor.constraint(equalToConstant: 185),
        ])
    }
    
    func configure(viewData: ViewData) {
        guard let model = modelFor(PlaneHeaderViewData.self, viewData) else { return }
        hideAction = model.hiedAction
        editAction = model.editAction
        
        aircraftImageView.image = model.image
        nameLabel.text = model.planeName
        regNumberLabel.text = model.registerNumber
        
        aircraftImageView.isHidden = model.image == nil
        nameLabel.isHidden = (model.planeName?.isEmpty ?? true)
        regNumberLabel.isHidden = (model.registerNumber?.isEmpty ?? true)
    }
}
