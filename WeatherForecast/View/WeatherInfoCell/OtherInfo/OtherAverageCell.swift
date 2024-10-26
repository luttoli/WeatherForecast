//
//  OtherAverageCell.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/26/24.
//

import UIKit

import SnapKit

class OtherAverageCell: UITableViewCell {
    // MARK: - Components
    let AverageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let AverageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        AverageCollectionView.register(AverageCell.self, forCellWithReuseIdentifier: AverageCell.identifier)
        AverageCollectionView.backgroundColor = .clear
        AverageCollectionView.showsHorizontalScrollIndicator = false
        AverageCollectionView.isScrollEnabled = false
        return AverageCollectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - SetUp
private extension OtherAverageCell {
    func setUp() {
        contentView.addSubview(AverageCollectionView)
        
        AverageCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        AverageCollectionView.delegate = self
        AverageCollectionView.dataSource = self
    }
}

// MARK: - Method
extension OtherAverageCell {
    
}

// MARK: - CollectionViewDelegate
extension OtherAverageCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AverageCell.identifier, for: indexPath) as? AverageCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .systemBlue
        
        cell.layer.cornerRadius = Constants.radius.px12
        cell.layer.masksToBounds = true
        
        cell.configure(with: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - Constants.margin.vertical
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.margin.horizontal
    }
}
