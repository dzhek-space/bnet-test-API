//
//  NetworkRequestProtocol.swift
//  bnetTestApp
//
//  Created by Dzhek on 30/09/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import Foundation

//MARK: - • Protocol

protocol NetworkRequestProtocol {
    
    associatedtype ModelType: Decodable
    
    //MARK: • Properties
    
    var parameters: [String : String] { get }

    
    //MARK: - • Methods
    
    func upload(withCompletion completion: @escaping TaskCompletionHandler)
    
}

//MARK: - • Protocol Extension

extension NetworkRequestProtocol {
    
    typealias TaskCompletionHandler = (Result<BnetResponse<ModelType>>) -> Void
    
    //MARK: - • Methods
    
    func uploadResume(with parameters: [String : String], withCompletion completion: @escaping TaskCompletionHandler) {
        let request = self.urlRequest
        let requestParametrs = self.preparedData(from: parameters)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.uploadTask(with: request, from: requestParametrs, completionHandler: { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                guard let data = data
                    else {
                        completion(.failure(APIError.invalidData))
                        return }
                guard let responseData = try? JSONDecoder().decode(BnetResponse<ModelType>.self, from: data)
                    else {
                        completion(.failure(APIError.decodingFailure))
                        return }
                completion(.success(responseData))
            } else {
                completion(.failure(APIError.serverUnreacheble))
            }
            
        })
        task.resume()
    }
    
    private var urlRequest: URLRequest {
        let url = URL(string: NetworkConstants.endPoint)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.post.rawValue
        request.setValue(NetworkConstants.contentHeader.value,
                         forHTTPHeaderField: NetworkConstants.contentHeader.fieldName)
        request.addValue(NetworkConstants.tokenHeader.value,
                         forHTTPHeaderField: NetworkConstants.tokenHeader.fieldName)
        return request
    }
    
    private func preparedData(from parameters: [String : String]) -> Data {
        var data = Data()
        var numberOfParametrs = parameters.count
        for (key, value) in parameters {
            numberOfParametrs -= 1
            data.append("\r\n--\(NetworkConstants.boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            data.append(value.data(using: .utf8)!)
            if numberOfParametrs == 0 {
                data.append("\r\n--\(NetworkConstants.boundary)--\r\n".data(using: .utf8)!)
            }
        }
        return data
    }
    
}
