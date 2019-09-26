//
//  MovieTableViewController.swift
//  MovieSearchObjC1
//
//  Created by Lewis Jones on 04/03/2019.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation
import UIKit


class MovieTableViewController: UITableViewController, UISearchBarDelegate  {
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    var movies: [RPAMovie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Getting the search term
        guard let searchText = movieSearchBar.text, !searchText.isEmpty else { return }
        // Network call
        RPAMovieController.shared().fetchMovies(withSearchTerm: searchText) { [weak self] (movies, error) in
            guard error == nil else { return }
            // update UI if there is no error
            self?.movies = movies
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.movieSearchBar.text = ""
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    //      guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieSearchTableViewCell", for: indexPath) as? MovieSearchTableViewCell else { return UITableViewCell() }
    override    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieSearchTableViewCell else { return UITableViewCell() }
        let movieItem = movies[indexPath.row]
        cell.movie = movieItem
        
        return cell
    }
    
}
//
//extension MovieSearchTableViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        // Getting the search term
//        guard let searchText = movieSearchBar.text, !searchText.isEmpty else { return }
//        // Network call
//        RPAMovieController.shared().fetchMovies(withSearchTerm: searchText) { [weak self] (movies, error) in
//            guard error == nil else { return }
//            // update UI if there is no error
//            self?.movies = movies
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//                self?.searchBar.text = ""
//            }
//        }
//    }
//}
