//
//  ContentView.swift
//  RestroomFinder
//
//  Created by Weerawut Chaiyasomboon on 22/04/2568.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @Environment(\.httpClient) private var restroomClient
    @State private var locationManager = LocationManager.shared
    @State private var restrooms: [Restroom] = []
    @State private var selectedRestroom: Restroom?
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    private func loadRestrooms() async {
        guard let region = visibleRegion else { return }
        let coordinate = region.center
        let url = Constants.Urls.restroomsByLocation(latitude: coordinate.latitude,longitude: coordinate.longitude)
        do {
            self.restrooms = try await restroomClient.fetchRestrooms(url: url)
        } catch {
            print("Error fetching restrooms: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                ForEach(restrooms) { restroom in
                    Annotation(restroom.name, coordinate: restroom.coordinate) {
                        Text("🚻")
                            .font(.title)
                            .scaleEffect(selectedRestroom == restroom ? 2.0 : 1.0)
                            .onTapGesture {
                                withAnimation {
                                    selectedRestroom = restroom
                                }
                            }
                            .animation(.spring(duration: 0.25), value: selectedRestroom)
                    }
                }
                
                UserAnnotation()
            }
        }
        .task(id: locationManager.region) { //this task will be called if value in "id" change
            if let region = locationManager.region {
                visibleRegion = region
                await loadRestrooms()
            }
        }
        .onMapCameraChange({ context in
            visibleRegion = context.region
        })
        .overlay(alignment: .topLeading) {
            Button {
                Task {
                    await loadRestrooms()
                }
            } label: {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white, .blue)
            }
            .padding()
        }
        .sheet(item: $selectedRestroom) { restroom in
            RestroomDetailView(restroom: restroom)
                .padding()
                .presentationDetents([.fraction(0.25)])
        }
    }
}

#Preview {
    ContentView()
        .environment(\.httpClient, RestroomClient())
}

//Marker(restroom.name, coordinate: restroom.coordinate)
