//
//  ListAnnotationsController.swift
//  Notas Diarias
//
//  Created by Vinícius Rodrigues Duarte on 05/07/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit
import CoreData
class ListAnnotationsController: UITableViewController {
    
    var context: NSManagedObjectContext!
    var annotations: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // recuperar o contexto para o CoreData
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        context = appDelegate.persistentContainer.viewContext;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getAnnotations();
    }
    
    func getAnnotations(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Annotation");

        do {
            let annotationsRecovered = try self.context.fetch(request);
            self.annotations = annotationsRecovered as! [NSManagedObject];
            self.tableView.reloadData();
        } catch let execption as Error {
            print("Erro: \(execption.localizedDescription)");
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.annotations.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAnnotation", for: indexPath)

        // Configure the cell...
        let annotation = self.annotations[indexPath.row];
        let textAnnotation = annotation.value(forKey: "text");
        let date = annotation.value(forKey: "date") as! Date;
        cell.textLabel?.text = textAnnotation as? String
        cell.detailTextLabel?.text = dateFormatter(date: date) ;
        return cell
    }

    func dateFormatter(date: Date) -> String {
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        let newDate = dateFormatter.string(from: date);
        return newDate;
    }



}
