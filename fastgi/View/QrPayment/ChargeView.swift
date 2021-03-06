//
//  ChargeView.swift
//  fastgi
//
//  Created by Hegaro on 11/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChargeView: View {
    var dataUserPay: UpdateUserPagoModel
    @State private var monto: String = ""
    var imageProfile:some View {
        HStack(alignment: .center){
                WebImage(url: URL(string: "https://i.postimg.cc/8kJ4bSVQ/image.jpg" ))
                    .onSuccess { image, data, cacheType in
                    }
                    .placeholder(Image( "user-default"))
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 100.0, height: 100.0)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    .overlay(
                        Circle()
                            .stroke(Color("card"), lineWidth: 2))
            
        }
        
    }
    var buttonSuccess:some View {
        VStack(){
            Button(action: {
             
            }){
                Text("Cobrar")
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity)
                    .padding(8)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                
            }
        }
        .padding()
    }
    
    
    var body: some View {
        VStack{
            Text("Cobrar")
                .font(.title)
            self.imageProfile
            Text("\(self.dataUserPay.nombres) \(self.dataUserPay.apellidos)")
            VStack(alignment: .leading, spacing: 8){
                Text("MONTO BS.")
                    .textStyle(TitleStyle())
                
                TextField("Ingrese monto", text: $monto)
                    .textFieldStyle(Input())
                    .keyboardType(.decimalPad)
                    .introspectTextField { (textField) in
                        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                        let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                        doneButton.tintColor = .darkGray
                        toolBar.items = [flexButton, doneButton]
                        toolBar.setItems([flexButton, doneButton], animated: true)
                        textField.inputAccessoryView = toolBar
                        textField.becomeFirstResponder()
                    }
            }
            self.buttonSuccess
            
        }
    }
}

/*struct ChargeView_Previews: PreviewProvider {
    static var previews: some View {
        ChargeView()
    }
}*/
