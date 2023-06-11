//
//  MapApp.swift
//  MapApp
//
//  Created by Dan Engel on 6/7/23.
//

import SwiftUI

@main
struct MapApp: App {
    @State private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
