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
        let sort =  NSSortDescriptor(key: "date", ascending: false);
        request.sortDescriptors = [sort]

        do {
            let annotationsRecovered = try self.context.fetch(request);
            self.annotations = annotationsRecovered as! [NSManagedObject];
            self.tableView.reloadData();
        } catch let execption  {
            print("Erro: \(execption.localizedDescription)");
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }
    
    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        let annotationSelected = self.annotations[indexPath.row];
        self.performSegue(withIdentifier: "showAnnotation", sender: annotationSelected)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showAnnotation"{
            
            let viewDestiny = segue.destination as! AnnotationViewController;
            viewDestiny.annotation = sender as? NSManagedObject;    
            
        }
        
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            
            let annotation = self.annotations[indexPath.row];
            
            self.context.delete(annotation);
            self.annotations.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            do {
                try context.save()
                showAlert(sucess: true)
            } catch let execption  {
                print("Erro ao salvar anotação: \(execption.localizedDescription)");
                showAlert(sucess: false)
            }
        }
        
    }

    func dateFormatter(date: Date) -> String {
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        let newDate = dateFormatter.string(from: date);
        return newDate;
    }

    func showAlert(sucess: Bool){
        
        let textAlert: String = sucess ? "Nota Diária removida com sucesso!" : "Não foi possível removida a Nota Diária."
        
        //Configurando o alert
        let alertController = UIAlertController(
            title: "Notas Diárias - CoreData",
            message: textAlert,
            preferredStyle: UIAlertControllerStyle.alert
        )
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: UIAlertActionStyle.destructive) { (action) in
                // ...
        }
        
        let confirmAction = UIAlertAction(
        title: "OK", style: UIAlertActionStyle.default) { (action) in
            // ...
            //Retornar para tela princiap
            self.navigationController?.popToRootViewController(animated: true);
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }


}
