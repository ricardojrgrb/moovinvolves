import UIKit
import AFNetworking

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var movies: [NSDictionary]? = nil
    var auxIndexPath = Int()
    var auxStringOverview = String()
    var auxStringPoster = String()
    var auxStringGenre = String()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func buttonSendData(_ sender: Any)
    {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchMovies()
    }
    
    func fetchMovies()
    {
        let apikey = "b33cd8a74217f802861c3789dd8acb46"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apikey)")
        let request = NSURLRequest(url: url! as URL, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 10)
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler:
        { (dataOrNil, response, error) in
            if let data = dataOrNil
            {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary
                {
                    print("response: \(responseDictionary)")
                    self.movies = responseDictionary["results"] as? [NSDictionary]
                    self.tableView.reloadData()
                }
            }
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies![indexPath.row] 
        let title = movie["title"] as! String
        let posterPath = movie["poster_path"] as! String
        let release_Date = movie["release_date"] as! String
        let overviewInfo = movie["overview"] as! String
        let genreIds = movie["genre_ids"] as! Array<Int>
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let imageUrl = NSURL(string: baseUrl + posterPath)
        
        auxStringOverview = overviewInfo
        auxStringPoster = posterPath
        auxStringGenre = "\(genreIds)"
        
        cell.posterView.setImageWith(imageUrl! as URL)
        cell.titleLabel.text = title
        cell.releaseDate.text = release_Date
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let aboutController = segue.destination as! AboutMovieViewController
        
        aboutController.stringRelDateRecv = cell.releaseDate.text!
        aboutController.stringOverviewRecv = auxStringOverview
        aboutController.stringPosterPathRecv = auxStringPoster
        aboutController.stringGenreRecv = auxStringGenre
    }
}
