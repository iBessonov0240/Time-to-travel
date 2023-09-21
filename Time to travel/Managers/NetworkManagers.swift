//
//  NetworkManagers.swift
//  Time to travel
//
//  Created by i0240 on 20.09.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let url = "https://vmeste.wildberries.ru/stream/api/avia-service/v1/suggests/getCheap"

    func makeAPIRequest(completion: @escaping (Result<TravelData, ErrorMessage>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let travelDetails = try decoder.decode(TravelData.self, from: data)
                completion(.success(travelDetails))
                print("======== \(travelDetails.data)")
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
