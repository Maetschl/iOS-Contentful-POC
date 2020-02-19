//
//  Model.swift
//  ContentfulPoc
//
//  Created by Julian Arias Maetschl on 2/19/20.
//  Copyright © 2020 Maetschl. All rights reserved.
//

import Contentful

final class Item: EntryDecodable, FieldKeysQueryable {
    static var contentTypeId: ContentTypeId = "item"
    var id: String
    var updatedAt: Date?
    var createdAt: Date?
    var localeCode: String?

    let title: String
    let value: Int
    let active: Bool

    public required init(from decoder: Decoder) throws {
        let sys         = try decoder.sys()
        id              = sys.id
        localeCode      = sys.locale
        updatedAt       = sys.updatedAt
        createdAt       = sys.createdAt

        let fields      = try decoder.contentfulFieldsContainer(keyedBy: Item.FieldKeys.self)

        self.title = try fields.decodeIfPresent(String.self, forKey: .title) ?? " "
        self.value = try fields.decodeIfPresent(Int.self, forKey: .value) ?? 0
        self.active = try fields.decodeIfPresent(Bool.self, forKey: .active) ?? false
    }


    enum FieldKeys: String, CodingKey {
        case title
        case value
        case active
    }

}


final class Person: EntryDecodable, FieldKeysQueryable, Resource {
    static var contentTypeId: ContentTypeId = "person"
    var sys: Sys

    var id: String
    var updatedAt: Date?
    var createdAt: Date?
    var localeCode: String?

    let name: String

    public required init(from decoder: Decoder) throws {
        sys         = try decoder.sys()
        id              = sys.id
        localeCode      = sys.locale
        updatedAt       = sys.updatedAt
        createdAt       = sys.createdAt

        let fields      = try decoder.contentfulFieldsContainer(keyedBy: Person.FieldKeys.self)

        self.name = try fields.decodeIfPresent(String.self, forKey: .name) ?? " "
    }


    enum FieldKeys: String, CodingKey {
        case name
    }

}
