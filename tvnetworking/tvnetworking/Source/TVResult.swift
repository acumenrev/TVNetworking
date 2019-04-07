//
//  TVResult.swift
//  tvnetworking
//
//  Created by Tri Vo on 4/6/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import Foundation

enum TVResult<T> {
    case success(TVResponse<T>)
    case fail(TVHTTPError)
}
