//
//  CityLocationCell.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/26/24.
//

import UIKit

import MapKit
import SnapKit

class CityLocationCell: UITableViewCell {
    // MARK: - Components
    private var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = false
        mapView.userTrackingMode = .none
        mapView.mapType = .hybrid
        mapView.isScrollEnabled = false
        mapView.isRotateEnabled = false
        mapView.isZoomEnabled = false
        return mapView
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
        mapView.removeAnnotations(mapView.annotations)
    }
}

// MARK: - SetUp
private extension CityLocationCell {
    func setUp() {
        contentView.addSubview(mapView)
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(contentView).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(contentView).offset(-Constants.margin.horizontal)
        }
        mapView.layer.cornerRadius = Constants.radius.px12
        mapView.layer.masksToBounds = true
    }
}

// MARK: - Method
extension CityLocationCell {
    func updateMapLocation(latitude: Double, longitude: Double, title: String) {
        centerMapOnLocation(latitude: latitude, longitude: longitude)
        addPinToMap(latitude: latitude, longitude: longitude, title: title)
    }
    
    func centerMapOnLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 2500000, longitudinalMeters: 2500000)
        mapView.setRegion(region, animated: true)
    }

    func addPinToMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
}
