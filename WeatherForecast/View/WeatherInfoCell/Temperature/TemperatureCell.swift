//
//  TemperatureCell.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/26/24.
//

import UIKit

import SnapKit

class TemperatureCell: UITableViewCell {
    // MARK: - Components
    let temperatureCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let temperatureCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        temperatureCollectionView.register(TimeTemperatureCell.self, forCellWithReuseIdentifier: TimeTemperatureCell.identifier)
        temperatureCollectionView.backgroundColor = .clear
        temperatureCollectionView.showsHorizontalScrollIndicator = false
        return temperatureCollectionView
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
private extension TemperatureCell {
    func setUp() {
        contentView.addSubview(temperatureCollectionView)
        
        temperatureCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        temperatureCollectionView.delegate = self
        temperatureCollectionView.dataSource = self
    }
}

// MARK: - Method
extension TemperatureCell {
    
}

// MARK: - CollectionViewDelegate
extension TemperatureCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeTemperatureCell.identifier, for: indexPath) as? TimeTemperatureCell else { return UICollectionViewCell() }
        
        cell.configure()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing.px4
    }
}
