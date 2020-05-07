//
//  ViewController.swift
//  WebServiceProduct
//
//  Created by Jimenez Melendez Miguel Angel on 04/05/20.
//  Copyright © 2020 Jimenez Melendez Miguel Angel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtid_product: UITextField!
    @IBOutlet weak var txtproduct_name: UITextField!
    @IBOutlet weak var txtexistence: UITextField!
    @IBOutlet weak var txtprice: UITextField!
    @IBOutlet weak var lbmessage: UILabel!
    
    //Instancia de nuestra clase menejadora de nuestras peticiones al servidor remoto
    var products = [Product]()
    let dataJsonUrlClass = JsonClass()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnAdd_product(_ sender: UIButton) {
        if txtproduct_name.text!.isEmpty || txtexistence.text!.isEmpty || txtprice.text!.isEmpty{
                   showAlerta(title: "Input validation", message: "Error missing input data")
                   txtproduct_name.becomeFirstResponder()
                   return
               }
               else{
                       //extraemos el valor del campo de texto (ID usuario)
                       let product_name = txtproduct_name.text
                       let existence = txtexistence.text
                       let price = txtprice.text
                   
                   //Creamos un array (diccionario) de datos para ser enviados en la petición hacia el servidor remoto, aqui pueden existir N cantidad de va!lores
                   let sendData = ["name_product": product_name!,"existence":existence!,"price":price!] as NSMutableDictionary
                       
                       //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
                       
                   dataJsonUrlClass.arrayFromJson(url:"webservice/insertproduct.php",send_data: sendData){ (array_respuesta) in
                           
                           DispatchQueue.main.async {//proceso principal
                               let data_dictionary = array_respuesta?.object(at: 0) as! NSDictionary
                               
                               //ahora ya podemos acceder a cada valor por medio de su key "forKey"
                               if let msg = data_dictionary.object(forKey: "message") as! String?{
                                   self.showAlerta(title: "Saved", message: msg)
                               }
                               self.txtid_product.text=""
                               self.txtproduct_name.text = ""
                               self.txtexistence.text = "0"
                               self.txtprice.text = "0"
                           }
                       }
               }
    }
    @IBAction func btnDelete_product(_ sender: UIButton) {
        if txtid_product.text!.isEmpty {
                   showAlerta(title: "Input validation", message: "Error missing input data")
                   txtid_product.becomeFirstResponder()
                   return
               }
               else{
                       let id_product = txtid_product.text!
                   
                       //Creamos un array (diccionario) de datos para ser enviados en la petición hacia el servidor remoto, aqui pueden existir N cantidad de valores
                   let sendData = ["id_product":id_product] as NSMutableDictionary
                       
                       //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
                       
                       dataJsonUrlClass.arrayFromJson(url:"webservice/deleteproduct.php",send_data: sendData){ (array_respuesta) in
                           
                           DispatchQueue.main.async {//proceso principal
                               
                               /*
                                recibimos un array de tipo:
                                (
                                    [0] => Array
                                    (
                                        [success] => 200
                                        [message] => Producto Actualizado
                                    )
                                )
                                object(at: 0) as! NSDictionary -> indica que el elemento 0 de nuestro array lo vamos a convertir en un diccionario de datos.
                                */
                               let data_dictionary = array_respuesta?.object(at: 0) as! NSDictionary
                               
                               //ahora ya podemos acceder a cada valor por medio de su key "forKey"
                               if let msg = data_dictionary.object(forKey: "message") as! String?{
                                   self.showAlerta(title: "Removing", message: msg)
                               }
                               
                               self.txtid_product.text=""
                               self.txtproduct_name.text = ""
                               self.txtexistence.text = "0"
                               self.txtprice.text = "0"
                           }
                       }
               }// Fin del else
    }
    @IBAction func btnUpdate_product(_ sender: UIButton) {
        if txtid_product.text!.isEmpty || txtproduct_name.text!.isEmpty || txtexistence.text!.isEmpty || txtprice.text!.isEmpty{
            showAlerta(title: "Input validation", message: "Error missing input data")
            txtid_product.becomeFirstResponder()
            return
        }
        else{
                let id_product = txtid_product.text!
                let product_name = txtproduct_name.text!
                let existence = txtexistence.text!
                let price = txtprice.text!
            
                //Creamos un array (diccionario) de datos para ser enviados en la petición hacia el servidor remoto, aqui pueden existir N cantidad de valores
            let sendData = ["id_product":id_product, "name_product": product_name,"existence":existence,"price":price] as NSMutableDictionary
                
                //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
                
                dataJsonUrlClass.arrayFromJson(url:"webservice/updateproduct.php",send_data: sendData){ (array_respuesta) in
                    
                    DispatchQueue.main.async {//proceso principal
                        
                        /*
                         recibimos un array de tipo:
                         (
                             [0] => Array
                             (
                                 [success] => 200
                                 [message] => Producto Actualizado
                             )
                         )
                         object(at: 0) as! NSDictionary -> indica que el elemento 0 de nuestro array lo vamos a convertir en un diccionario de datos.
                         */
                        let data_dictionary = array_respuesta?.object(at: 0) as! NSDictionary
                        
                        //ahora ya podemos acceder a cada valor por medio de su key "forKey"
                        if let msg = data_dictionary.object(forKey: "message") as! String?{
                            self.showAlerta(title: "Saved", message: msg)
                        }
                        
                        self.txtid_product.text=""
                        self.txtproduct_name.text = ""
                        self.txtexistence.text = "0"
                        self.txtprice.text = "0"
                    }
                }
        }// Fin del else
    }
    @IBAction func btnSearch_product(_ sender: UIButton) {
        //borramos el contenidod e todos los text
               txtproduct_name.text = ""
               txtexistence.text = ""
               txtprice.text = ""
               
               //extraemos el valor del campo de texto (ID usuario)
               let id_usuario = txtid_product.text

               //si idText.text no tienen ningun valor terminamos la ejecución
               if id_usuario == ""{
                   return
               }
               
               //Creamos un array (diccionario) de datos para ser enviados en la petición hacia el servidor remoto, aqui pueden existir N cantidad de valores
               let sendData = ["id_product": id_usuario!] as NSMutableDictionary
               
               //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
               
               dataJsonUrlClass.arrayFromJson(url:"webservice/getproduct.php",send_data: sendData){ (array_respuesta) in
                   
                   DispatchQueue.main.async {//proceso principal
                       
                       /*
                        recibimos un array de tipo:
                        (
                            [0] => Array
                            (
                                [success] => 200
                                [message] => Producto encontrado
                                [idProd] => 1
                                [nomProd] => Desarmador plus
                                [existencia] => 10
                                [precio] => 80
                            )
                        )
                        object(at: 0) as! NSDictionary -> indica que el elemento 0 de nuestro array lo vamos a convertir en un diccionario de datos.
                        */
                       let diccionario_datos = array_respuesta?.object(at: 0) as! NSDictionary
                       
                       //ahora ya podemos acceder a cada valor por medio de su key "forKey"
                       if let msg = diccionario_datos.object(forKey: "message") as! String?{
                           self.lbmessage.text = msg
                       }
                       
                       if let nom = diccionario_datos.object(forKey: "name_product") as! String?{
                           self.txtproduct_name.text = nom
                       }
                       
                       if let exi = diccionario_datos.object(forKey: "existence") as! String?{
                           self.txtexistence.text = exi
                       }
                       
                       if let pre = diccionario_datos.object(forKey: "price") as! String?{
                           self.txtprice.text = pre
                       }
                   }
               }
    }
    @IBAction func btnLoad_product(_ sender: UIButton) {
        products.removeAll()
        let sendData = ["id_product": ""] as NSMutableDictionary
        
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        
        dataJsonUrlClass.arrayFromJson(url:"webservice/getproducts.php", send_data: sendData ){ (array_respuesta) in
            
            DispatchQueue.main.async {//proceso principal
                
                /*
                 recibimos un array de tipo:
                 (
                     [0] => Array
                     (
                         [success] => 200
                         [message] => Producto encontrado
                         [idProd] => 1
                         [nomProd] => Desarmador plus
                         [existencia] => 10
                         [precio] => 80
                     )
                 )
                 object(at: 0) as! NSDictionary -> indica que el elemento 0 de nuestro array lo vamos a convertir en un diccionario de datos.
                 */
                let cuenta = array_respuesta?.count
                
                for indice in stride(from: 0, to: cuenta!, by: 1){
                    let product = array_respuesta?.object(at: indice) as! NSDictionary
                    let id_product = product.object(forKey: "id_product") as! String?
                    let name_product = product.object(forKey: "name_product") as! String?
                    let existence = product.object(forKey: "existence") as! String?
                    let price = product.object(forKey: "price") as! String?
                    self.products.append(Product(id_product: id_product, product_name: name_product, existence: existence, price: price))
                }
                self.performSegue(withIdentifier: "Segue_table_product", sender: self)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "Segue_table_product"{
            let segue_table_product = segue.destination as! TableViewControllerProduct
            segue_table_product.products = products
        }
    }
    func showAlerta(title: String, message: String ){
       // Crea la alerta
      let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
      // Agrega un boton
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
     // Muestra la alerta
     self.present(alert, animated: true, completion: nil)
    }
}

