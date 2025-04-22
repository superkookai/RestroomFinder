//
//  MockRestroomClient.swift
//  RestroomFinder
//
//  Created by Weerawut Chaiyasomboon on 22/04/2568.
//

import Foundation

struct MockRestroomClient: HTTPClient {
    func fetchRestrooms(url: URL) async throws -> [Restroom] {
        return PreviewData.load(resourceName: "restrooms")
    }
}
