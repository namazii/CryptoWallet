//
//  API.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 23.04.2023.
//

import Foundation

final class API {
    
    class func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, completion: @escaping(T) -> Void) {
        
        var components = URLComponents()
        components.scheme = endpoint.sheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        
        guard let url = components.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        let session = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            
            guard let jsonData = data else { return }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let response = try jsonDecoder.decode(T.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print(error)
            }
        }
        session.resume()
    }
}
