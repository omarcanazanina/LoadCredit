//
//  BtnsView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct BtnsView: View {
    @Binding var currentBtn: BtnCA
     var text : String
    @Binding var montoRecarga : String
    var body: some View {
        VStack(spacing:1){
            // 10 20 30 50
            /*HStack{
                ButtonCreditAmountView(text: "10 Bs.", montoRecarga: self.$montoRecarga, currentBtn: self.$currentBtn, btn: .Btn10)
                    .padding(6)
                ButtonCreditAmountView(text: "20 Bs.", montoRecarga: self.$montoRecarga, currentBtn: self.$currentBtn, btn: .Btn20)
                .padding(6)
            }
            HStack{
                ButtonCreditAmountView(text: "30 Bs.", montoRecarga: self.$montoRecarga, currentBtn: self.$currentBtn, btn: .Btn30)
                .padding(6)
                ButtonCreditAmountView(text: "50 Bs.", montoRecarga: self.$montoRecarga, currentBtn: self.$currentBtn, btn: .Btn50)
                .padding(6)
            }*/
            HStack{
                ButtonCreditAmountView(text: "20 Bs.", montoRecarga: self.$montoRecarga, currentBtn: self.$currentBtn, btn: .Btn20)
                .padding(6)
                ButtonCreditAmountView(text: "50 Bs.", montoRecarga: self.$montoRecarga, currentBtn: self.$currentBtn, btn: .Btn50)
                .padding(6)
            }

            HStack{
                ButtonCreditAmountView(text: "100 Bs.", montoRecarga: self.$montoRecarga, currentBtn: self.$currentBtn, btn: .Btn100)
                .padding(6)
                
                if currentBtn != .BtnOther {
                    InputCreditAmountView(amounValue: self.$montoRecarga)
                    .padding(6)
                   // ButtonCreditAmountView(text: "Other", montoRecarga: self.$montoRecarga, currentBtn: self.$currentBtn, btn: .BtnOther)
                   // .padding()
                }
                /*else{
                    InputCreditAmountView(amounValue: self.$montoRecarga)
                    .padding()
                    
                }*/
                
               
            }
            
        }
    }
}

struct BtnsView_Previews: PreviewProvider {
    static var previews: some View {
        BtnsView(currentBtn: .constant(.Btn20),text: "", montoRecarga: .constant("10"))
    }
}



