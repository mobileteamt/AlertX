//
//  AlertX.swift
//  AlertX
//
//  Copyright © 2020 Neel Makhecha. All rights reserved.
//  https://github.com/neel-makhecha/AlertX

import SwiftUI

public struct AlertX: View {
    
    // Constant Parameters
    static let defaultCornerRadius: CGFloat = 25.0
    static let defaultShadowRadius: CGFloat = 1.0
    static let defaultAlertOpacity: Double = 0.9
    
    
    // Variable parameters
    var alertX_cornerRadius: CGFloat
    var alertX_shadowRadius: CGFloat
    var alertX_shadowColor: Color = Color.black
    
    // AlertX Fields
    var alertX_title: Text
    var alertX_message: Text?
    
    var buttonStack: [AlertX.Button]?
        
    // Theme and Animation
    var theme: AlertX.Theme = AlertX.Theme()
    var animation: AlertX.AnimationX = AlertX.AnimationX()
    
    public init(title: Text, message: Text? = nil, primaryButton: AlertX.Button? = .default(Text("OK")), secondaryButton: AlertX.Button? = nil, theme: AlertX.Theme = AlertX.Theme(), animation: AlertX.AnimationX = .defaultEffect()) {
        self.alertX_title = title
        self.alertX_message = message
        
        self.buttonStack = [primaryButton!]
        if let secondaryButton = secondaryButton {
            self.buttonStack?.append(secondaryButton)
        }
        
        self.theme = theme
        self.alertX_cornerRadius = theme.enableRoundedCorners ? theme.roundedCornerRadius : 0.0
        self.alertX_shadowRadius = theme.enableShadow ? AlertX.defaultShadowRadius : 0.0
        
        self.animation = animation
    }
    
    public init(title: Text, message: Text? = nil, buttonStack: [AlertX.Button] = [AlertX.Button.default(Text("OK"))], theme: AlertX.Theme = AlertX.Theme(), animation: AlertX.AnimationX = .defaultEffect()) {
        self.alertX_title = title
        self.alertX_message = message
        
        self.buttonStack = buttonStack
        
        self.theme = theme
        self.alertX_cornerRadius = theme.enableRoundedCorners ? theme.roundedCornerRadius : 0.0
        self.alertX_shadowRadius = theme.enableShadow ? AlertX.defaultShadowRadius : 0.0
        
        self.animation = animation
    }
    
    public var body: some View {
        
        ZStack {
            
            VStack {
                
                if #available(iOS 16.0, *) {
                    alertX_title
                        .padding(.init(top: 20, leading: 10, bottom: 10, trailing: 10))
                        .foregroundColor(theme.alertTextColor)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                } else {
                    alertX_title
                        .padding(.init(top: 20, leading: 10, bottom: 10, trailing: 10))
                        .foregroundColor(theme.alertTextColor)
                        .multilineTextAlignment(.center)
                }

                alertX_message
                    .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .foregroundColor(theme.alertTextColor)
                    .multilineTextAlignment(.center)

                Divider()

                    
                    if buttonStack != nil {
                        
                        if buttonStack!.count < 2 {
                            
                            HStack {
                                ForEach((0...(buttonStack?.count ?? 0)-1), id: \.self) {
                                    
                                    self.buttonStack?[$0]
                                        .background(self.buttonStack![$0].buttonType == AlertX.ButtonType.default ? self.theme.defaultButtonColor : self.theme.cancelButtonColor)
                                    .foregroundColor(self.buttonStack![$0].buttonType == AlertX.ButtonType.default ? self.theme.defaultButtonTextColor : self.theme.cancelButtonTextColor)
                                    .cornerRadius(self.theme.enableRoundedCorners ? theme.roundedCornerRadius : 0.0)
                                    
                                }
                            }
                            .padding()
                            
                        } else {
                            
                            VStack {
                                
                                ForEach((0...(buttonStack!.count)-1), id: \.self) {
                                    
                                        self.buttonStack?[$0]
                                            .background(self.buttonStack![$0].buttonType == AlertX.ButtonType.default ? self.theme.defaultButtonColor : self.theme.cancelButtonColor)
                                        .foregroundColor(self.buttonStack![$0].buttonType == AlertX.ButtonType.default ? self.theme.defaultButtonTextColor : self.theme.cancelButtonTextColor)
                                        .cornerRadius(self.theme.enableRoundedCorners ? theme.roundedCornerRadius : 0.0)
                                            .padding(.bottom, 0)
                                    
                                    Divider()
                                    
                                }
                                
                            }
                            .frame(height: 120)
//                            .padding()

                        }
                        
                    }
                    
            }.background(AlertX.Window(color: theme.windowColor, cornerRadius: self.theme.enableRoundedCorners ? theme.roundedCornerRadius : 0.0, transparencyEnabled: theme.enableTransparency))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .padding(.trailing, 50)
                .padding(.leading, 50)
                .shadow(radius: alertX_shadowRadius)
                .cornerRadius(alertX_cornerRadius)
            
        }
        
    }
}

