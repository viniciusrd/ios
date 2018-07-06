//
//  AnnotationViewController.swift
//  Notas Diarias
//
//  Created by Vinícius Rodrigues Duarte on 05/07/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit
import CoreData

class AnnotationViewController: UIViewController {

    @IBOutlet weak var labelText: UITextView!
    var context: NSManagedObjectContext!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configuracoes iniciais
        // abrir o teclado
        self.labelText.becomeFirstResponder();
        self.labelText.text = ""

        // recuperar o contexto para o CoreData
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        context = appDelegate.persistentContainer.viewContext;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func saveAnnotation(){
        
        //cria objeto para anotacao
        let newAnnotation = NSEntityDescription.insertNewObject(forEntityName: "Annotation", into: context);
        //configura anotacao
        newAnnotation.setValue(self.labelText.text, forKey: "text");
        newAnnotation.setValue(Date(), forKey: "date");
        
        do {
            try context.save()
            showAlert(sucess: true)
        } catch let execption as Error {
            print("Erro ao salvar anotação: \(execption.localizedDescription)");
            showAlert(sucess: false)
        }
        
    }
    
    func showAlert(sucess: Bool){
        
        let textAlert: String = sucess ? "Nota Diária salva com sucesso!" : "Não foi possível salvar a Nota Diária."
        
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
        
    

    @IBAction func save(_ sender: Any) {
        
        if self.labelText.text != nil{
            self.saveAnnotation();
        }
        
        
        
    }

}
