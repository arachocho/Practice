//
//  ContentView.swift
//  Calculator
//
//  Created by 조아라 on 10/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var inputValue = "0"
    
    let buttons = [
        ["7", "8", "9", "/"],
        ["4", "5", "6", "*"],
        ["1", "2", "3", "-"],
        [".", "0", "C", "+"],
        ["="]
        ]
    
    var body: some View {
        VStack {
            Text(inputValue)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 50))
            
                .padding()
                .background(Color.cyan.opacity(0.2))
            
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { buttonChar in
                        Button(action: {
                            buttonTapped(buttonChar)
                        }) {
                            Text(buttonChar)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .font(.system(size: 30))
                                .foregroundStyle(buttonChar == "C" ? .red : .black)
                                .border(Color.cyan, width: 1)
                                .cornerRadius(3)
                    }
                }
            }
        }
    }
}
    
    func buttonTapped(_ button: String) {
        if (inputValue == "0") {
            inputValue = ""
        }
        switch button {
        case "=":
            calculate()
        case "C":
            inputValue = "0"
        case "+", "-", "*", "/" :
            if ["+", "-", "*", "/"].contains(inputValue.suffix(1)) {
                inputValue.removeLast()
            }
            inputValue += button
        default:
            inputValue += button
        }
    }
    
    func calculate() {
        let operators: [Character] = ["+", "-", "*", "/"]
        if operators.contains(inputValue.suffix(1)) {
            inputValue = "Invaild Input"
            return
        }
        
        var numbers = [Double]()
        var currentNumber = ""
        var currentOperator = "+"
        
        for char in inputValue {
            print("----------")
            print(char)
            if operators.contains(char) {
                if let number = Double(currentNumber) {
                    switch currentOperator {
                    case "+":
                        numbers.append(number)
                    case "-":
                        numbers.append(-number)
                    case "*":
                        numbers[numbers.count - 1] += number
                    case "/":
                        numbers[numbers.count - 1] /= number
                    default:
                        break
                    }
                    currentNumber = ""
                    currentOperator = String(char)
                }
            } else {
                currentNumber += String(char)
                }
            }
        
        if !currentNumber.isEmpty {
            if let number = Double(currentNumber) {
                switch currentOperator {
                case "+":
                    numbers.append(number)
                case "-":
                    numbers.append(-number)
                case "*":
                    numbers[numbers.count - 1] *= number
                case "/":
                    numbers[numbers.count - 1] /= number
                default:
                    break
                }
            }
        }
        
            inputValue = String(numbers.reduce(0, +))
        }
    }
    
#Preview {
    ContentView()
}
