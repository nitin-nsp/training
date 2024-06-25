const arr = Array()
const arr = []
const numbers = [0, 3.14, 9.81, 37, 98.6, 100]


//split 

let js = 'JavaScript'
const charsInJavaScript = js.split('')

console.log(charsInJavaScript) // ["J", "a", "v", "a", "S", "c", "r", "i", "p", "t"]



const eightEmptyValues = Array(8) // it creates eight empty values
console.log(eightEmptyValues) // [empty x 8]
const eightXvalues = Array(8).fill('X')

//concat
const firstList = [1, 2, 3]
const secondList = [4, 5, 6]
const thirdList = firstList.concat(secondList)

console.log(thirdList) // [1, 2, 3, 4, 5, 6]

//indexOf
/* indexOf:To check if an item exist in an array. If it exists it returns the index else it returns -1.*/
const numbers = [1, 2, 3, 4, 5]

console.log(numbers.indexOf(5)) // -> 4



//lastIndexOf
const numbers = [1, 2, 3, 4, 5, 3, 1, 2]

console.log(numbers.lastIndexOf(2)) // 7

//includes
const numbers = [1, 2, 3, 4, 5]

console.log(numbers.includes(5)) // true
console.log(numbers.includes(0)) // false

//toString
const numbers = [1, 2, 3, 4, 5]
console.log(numbers.toString()) // 1,2,3,4,5
