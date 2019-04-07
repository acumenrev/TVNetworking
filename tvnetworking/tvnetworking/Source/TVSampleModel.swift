//
//  TVSampleModel.swift
//  tvnetworking
//
//  Created by Tri Vo on 4/6/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import Foundation

class TVSampleModel: Decodable {
    enum CodingKeys : String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
        case body = "body"
    }
    
    private(set) var userId : Int?
    private(set) var id : Int?
    private(set) var title : String?
    private(set) var body : String?
    
    
    required init(from decoder : Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        self.id = try values.decodeIfPresent(Int.self, forKey: .id)
        self.title = try values.decodeIfPresent(String.self, forKey: .title)
        self.body = try values.decodeIfPresent(String.self, forKey: .body)
    }
}
