//  ArticleListTableViewCell.swift
//  ROBCalculator
//
//  Created by arkhyp on 10.04.2022.
//  
//

import UIKit

struct ArticleListViewData: ViewData {
    var viewType: ConfigurableView.Type = ArticleListTableViewCell.self
    var articles: [ViewData] = []
    var didSelectArticle: ((ViewData) -> Void)?
}

class ArticleListTableViewCell: ConfigurableTableViewCell {
    var cellCreator: CollectionViewCellCreator = ViewCreator()
    var articles: [ViewData] = []
    var didSelectArticle: ((ViewData) -> Void)?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.registerCell(ArticleCollectionViewCell.self)
        view.showsHorizontalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(collectionView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    func configure(viewData: ViewData) {
        guard let model = modelFor(ArticleListViewData.self, viewData) else { return }
        self.articles = model.articles
        self.didSelectArticle = model.didSelectArticle
        self.collectionView.reloadData()
    }
}

extension ArticleListTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = articles[indexPath.row]
        return cellCreator.dequeCell(data, collectionView: collectionView, indexPath: indexPath)!
    }
}

extension ArticleListTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        didSelectArticle?(articles[indexPath.row])
    }
}

extension ArticleListTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width * 0.8, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
}
