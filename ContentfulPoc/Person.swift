//
//  Model.swift
//  ContentfulPoc
//
//  Created by Julian Arias Maetschl on 2/19/20.
//  Copyright © 2020 Maetschl. All rights reserved.
//

import Contentful

final class Person: EntryDecodable, FieldKeysQueryable, Resource {

    static var contentTypeId: ContentTypeId = "person"
    var sys: Sys
    var id: String
    var updatedAt: Date?
    var createdAt: Date?
    var localeCode: String?

    let name: String
    let image: Link?
    let location: Location?

    public required init(from decoder: Decoder) throws {
        sys         = try decoder.sys()
        id              = sys.id
        localeCode      = sys.locale
        updatedAt       = sys.updatedAt
        createdAt       = sys.createdAt
        let fields      = try decoder.contentfulFieldsContainer(keyedBy: Person.FieldKeys.self)
        self.name = try fields.decodeIfPresent(String.self, forKey: .name) ?? " "
        self.image = try fields.decodeIfPresent(Link.self, forKey: .image)
        self.location = try fields.decodeIfPresent(Location.self, forKey: .location)
    }

    enum FieldKeys: String, CodingKey {
        case name, image, location
    }

}
