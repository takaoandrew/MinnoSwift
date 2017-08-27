//
//  EchoViewController.swift
//  MinnoSwift
//
//  Created by Andrew Takao on 8/24/17.
//  Copyright © 2017 Andrew Takao. All rights reserved.
//

import UIKit
import MapKit

class EchoViewController: UIViewController {
    var profileInfo : Connect?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var privacySwitch: UISwitch!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var titleText: UITextField!
    
    let initialLocation = CLLocation(latitude: 42.36, longitude: -71.06)
    let regionRadius: CLLocationDistance = 1000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let echo = Echo(title: titleText.text!, privacy: privacyLabel.text!, host: profileInfo?.name ?? "noname", eventDescription: descriptionText.text!, location: "TestLocation")
        if segue.identifier == "emitSegue" {
            if let toViewController = segue.destination as? EchoDetailViewController {
                toViewController.echoInfo = echo
                toViewController.profileInfo = profileInfo
            }
        }
    }
    
    func switchValueDidChange(sender:UISwitch!) {
        if privacyLabel.text == "Private" {
            privacyLabel.text = "Public"
        }
        else {
            privacyLabel.text = "Private"
        }        
    }
    
    func mapTapped(sender:UITapGestureRecognizer) {
        
        let latitude: CLLocationDegrees = 42.36
        let longitude: CLLocationDegrees = -71.06
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.openInMaps(launchOptions: options)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionText.layer.borderWidth = 1
        let mapTap = UITapGestureRecognizer(target: self, action: #selector(EchoViewController.mapTapped(sender:)))
        map.addGestureRecognizer(mapTap)
        
        privacySwitch.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
        
        centerMapOnLocation(location: initialLocation)
        
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let hour = (calendar.component(.hour, from: date) + 1)%24
        var day = calendar.component(.day, from: date)
        if (hour == 1) {
            day = day + 1
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateString = String(year) + "/" + String(month) + "/" + String(day) + " " + String(hour) + ":00"
        let someDateTime = formatter.date(from: dateString)
        
        datePicker.setDate(someDateTime!, animated: false)
        // Do any additional setup after loading the view.
    }

}
