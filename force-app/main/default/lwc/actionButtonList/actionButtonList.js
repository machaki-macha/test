import { LightningElement, track, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class ActionButtonList extends NavigationMixin(LightningElement) {
    @api btn1_label;
    @api btn1_variant;
    @api btn1_destination;

    handleClick1() {
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: this.btn1_destination
            }
        });
    }    
}