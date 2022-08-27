//
//  APIClient.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/22/22.
//

import Foundation

struct APIClient {
    // MARK: Variables
    static let identifier: String = "[APIClient]"
    let configuration: APIConfiguration
    let timeout: TimeInterval = 60.0

    // MARK: - Initializer
    init(configuration: APIConfiguration) {
        self.configuration = configuration
    }

    // MARK: Methods
    /*
     Here are the three methods that we provide:
     - Get Resource (GET ONLY)
     - Make API Resource (ALL METHODS)
     - Load Local (LOCAL ONLY)
     */

    /*
     get
     This method is used to make GET calls with no body.
     */
    func get<Response: Decodable>(_: Response.Type, path: String, parameters: [URLQueryItem], requestHeaders: [APIRequestHeader], completion: @escaping ((Result<Response, Error>) -> Void)) {
        debugPrint("\(APIClient.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) get \(DebuggingIdentifiers.actionOrEventInProgress)")
        // Check that the URL exists and that it's not a local file.
        if configuration.url == nil || configuration.url?.isFileURL ?? true {
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed)  is local.")
            loadLocal(resource: path, completion: completion)
            return
        }
        // Check the base URL exists.
        guard let baseURL = configuration.url else {
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed) This resource does not have a url.")
            completion(.failure(NetworkError.noConnection))
            return
        }
        // Create the URL by adding the path to the base URL.
        let url = baseURL.appendingPathComponent(path)
        // Create a url that allows for parameters
        guard var urlWithComponents: URLComponents = URLComponents(string: url.absoluteString) else {
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed) This resource could not produce a URL with components.")
            completion(.failure(NetworkError.noConnection))
            return
        }
        // Set the parameters
        urlWithComponents.queryItems = parameters
        // Safely create a URL with parameters
        guard let urlWithParameters = urlWithComponents.url else {
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed) This resource could not produce a URL with parameters.")
            completion(.failure(NetworkError.noConnection))
            return
        }
        // Create your request
        var request = URLRequest(url: urlWithParameters, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeout)
        // Add the headers
        for header in requestHeaders {
            request.addValue(header.value, forHTTPHeaderField: header.httpHeaderField)
        }
        // Get the session
        let session = configuration.urlSession
        debugPrint("\(APIClient.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) get \(DebuggingIdentifiers.actionOrEventInProgress) Entering Resquest with URL \(urlWithParameters)")
        // Make the API Call
        let dataTask = session.dataTask(with: request) { (responseData, _, responseError) in
            // Check if there's a response
            if let responseData = responseData {
                // Try to decode the data.
                do {
                    let decoded = try JSONDecoder().decode(Response.self, from: responseData)
                    debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventSucceded) Completed Resquest with URL \(urlWithParameters)")
                    completion(.success(decoded))
                    return
                } catch {
                    debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed) Failed Request with URL \(url) with error : \(error).")
                    completion(.failure(error))
                    return
                }
            } else if let responseError = responseError {
                debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed) Failed Request with URL \(url) with error : \(responseError).")
                completion(.failure(responseError))
                return
            }
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed) Failed Request with URL \(url) with error : Bad Data.")
            completion(.failure(NetworkError.badData))

        }

        dataTask.resume()
    }

    /*
     makeAPICall
     This method is used to make all types of calls with a body and a response.
     */
    func makeAPICall<Body: Encodable, Response: Decodable>(method: HTTPMethod, item: Body, path: String, parameters: [URLQueryItem], requestHeaders: [APIRequestHeader], resultType: Response.Type, completion: @escaping (Result<Response, Error>) -> Void) {
        debugPrint("\(APIClient.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) makeAPICall \(DebuggingIdentifiers.actionOrEventInProgress)")
        // Check that there's a URL
        guard let baseURL = configuration.url else {
            debugPrint("\(APIClient.identifier) makeAPICall \(DebuggingIdentifiers.actionOrEventFailed) There is no url. This must be a local call.")
            completion(.failure(NetworkError.noConnection))
            return
        }
        // Encode the body.
        guard let body = try? JSONEncoder().encode(item) else {
            debugPrint("\(APIClient.identifier) makeAPICall \(DebuggingIdentifiers.actionOrEventFailed) Could not encode the body.")
            completion(.failure(NetworkError.badData))
            return
        }
        // Create the URL by adding the path to the base URL.
        let url = baseURL.appendingPathComponent(path)
        // Create a url that allows for parameters
        guard var urlWithComponents: URLComponents = URLComponents(string: url.absoluteString) else {
            debugPrint("\(APIClient.identifier) makeAPICall \(DebuggingIdentifiers.actionOrEventFailed) This resource could not produce a URL with components.")
            completion(.failure(NetworkError.noConnection))
            return
        }
        // Set the parameters
        urlWithComponents.queryItems = parameters
        // Safely create a URL with parameters
        guard let urlWithParameters = urlWithComponents.url else {
            debugPrint("\(APIClient.identifier) makeAPICall \(DebuggingIdentifiers.actionOrEventFailed) This resource could not produce a URL with parameters.")
            completion(.failure(NetworkError.noConnection))
            return
        }
        // Create your request
        var request = URLRequest(url: urlWithParameters, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeout)
        // Add the HTTP Method.
        request.httpMethod = method.rawValue
        // Add the headers
        for header in requestHeaders {
            request.addValue(header.value, forHTTPHeaderField: header.httpHeaderField)
        }
        // Set the body
        request.httpBody = body
        // Get the session
        let session = configuration.urlSession
        debugPrint("\(APIClient.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) makeAPICall \(DebuggingIdentifiers.actionOrEventInProgress) Entering Resquest with URL \(urlWithParameters)")
        // Make the API Call
        let dataTask = session.dataTask(with: request) { (responseData, _, responseError) in
            // See if there was an error
            if let responseError = responseError {
                debugPrint("\(APIClient.identifier) makeAPICall \(DebuggingIdentifiers.actionOrEventFailed) Failed to make API call with error : \(responseError).")
                completion(.failure(responseError))
                return
            }
            // Check that the data exists.
            guard let responseData = responseData else {
                debugPrint("\(APIClient.identifier) makeAPICall \(DebuggingIdentifiers.actionOrEventFailed) Failed to make API call as could not determine data.")
                completion(.failure(NetworkError.otherServerError))
                return
            }
            // Attempt to decode the response.
            let response: Response
            do {
                response = try JSONDecoder().decode(Response.self, from: responseData)
            } catch {
                debugPrint("\(APIClient.identifier) makeAPICall \(DebuggingIdentifiers.actionOrEventFailed) Failed to make API call with error \(error).")
                completion(.failure(error))
                return
            }
            debugPrint("\(APIClient.identifier) makeAPICall \(DebuggingIdentifiers.actionOrEventSucceded) Succefully made API call with response \(response).")
            completion(.success(response))
        }

        dataTask.resume()
    }

    /*
     loadLocal
     This is similar to that which we used for the LanguageCoordinator and is used to load local resources.
     */
    func loadLocal<T: Decodable>(resource: String, completion: @escaping ((Result<T, Error>) -> Void)) {
        do {
            if let loadedData = loadLocalResource(name: resource) {
                let data = try JSONDecoder().decode(T.self, from: loadedData)
                debugPrint("\(APIClient.identifier) loadLocal \(DebuggingIdentifiers.actionOrEventSucceded) Succesfully loaded resource \(data).")
                completion(.success(data))
            } else {
                debugPrint("\(APIClient.identifier) loadLocal \(DebuggingIdentifiers.actionOrEventFailed) Failed with error : Other Server Error.")
                completion(.failure(NetworkError.otherServerError))
            }
        } catch {
            debugPrint("\(APIClient.identifier) loadLocal \(DebuggingIdentifiers.actionOrEventFailed) Failed with error : \(error).")
            completion(.failure(error))
        }
    }

    /**
     - name: Name of the resource as you would load it from the main bundle, eg myFile.json
     */
    private func loadLocalResource(name: String) -> Data? {
        do {
            guard let filePath = Bundle.main.path(forResource: name, ofType: nil) else {
                debugPrint("\(APIClient.identifier) loadLocalResource \(DebuggingIdentifiers.actionOrEventFailed) Could not find filepath.")
                return nil
            }
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
            debugPrint("\(APIClient.identifier) loadLocalResource \(DebuggingIdentifiers.actionOrEventSucceded) Gathered Data for resource \(name).")
            return data

        } catch {
            return nil
        }
    }
}
