//
//  TravelData.swift
//  Time to travel
//
//  Created by i0240 on 20.09.2023.
//

import Foundation

struct TravelData: Codable {
    let data: [TravelDataDetails]
}

struct TravelDataDetails: Codable {
    let cityFrom: String
    let cityTo: String
    let departureDate: String
    let returnDate: String
    let price: Int
    var isLiked: Bool

    enum CodingKeys: String, CodingKey {
        case cityFrom = "city_from"
        case cityTo = "city_to"
        case departureDate = "departure_date"
        case returnDate = "return_date"
        case price
        case isLiked = "like"
    }
}


// MARK: - MockTravelData

struct MockTravelDataDetails: Hashable {
    let cityFrom: String
    let cityTo: String
    let departureDate: String
    let returnDate: String
    let price: Int
    var isLiked: Bool
}

extension MockTravelDataDetails {
    static var items: [MockTravelDataDetails] = [
        MockTravelDataDetails(cityFrom: "Moscow", cityTo: "Kaliningrad", departureDate: "2023-11-07T08:46:15-0500", returnDate: "2023-11-10T08:46:15-0500", price: 12500, isLiked: false),
        MockTravelDataDetails(cityFrom: "Novosibirsk", cityTo: "Krasnoyarsk", departureDate: "2023-10-07T08:46:15-0500", returnDate: "2023-10-12T08:46:15-0500", price: 7200, isLiked: false),
        MockTravelDataDetails(cityFrom: "Kazan", cityTo: "Khabarovsk", departureDate: "2023-09-02T08:46:15-0500", returnDate: "2023-09-22T08:46:15-0500", price: 22600, isLiked: false),
        MockTravelDataDetails(cityFrom: "Omsk", cityTo: "Saint-Petersburg", departureDate: "2023-11-17T08:46:15-0500", returnDate: "2023-11-27T08:46:15-0500", price: 10800, isLiked: false),
        MockTravelDataDetails(cityFrom: "Yekaterinburg", cityTo: "Sochi", departureDate: "2023-09-15T08:46:15-0500", returnDate: "2023-09-19T08:46:15-0500", price: 3300, isLiked: false),
    ]
}
