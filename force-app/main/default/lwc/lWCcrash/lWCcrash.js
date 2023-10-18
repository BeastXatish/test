import { LightningElement, track } from 'lwc';
import addtodo from '@salesforce/apex/todocontrollers.addTodo'
import getCurrentTodos from '@salesforce/apex/todocontrollers.getCurrentTodos'
export default class LWCcrash extends LightningElement {

    time = "15:15 p.m";
    greeting = "good evening";
   @track todomanagervalues = [];
    // is called as soon as our compoment initialised
    connectedCallback(){
        this.getTime();
        this.fetchtodo();
       // this.populatetodos(); not required because now we are storing the data in salesforce object format
        setInterval(() => { // java script method which accept arrow function with blank para
            this.getTime();
        }, 1000);
    }
    
    getTime() {

        const date = new Date()
        const hour = date.getHours();
        const minutes = date.getMinutes();
        const seconds = date.getSeconds();
        this.time = `${this.gethour(hour)}:${this.getDoubleDigit(minutes)}:${this.getsec(seconds)} ${this.getMidday(hour)}`;
        this.setgreeting(hour)
    }
    gethour(hour) {
        return hour === 0 ? 12 : hour > 12 ? (hour - 12) : hour
    }

    getsec(digits){
        return digits < 10 ? "0" + digits : digits;
    }

    getMidday(hour) {
        return hour >= 12 ? "P.M" : "A.M"
    }

    getDoubleDigit(digit) {
        return digit < 10 ? "0" + digit : digit;
    }
    
    setgreeting(hour) {
        if (hour < 12) {
            this.greeting = "Good Morning"
        }
        else if (hour >= 12 && hour < 17) {
            this.greeting = "Good Afternoon"
        }
        else {
            this.greeting = "Good Evening"
        }

    }

    addtodohandler(){
        const inputboxvalueholder = this.template.querySelector("lightning-input");
        // reason for creating it as an object is because to store the id whn rendering it in html using for each eariler we were using key as the array now push the object into the array.
        const todo ={
                //todoId : this.todomanagervalues.length,
                todoname : inputboxvalueholder.value,
                done : false
                //tododate : new Date()
        }
        addtodo({ payload : JSON.stringify(todo)}).then(response =>{
            console.log('Item inserted successfully');
            this.fetchtodo();
        }).catch(error =>{
            console.log('We got an error'+error);
        })
       // console.log('Current value' , inputboxvalueholder.value); to get the value of the input box .value is used
       // this.todomanagervalues.push(todo); // to add the values on the array .push is used
        inputboxvalueholder.value = " ";
    }

    fetchtodo(){
        getCurrentTodos().then(result =>{
            if(result){
                console.log("Item inserted" , result.length);
                this.todomanagervalues = result;
            }
        })
        .catch(error =>{
            console.log("error occured please check" +error)
        })
    }

    get upcomingtasks(){// get method always return a value in the end we r checking if todoman is not blank and it has some length means it has some items then we need to filter the array and check if done is false which is a property in todo object filter method creates a new array with all the elements pass the test implemented by the provided function and the reverse is for completed task.
        return this.todomanagervalues && this.todomanagervalues.length ? this.todomanagervalues.filter(todos => !todos.done):[]
    }

    get completedtasks(){
        return this.todomanagervalues && this.todomanagervalues.length ? this.todomanagervalues.filter(todos => todos.done):[]
    }

     /*populatetodos(){
        const todoslist = [
            {
                todoId:0,
                todoname: 'Wash the car.?',
                done:false,
                tododate : new Date()
            },
            {
                todoId:1,
                todoname: 'Feed the cat.?',
                done:false,
                tododate : new Date()
            },
            {
                todoId:2,
                todoname: 'Focus on yourself..!',
                done:true,
                tododate : new Date()
            }
        ]
        this.todomanagervalues = todoslist;
    }*/
}