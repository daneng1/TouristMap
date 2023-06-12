//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Dan Engel on 6/7/23.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location]
    @Published var currentLocation: Location {
        didSet {
            updateMapLocation(location: currentLocation)
        }
    }
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    @Published var isShowingLocations: Bool = false
    @Published var sheetLocation: Location? = nil
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.currentLocation = locations.first!
        self.updateMapLocation(location: locations.first!)
    }
    
    private func updateMapLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    func toggleLocationsList() {
        withAnimation {
            isShowingLocations.toggle()
        }
    }
    
    func showNewLocation(location: Location) {
        withAnimation(.easeInOut) {
            currentLocation = location
            isShowingLocations = false
        }
    }
    
    func loadNextLocation() {
        if let currentLocationIndex = locations.firstIndex(of: currentLocation) {
            if currentLocationIndex + 1 < locations.count {
                showNewLocation(location: locations[currentLocationIndex + 1])
            } else {
                showNewLocation(location: locations.first!)
            }
        }
    }
}
