//
//  ViewController.swift
//  ContentfulPoc
//
//  Created by Julian Arias Maetschl on 2/19/20.
//  Copyright © 2020 Maetschl. All rights reserved.
//

import UIKit
import Contentful

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomethingWithAPI()
    }

    func doSomethingWithAPI() {

        let classes: [EntryDecodable.Type] = [Person.self, Item.self]

        let client = Client(
            spaceId: "---",
            environmentId: "master",
            accessToken: "---",
            contentTypeClasses: classes
        )

        client.fetchArray(of: Item.self) { (result: Result<ArrayResponse<Item>>) in
            guard let items = result.value?.items else { return }
            print(items)
        }
        client.fetchArray(of: Person.self) { (result: Result<ArrayResponse<Person>>) in
            guard let persons = result.value?.items else { return }
            for person in persons {
                print(person.name)
            }
        }
    }

}


