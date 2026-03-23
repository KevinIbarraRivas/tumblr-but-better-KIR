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

        if let photo = post.photos.first {
            let url = photo.originalSize.url
            NukeExtensions.loadImage(with: url, into: postImageView)
        }


        captionTextView.text = post.caption.trimHTMLTags()

        captionTextView.isEditable = false
    }
}
