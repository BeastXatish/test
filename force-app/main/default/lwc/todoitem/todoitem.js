import { LightningElement, api } from 'lwc';
import updatetodolist from '@salesforce/apex/todocontrollers.updateTodo';
import deletetodolist from '@salesforce/apex/todocontrollers.deleteTodo';

export default class Todoitem extends LightningElement {

    @api todoId;
    @api todoName;
    @api done = false;

    get containerclass() {
        return this.done ? "todo completed" : "todo upcoming"
    }

    get iconName() {
        return this.done ? "utility:check" : "utility:add";
    }

    updatehandler() {
        const todo = {
            todoId: this.todoId,
            todoName: this.todoName,
            done: !this.done
        }


        updatetodolist({ payload: JSON.stringify(todo) })
            .then(response => {
                    console.log('Item inserted successfully');
            })
            .catch(error => {
                console.log('We got an error' + error);
            })
    }

    deletehandler() {

        deletetodolist({ todo: this.todoId }).then(result => {
            console.log("Item deleted successfully");
        })
            .catch(error => {
                console.log("error occured" + error);
            })
    }
}