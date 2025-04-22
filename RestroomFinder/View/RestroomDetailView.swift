//
//  RestroomDetailView.swift
//  RestroomFinder
//
//  Created by Weerawut Chaiyasomboon on 22/04/2568.
//

import SwiftUI

struct RestroomDetailView: View {
    let restroom: Restroom
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(restroom.name)
                .font(.title3.bold())
            
            Text(restroom.address)
            
            if let comment = restroom.comment {
                Text(comment)
                    .font(.caption)
            }
            
            AmenitiesView(restroom: restroom)
            
            ActionButtons(mapItem: restroom.mapItem)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    let restrooms:[Restroom] = PreviewData.load(resourceName: "restrooms")
    RestroomDetailView(restroom: restrooms[2])
}

struct AmenitiesView: View {
    let restroom: Restroom
    
    var body: some View {
        HStack(spacing: 12) {
            AmenityView(symbol: "♿️", isEnabled: restroom.accessible)
            AmenityView(symbol: "🚻", isEnabled: restroom.unisex)
            AmenityView(symbol: "🚼", isEnabled: restroom.changingTable)
        }
    }
}

struct AmenityView: View {
    let symbol: String
    let isEnabled: Bool
    
    var body: some View {
        if isEnabled {
            Text(symbol)
        }
    }
}
