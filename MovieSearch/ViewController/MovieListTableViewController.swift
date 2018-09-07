//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by John Tate on 9/7/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.estimatedRowHeight = 550
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text else { return }
        
        MovieController.shared.searchForMovies(searchText: searchText) { (movie) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        // dismisses the keyboard
        searchBar.resignFirstResponder()
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieController.shared.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = MovieController.shared.movies[indexPath.row]
        
        cell.movie = movie
        MovieController.shared.fetchPoster(movie: movie) { (image) in
            DispatchQueue.main.async {
                cell.posterImage.image = image
            }
        }
    
        return cell
    }
}
