import { LightningElement, track } from 'lwc';

export default class BMICalcurator extends LightningElement {
    @track bmi= 0;
    @track height = 150;
    @track weight = 50;

    heightChange(event){
        var test;
        this.height = parseInt(event.target.value);
        console.log(this.height);
        
    }

    weightChange(event){
        this.weight = parseInt(event.target.value);
    }

    calcurate(){
        //input = this.template.querySelectorAll('lightning-input');
        const heightMeter = this.height / 100;
        this.bmi = this.weight / (heightMeter * heightMeter);
    }
}