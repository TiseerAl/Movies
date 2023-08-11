//
//  MovieDetailsTableViewController.swift
//  MovieApp
//
//  Created by We Write Software on 30/03/2023.
//

import UIKit

class MovieDetailsTableViewController: UITableViewController {

    //MARK: Properties
    var movie: MovieModel?
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

       main()
    }
    
    //MARK: Functions
    private func main() {
        
        registerCell()
    }
    
    private func registerCell() {
        
        tableView.register(UINib(nibName: MovieDetailsTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MovieDetailsTableViewCell.cellIdentifier)
    
    }
    
    // MARK: - Table view data sourcs
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableViewCell.cellIdentifier, for: indexPath) as? MovieDetailsTableViewCell,
            let movie = movie else {return UITableViewCell()}
        
        cell.selectionStyle = .none
        cell.configureCell(movie: movie)
        return cell
    }
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
