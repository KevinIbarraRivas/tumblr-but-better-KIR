//
//  ViewController.swift
//  ios101-project5-tumblr
//

import UIKit
import Nuke
import NukeExtensions

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchPosts()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
        tableView.refreshControl = refreshControl

        // Set navigation bar title
        title = "Blog Posts"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // Deselects the tapped row when you come back from the detail screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.summaryLabel.text = post.summary
        if let photo = post.photos.first {
            let url = photo.originalSize.url
            NukeExtensions.loadImage(with: url, into: cell.postImageView)
        }
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }

        let selectedPost = posts[selectedIndexPath.row]

        guard let detailViewController = segue.destination as? DetailViewController else { return }


        detailViewController.post = selectedPost
    }

    // MARK: - Networking

    func fetchPosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/tumbirbs/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }
            guard let data = data else {
                print("❌ Data is NIL")
                return
            }
            do {
                let blog = try JSONDecoder().decode(Blog.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.posts = blog.response.posts
                    self?.tableView.reloadData()
                    print("✅ Got \(blog.response.posts.count) posts!")
                }
            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }

    @objc func refreshPosts() {
        fetchPosts()
        tableView.refreshControl?.endRefreshing()
    }
}
