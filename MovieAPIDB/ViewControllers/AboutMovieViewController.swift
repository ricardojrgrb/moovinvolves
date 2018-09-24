import UIKit

class AboutMovieViewController: UIViewController
{
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var genreIdLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var stringRelDateRecv = String()
    var stringOverviewRecv = String()
    var stringPosterPathRecv = String()
    var stringGenreRecv = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let imageUrl = NSURL(string: baseUrl + stringPosterPathRecv)
        
        releaseDateLabel.text = stringRelDateRecv
        overviewLabel.text = stringOverviewRecv
        posterImageView.setImageWith(imageUrl! as URL)
        genreIdLabel.text = stringGenreRecv
    }
}
