//
//  LocationsView.swift
//  MapApp
//
//  Created by Dan Engel on 6/7/23.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @EnvironmentObject private var vm: LocationsViewModel

    var body: some View {
        ZStack {
            mapView
                .ignoresSafeArea()
            VStack(spacing: 0) {
                header
                    .padding()
                Spacer()
                locationsPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

extension LocationsView {
    private var mapView: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationPinView()
                    .scaleEffect(vm.currentLocation == location ? 1.0 : 0.7)
                    .onTapGesture {
                        vm.showNewLocation(location: location)
                    }
            }
        })
    }
}

extension LocationsView {
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations, id: \.id) { location in
                if vm.currentLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}

extension LocationsView {
    private var header: some View {
        VStack {
            Button{
                vm.toggleLocationsList()
            } label: {
                Text("\(vm.currentLocation.name), \(vm.currentLocation.cityName)")
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(vm.isShowingLocations ? .degrees(-180) : .degrees(0))
                    }
            }
            if vm.isShowingLocations {
                withAnimation {
                    LocationsListView()
                }
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
