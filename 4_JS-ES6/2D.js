/*
1.Write a JavaScript class Car with a constructor that takes make and model as parameters. Include an instance method displayInfo that logs "Make: [make], Model: [model]" to the console when called.
*/
class Car {
    constructor(make, model) {
        this.make = make
        this.model = model
    }

    displayInfo() {
        console.log(this.make, this.model)
    }
}


const c1 = new Car('tata', 23);

c1.displayInfo()

/*
2. Create a subclass ElectricCar that extends the Car class. Add a new property batteryCapacity to the ElectricCar class and override the displayInfo method to include battery information.
 */

class ElectricCar extends Car {
    constructor(make, model, batteryCapacity) {
        super(make, model);
        this.batteryCapacity = batteryCapacity
    }
    displayInfo() {
        console.log(this.make, this.model, this.batteryCapacity)
    }
}
const c2 = new ElectricCar('tasla', 's3', '78%')
c2.displayInfo()



/*
3.
Create a Engine class with methods start and stop. Modify the Car class to include an instance of Engine and delegate the start and stop methods to it
 */

class Engine extends Car {
    constructor(model, make) {
        super(make, model)
    }
    start() {
        console.log('engine started...')
    }
    stop() {
        console.log('engine stops....')
    }
}


/*
 4.Write a function printPersonInfo that accepts an object parameter person containing name, age, and city properties, and uses object destructuring to print each property.
  */

const personInfoObj = {
    name: 'nitin',
    age: 22,
    city: 'jaipur'
}
function printPersonInfo(obj) {

    const { name: userName, age: HowOld, city } = obj
    console.log(userName, HowOld, city)
}
printPersonInfo(personInfoObj)






/**
 5.Modify the printPersonInfo function to assign default values ('Unknown') to age and city if they are not provided in the person object.
 */
function modifyPrintPersonInfo(obj) {

    const { name: userName, age: HowOld = 'unknown', city = 'unknown' } = obj
    console.log(userName, HowOld, city)
}
modifyPrintPersonInfo({ name: 'nitin singh' })

/*
6.Write a function mergeObjects that takes two objects as parameters and merges them using the spread operator (...). If there are duplicate keys, the second object should overwrite the first.
 */
function mergeObjects(obj1, obj2) {
    return { ...obj1, ...obj2 }
}
const res = mergeObjects({ name: 'nitin', class: 'A' }, { name: 'singh', class1: 'B' });
console.log(res);


/* 
7. Write a function getRemainingProperties that extracts the name property from an object and gathers all remaining properties into a new object using object destructuring and the rest syntax (...).
*/

function getRemainingProperties(obj){
    const {name,...obj1}=obj;
    console.log(name, obj1,typeof obj, typeof obj1);
}
getRemainingProperties({name:"nitin",class:'a', section: '71', year:'22 ...'})

/*
8.
Create a function updatePersonInfo that updates the name property of a person object using object destructuring and the spread operator, leaving other properties unchanged.
 */

function updatePersonInfo(obj){
  obj={...obj,name:'singh'}
  console.log(obj)
}
updatePersonInfo({name:'nitin',class:'a'})