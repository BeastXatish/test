import { LightningElement } from 'lwc';
import firstpage from './CSE.html';
import secondpage from './ECE.html';
import mainpage from './form.html';

export default class Form extends LightningElement {
    questions = [

        {
            id: 1,

            ques: "What is 2+2 ?",

            options: [
            { label: '4', value: '4'},
            { label: '5' ,value: '5'},
            { label: '6' ,value: '6'}
            ],
            correctAnswer: '4'
        },

        {
            id: 2,

            ques: 'What is 2+3?',

            options: [
                { label: '6', value: '6'},
                { label: '5' ,value: '5'},
                { label: '4' ,value: '4'}
                ],
            correctAnswer: '5'
        },

        {
            id: 3,

            ques: 'What is 3+3 ?',

            options: [
                { label: '1', value: '1'},
                { label: '2' ,value: '2'},
                { label: '6' ,value: '6'}
                ],

            correctAnswer: '6'

        }

    ]

    istrue = false;
    value ='';
    score  = 0;
    isselected = null;
    render() {
        return this.isselected === 'button1' ? secondpage : this.isselected === 'button2' ? firstpage : mainpage;
    }

    handleclick(event) {
        this.isselected = event.target.name;
    }

    handlepreviousclickECE(event) {
        this.score = 0;
        this.isselected = event.target.name;
        return this.isselected === 'goback' ? mainpage : secondpage
    }

    handlepreviousclickCSE(event) {
        this.isselected = event.target.name;
        return this.isselected === 'GoBack' ? mainpage : firstpage
    }

    handlereset(){
        this.istrue = false;
        this.score = 0;
        let element = this.template.querySelectorAll('lightning-radio-group');
        let inputelement = this.template.querySelector('lightning-input')
        inputelement.value = ''
        Array.from(element).forEach(currentitem =>{
            currentitem.value = undefined
        })
    }

    handlesubmit(){
        this.istrue = true;
        let inputelement = this.template.querySelector('lightning-input')
        this.value = inputelement.value
        let element = this.template.querySelectorAll('lightning-radio-group');
        this.score = 0;
        Array.from(element).forEach(currentitem =>{
                this.questions.forEach(questionsitem =>{
                    if(currentitem.label == questionsitem.ques){
                        if(currentitem.value == questionsitem.correctAnswer){
                            this.score = this.score + 1;
                        }
                    }
                })
             })
    }
    handleinput(event){
        this.value = event.target.value;
    }
}