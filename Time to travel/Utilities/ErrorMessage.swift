//
//  ErrorMessage.swift
//  Time to travel
//
//  Created by i0240 on 20.09.2023.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidURL = "Invalid URL"
    case networkError = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
