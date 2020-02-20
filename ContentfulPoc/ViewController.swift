//
//  ViewController.swift
//  ContentfulPoc
//
//  Created by Julian Arias Maetschl on 2/19/20.
//  Copyright © 2020 Maetschl. All rights reserved.
//

import Contentful

class ViewController: UITableViewController {

    private var persons: [Person] = []
    private var client: Client?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        client = Configuration.client
        refreshData()
    }

    // MARK: - Handle RefreshControl -

    @objc
    func refreshData() {
        client?.fetchArray(of: Person.self) { [unowned self] (result: Result<HomogeneousArrayResponse<Person>>) in
            guard let result = result.value?.items else { return }
            self.persons = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }

    // MARK: - Table delegates -

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CustomTableViewCell.height
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CustomTableViewCell(persons: persons, indexPath: indexPath)
    }
}
