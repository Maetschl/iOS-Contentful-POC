//
//  Configuration.swift
//  ContentfulPoc
//
//  Created by Julian Arias Maetschl on 2/20/20.
//  Copyright © 2020 Maetschl. All rights reserved.
//

import Contentful

struct Configuration {
    static let classes: [EntryDecodable.Type] = [Person.self]
    static let client = Client(
        spaceId: "",
        environmentId: "master",
        accessToken: "",
        contentTypeClasses: classes
    )
}
