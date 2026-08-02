<div>
    <a href="https://www.loom.com/share/b9cfdf8a1ee34948af042006a5410686">
    </a>
    <a href="https://www.loom.com/share/b9cfdf8a1ee34948af042006a5410686">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/b9cfdf8a1ee34948af042006a5410686-21152159d29f8f18-full-play.gif#t=0.1">
    </a>
  </div>

# Tumblr BIRB

An iOS app that displays a feed of Tumblr blog posts — tap any post to open a detail screen with the full image and caption. Built in Swift.

## Features

- Scrollable feed of blog posts
- Detail screen for each post with the full image and caption
- Pull to refresh on the main feed
- Large title on the feed that collapses as you scroll
- Rows deselect automatically when you navigate back
- Captions have their HTML tags stripped for clean display

## What I learned

Most of the challenge was in the storyboard: embedding the existing view controller in a Navigation Controller, creating the segue from the post cell to the detail view controller, and connecting the IBOutlets through the Assistant Editor.

## Running it

1. Clone the repo
2. Open `ios101-project5-tumblr.xcodeproj` in Xcode
3. Build and run

## License

Apache 2.0 — see LICENSE for details.
