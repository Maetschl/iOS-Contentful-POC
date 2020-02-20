//
//  CustomTableViewCell.swift
//  ContentfulPoc
//
//  Created by Julian Arias Maetschl on 2/20/20.
//  Copyright © 2020 Maetschl. All rights reserved.
//

import MapKit

class CustomTableViewCell: UITableViewCell {
    static let height: CGFloat = 120.0

    init(persons: [Person], indexPath: IndexPath) {
        let person = persons[indexPath.row]
        super.init(style: .subtitle, reuseIdentifier: "some")
        self.textLabel?.text = person.name
        self.textLabel?.font = UIFont.boldSystemFont(ofSize: 30.0)
        if let lastUpdate = person.updatedAt?.stringValue {
            self.detailTextLabel?.text = "Last update \(lastUpdate)"
            self.detailTextLabel?.font = UIFont.systemFont(ofSize: 18.0)
        }
        if let personLocation = person.location {
            let margin: CGFloat = 18.0
            let map = MKMapView(frame: CGRect(x: UIApplication.shared.windows.first!.frame.width-400-margin, y: margin, width: 400, height: 120-margin*2))
            let location = CLLocationCoordinate2DMake(personLocation.latitude, personLocation.longitude)
            let region = MKCoordinateRegion(
                center: location,
                latitudinalMeters: CLLocationDistance(exactly: 500)!,
                longitudinalMeters: CLLocationDistance(exactly: 500)!
            )
            map.setRegion(map.regionThatFits(region), animated: true)
            self.addSubview(map)
        }
        self.contentView.backgroundColor = UIColor
            .green
            .withAlphaComponent(0.1 + 0.2*CGFloat(indexPath.row)/CGFloat(persons.count))

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
