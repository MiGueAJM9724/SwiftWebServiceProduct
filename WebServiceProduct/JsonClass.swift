//
//  JsonClass.swift
//  WebServiceProduct
//
//  Created by Jimenez Melendez Miguel Angel on 05/05/20.
//  Copyright © 2020 Jimenez Melendez Miguel Angel. All rights reserved.
//

import Foundation
import UIKit

class JsonClass: NSObject {

    //constantes de nuestra clase
    let urlBase = "http://192.168.64.2/"//url del servidor remoto
    
    let key = "123456abcde"//key que autoriza nuestra app para extrauer datos
    let model = UIDevice.current.model//modelo del dispositivo iPhone / iPod / iPad
    let iddevice = UIDevice.current.identifierForVendor!.uuidString//
    let langStr = Locale.current.languageCode!//idioma del dispositivo
    let fecha = "2020-05-05"
    //funcion recibe el array JSON desde el servidor remoto y lo convierte en array tipo NSArray
    /*los parametros de entrada son:
    url -> nombre del archivo .php que va a procesar nuestra solicitud
    datos_enviados -> array de datos que vamos a enviar via POST
    */
    func arrayFromJson(url:String,send_data:NSMutableDictionary, completionHandler: @escaping (NSArray?) -> Void){
        
            //Concatenamos nuestr url base con el archivo .php que va a procesar la solicitud
                let url = URL(string: "\(urlBase)/\(url)")!
                //convertimos la constante url a tipo URLRequest
                var request = URLRequest(url: url)
            
                //establecemos las cabeceras de la petición JSON estándar
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
                request.httpMethod = "POST"//puede ser GET pero por seguridad siempre sera POST
            
                /*
                En las siguientes 4 lineas vamos a concatenar o empujar nuevos valores al array de datos que enviaremos al servidor remoto.
                NOTA. Aquí puedes concatenar otros valores que consideres necesarios para la solicitud por ejemplo
                *latitud, longitud y altitud del usuario
                *fecha local del dispositivo
                *Medidas de los sensores (Acelerómetro. giroscopio, sensor de luz, etc)
                
                datos_enviados["key"] = key
                datos_enviados["lenguaje"] = langStr
                datos_enviados["model"] = model
                datos_enviados["iddevice"] = iddevice
                datos_enviados["fecha"] = fecha*/
            
                //Convertimos  el array en formato JSON antes de ser enviada
                request.httpBody = try! JSONSerialization.data(withJSONObject: send_data)
            
                //realizamos la petición al servidor remoto
            
                let task = URLSession.shared.dataTask(with: request) { data_received, response, error in
                    if error != nil{//detectamos un error y devolvemos el array vacío
                        completionHandler(nil)
                    }
                    else{
                        //tratamos de convertir la respuesta en array
                        do {
                            //imprimimos en consola los datos enviados y los datos recibidos en modo debug
                            print("Data received: \(String(describing: String(data: data_received!, encoding: .utf8))) - data received: \(send_data)")
                           
                            //Convertimos el JSON recibido del servidor remoto en formato array para ser tratado por el dispositivo
                            if let array = try JSONSerialization.jsonObject(with: data_received!) as? NSArray {
                                //comletionHandler -> devuelve el array, es equivalente en otros lenguajes a  return(array)
                                completionHandler(array)
                            }
                        } catch let parseError {
                            //Existe un error en el formato JSON, imprimimos en consola la respuesta para localizar el error
                            print("error PHP server \(String(data: data_received!, encoding: .utf8)) \(parseError)")
                            //detectamos un error y devolvemos el array vacío
                            completionHandler(nil)
                        }
                    }
                }
                task.resume()
    }
    
}
