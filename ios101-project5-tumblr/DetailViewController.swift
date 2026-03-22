//
//  DetailViewController.swift
//  ios101-project5-tumblr
//

import UIKit
import NukeExtensions

class DetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!

    // MARK: - Properties
    var post: Post!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Post Details"

        // Load the post's image
        if let photo = post.photos.first {
            let url = photo.originalSize.url
            NukeExtensions.loadImage(with: url, into: postImageView)
        }

        // Strip the HTML tags from the caption and show it
        // trimHTMLTags() comes from String+Extensions.swift
        captionTextView.text = post.caption.trimHTMLTags()

        // Make the text view read-only so the keyboard doesn't pop up
        captionTextView.isEditable = false
    }
}
