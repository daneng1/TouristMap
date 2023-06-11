//
//  LocationPinView.swift
//  MapApp
//
//  Created by Dan Engel on 6/8/23.
//

import SwiftUI

struct LocationPinView: View {
    var accentColor = Color("AccentColor")
    var body: some View {
        VStack {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .padding(6)
                .background(accentColor)
                .cornerRadius(36)
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(accentColor)
                .frame(width: 15, height: 15)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -12)
                .padding(.bottom, 40)
        }
    }
}

struct LocationPinView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPinView()
    }
}
