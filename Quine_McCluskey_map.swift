import Foundation

// Function to find the binary representation of a decimal number
func decimalToBinary(_ decimal: Int, width: Int) -> String {
    let binary = String(decimal, radix: 2)
    let padding = String(repeating: "0", count: max(0, width - binary.count))
    return padding + binary
}

// Function to count the number of '1' bits in a binary string
func countOnes(_ binary: String) -> Int {
    return binary.filter { $0 == "1" }.count
}

// Function to perform the Quine-McCluskey algorithm
func quineMcCluskey(inputs: [String]) -> [String] {
    var primeImplicants = Set(inputs)

    while true {
        var groups = [Int: [String]]()

        for implicant in primeImplicants {
            let count = countOnes(implicant)
            if groups[count] == nil {
                groups[count] = [implicant]
            } else {
                groups[count]?.append(implicant)
            }
        }

        var newPrimeImplicants = Set<String>()

        for (_, group) in groups where group.count > 1 {
            for i in 0..<group.count {
                for j in i+1..<group.count {
                    let implicant1 = group[i]
                    let implicant2 = group[j]

                    var diffCount = 0
                    var mergedImplicant = ""

                    for (char1, char2) in zip(implicant1, implicant2) {
                        if char1 != char2 {
                            diffCount += 1
                            mergedImplicant += "-"
                        } else {
                            mergedImplicant += String(char1)
                        }
                    }

                    if diffCount == 1 {
                        newPrimeImplicants.insert(mergedImplicant)
                    }
                }
            }
        }

        if newPrimeImplicants.isEmpty {
            break
        }

        primeImplicants.formUnion(newPrimeImplicants)
    }

    return Array(primeImplicants)
}

// Function to display the Quine-McCluskey map
func displayQuineMcCluskeyMap(inputs: [String], primeImplicants: [String]) {
    print("Quine-McCluskey Map:")
    print("Inputs | Prime Implicants")

    for (index, implicant) in primeImplicants.enumerated() {
        print("\(inputs[index])     | \(implicant)")
    }
}

// Example usage
let booleanFunctionInputs = ["00", "01", "10", "11"]
let primeImplicants = quineMcCluskey(inputs: booleanFunctionInputs)
displayQuineMcCluskeyMap(inputs: booleanFunctionInputs, primeImplicants: primeImplicants)


