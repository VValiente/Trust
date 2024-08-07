//
//  MockURLProtocol.swift
//  TrustTests
//
//  Created by Vilma Valiente on 7/8/24.
//

import Foundation

class MockURLProtocol: URLProtocol {

    // MARK: - Mock Properties

    static var responseData: Data?
    static var responseStatusCode: Int = 200
    static var error: Error?

    // MARK: - Mock APIs

    static func resetMock() {
        responseData = nil
        responseStatusCode = 200
        error = nil
    }

    // MARK: - URLProtocol

    override class func canInit(with _: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: MockURLProtocol.responseStatusCode,
                httpVersion: "HTTP/1.1",
                headerFields: nil
            )!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            if let data = MockURLProtocol.responseData {
                client?.urlProtocol(self, didLoad: data)
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
