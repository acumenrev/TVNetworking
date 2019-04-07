//
//  TVHTTPError.swift
//  tvnetworking
//
//  Created by Tri Vo on 4/6/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import Foundation

enum TVHTTPError : Error {
    case badRequest(Data?)
    case invalidURL
    case requestFailed
    case decodingFailure
    case unauthorized(Data?)
    case notFound
    case serverError(Data?)
    case requestTimeOut
    case notReachable(Int)
    case forbidden(Data?)
    case unknownError(Int, Data?)
}
