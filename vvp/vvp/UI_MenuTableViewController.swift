//
//  UI_MenuTableViewController.swift
//  vvp
//
//  Created by Andrey Kotlyarov on 08.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit

class UI_MenuTableViewController: UITableViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        tableView.tintColor = VIM_DesignData.current.colorRed
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var rowsCount = 0
        
        switch section
        {
            case 0:
                rowsCount = 1
            case 1:
                rowsCount = 2
            case 2:
                rowsCount = 1
            default:
                rowsCount = 0
        }
        
        // #warning Incomplete implementation, return the number of rows
        return rowsCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text = ""
        
        
        if indexPath.section == 0
        {
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.textLabel?.text = "Organization"
        }
        
        if indexPath.section == 1
        {
            cell.accessoryType = UITableViewCellAccessoryType.detailButton
            
            if indexPath.row == 0
            {
                cell.textLabel?.text = "Viewer"
            }
            if indexPath.row == 1
            {
                cell.textLabel?.text = "Streamer"
            }
        }
        
        if indexPath.section == 2
        {
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.textLabel?.text = "Profile"
        }
        // Configure the cell...

        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        //return true
        
        return false
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert
        {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the item to be re-orderable.
        //return true
        
        return false
    }
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if indexPath.section == 0
        {
            performSegue(withIdentifier: "vilMenuToOrg", sender: self)
        }
        
        if indexPath.section == 1
        {
            
            if indexPath.row == 0
            {
                //TODO
            }
            if indexPath.row == 1
            {
                //TODO
                let sb = UIStoryboard.init(name: "Stream", bundle: nil)
                let vcStream = sb.instantiateViewController(withIdentifier: "visStream") as! VIS_StreamViewController
                self.present(vcStream, animated: true, completion: nil)
            }
        }
        
        if indexPath.section == 2
        {
            performSegue(withIdentifier: "vilMenuToProfile", sender: self)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
