//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by John Tate on 9/7/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var summaryTextView: UITextView!
    
    // MARK: - Properties
    
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        
        guard let movie = movie else { return }
        titleLabel.text = movie.title
        ratingLabel.text = String(movie.rating)
        summaryTextView.text = movie.summary
    }
    
    
    
}
