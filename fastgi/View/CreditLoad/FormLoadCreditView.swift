//
//  FormLoadCreditView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI
import Introspect

struct FormLoadCreditView: View {
    var contContacts : Int 
    var empresa: String
    @State  var SelectEm :BtnEm
    @State private  var telefono = ""
    @State var MontoRecarga1: BtnCA
    @State  var MontoRecarga = ""
    @ObservedObject var RecargaVM = RecargaViewModel()
    //contacts
    @ObservedObject var contactsVM1 = ImportContactsViewModel()
    @ObservedObject var contactsVM = ContactsViewModel()
    @ObservedObject var contacts = Contacts()
    //navegation
    @State private var action:Int? = 0
    //
    @State var showingSheet = false
    @State private  var nombreContact = ""
    
    //alert
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var alertState: Bool = false
    //navegation
    var navigationRoot = NavigationRoot()
    
    /*init(SelectEm: BtnEm, Empresa: String, MontoRecarga1: BtnCA, montorecarga: String) {
        self.SelectEm = SelectEm
        self.empresa = Empresa
        self.MontoRecarga1 = MontoRecarga1
        self.MontoRecarga = montorecarga
       /* self.SelectEm = SelectEm
        self.MontoRecarga1 = montoRecarga1
        self.MontoRecarga = montoRecarga*/
        self.contactsVM.getContacts()
    }*/
    var home: some View {
        ScrollView{
            //botones de la empresa
            HStack{
                BtnsEmView(currentBtnEm: $SelectEm)
            }.padding()
            VStack{
                //campo para ingresar numero de contacto
                HStack{
                    TextField("Número de teléfono \(self.contContacts)", text: $telefono)
                        .padding(.horizontal,12)
                        .padding(.vertical,8)
                        .keyboardType(.numberPad)
                        //.cornerRadius(25)
                        .introspectTextField { (textField) in
                            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                            let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                            let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                         doneButton.tintColor = .darkGray
                            toolBar.items = [flexButton, doneButton]
                            toolBar.setItems([flexButton, doneButton], animated: true)
                            textField.inputAccessoryView = toolBar
                         }
                    Button(action: {
                        //if self.contactsVM.listContacts.count == 0{
                            if self.contContacts == 0{
                                print("no hay contactos")
                                print(self.contContacts)
                                //self.contacts.sendContacts()
                                self.contactsVM.importContacts()
                                self.contactsVM.getContacts()
                                self.navigationRoot.setRootView()
                                //self.showingSheet.toggle()
                            
                            }else{
                                print("si hay contactos")
                                print(self.contContacts)
                                self.showingSheet.toggle()
                            }
                    })
                    {
                        Image(systemName: "person.2")
                            .foregroundColor(Color("primary"))
                            .padding(12)
                    }
                    .onReceive(self.contactsVM.$controlContacts) { (contacts) in
                        if contacts == true {
                            print("entro onreceive e importo")
                            self.contactsVM.getContacts()
                        }
                    }
                    //ListcontactsView
                    .sheet(isPresented: $showingSheet) {
                        ListContactsView(showingSheet: self.$showingSheet, telefono: self.$telefono, nombre: self.$nombreContact, modal: self.$showingSheet)
                    }
                    //end
                }.background(Color("input"))
                //.border(Color.white, width: 2)
                //.cornerRadius(25)
                //.clipShape(Capsule())
            }.padding()
            //Card select
            NavigationLink(destination: SelectCreditCardView()) {
                HStack{
                    Text("Seleccionar tarjeta")
                        .foregroundColor(Color.primary)
                        .padding(.horizontal,12)
                        .padding(.vertical,8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
                .background(Color("input"))
                        .clipShape(Capsule())
                .padding(.horizontal)
            }
            // amounts select
           //lista de contactos
            //if self.contactsVM.listComplete == false {
              //  Loader()
            //}
            VStack{
                ContentButtonsView(currentBtn: $MontoRecarga1, text: "", montoRecarga: $MontoRecarga)
                Button(action: {
                    print(self.SelectEm)
                    print(self.MontoRecarga1)
                    print(self.MontoRecarga)
                    print(self.telefono)
                    if  self.telefono == "" {
                        self.alertState = true
                    }else{
                        if self.MontoRecarga == ""{
                            self.RecargaVM.SendRecarga(empresa: self.SelectEm, recarga: "30", telefono: self.telefono,  text: "")
                        }else{
                            self.RecargaVM.SendRecarga(empresa: self.SelectEm, recarga: self.MontoRecarga, telefono: self.telefono,  text: "")
                        }
                            self.action = 1
                    }
                }){
                    Text("Aceptar")
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity)
                    .padding(8)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    .padding()
                        
                }
                
            }
            //end
            if self.RecargaVM.control != ""{
                NavigationLink(destination: TransactionDetailView(fecha: "", hora: "", empresa:  self.RecargaVM.recargaData.empresa, phone: self.RecargaVM.recargaData.telefono, monto: self.RecargaVM.recargaData.recarga, control: 1, fechaFormat: "", horaFormat: ""), tag: 1, selection: self.$action) {
                        EmptyView()
                }
                
            }
        }
    }
    
    var alerts:Alert{
        Alert(title: Text("Fastgi"), message: Text("Ingrese todos los campos por favor."), dismissButton: .default(Text("Aceptar"), action: {
            //self.presentationMode.wrappedValue.dismiss()
        }))
    }
    
    
    var body: some View {
        VStack{
            /*if self.contactsVM.listComplete == false{
                self.home
                    .padding(.leading)
                    .padding(.top,80)
                    .disabled(true)
            }else{*/
                self.home
                    .padding(.leading)
                    .padding(.top,80)
            //}
        }.alert(isPresented:  self.$alertState){
            self.alerts
        }
        .edgesIgnoringSafeArea(.top)
        //llamado desde ContactsViewModel
         .onAppear{
            //self.userDataVM.DatosUser()
          //  self.contactsVM.getContacts()
        }
    }
}

struct FormLoadCreditView_Previews: PreviewProvider {
    static var previews: some View {
       // FormLoadCreditView(SelectEm: .Entel, montoRecarga1: .Btn10, montoRecarga: "")
        FormLoadCreditView(contContacts: 0, empresa: "", SelectEm: .Tigo, MontoRecarga1: .Btn30, MontoRecarga: "")
    }
}
