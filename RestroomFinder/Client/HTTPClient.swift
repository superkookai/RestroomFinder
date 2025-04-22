//
//  HTTPClient.swift
//  RestroomFinder
//
//  Created by Weerawut Chaiyasomboon on 22/04/2568.
//

import Foundation

protocol HTTPClient {
    func fetchRestrooms(url: URL) async throws -> [Restroom]
}
