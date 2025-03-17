/*import { LightningElement, track } from 'lwc';

export default class MyFirstWebComponent extends LightningElement {
    @track
    contacts = [
        {
            Id: 1,
            Name: 'Amy Taylor',
            Title: 'VP of Engineering'
        },
        {
            Id: 2,
            Name: 'Michael Jones',
            Title: 'VP of Sales',
        },
        {
            Id: 3,
            Name: 'Jennifer Wu',
            Title: 'CEO'
        }
    ];
}*/

import { LightningElement, api, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
//import { getRecord } from 'lightning/uiRecordApi';

export default class MyfirstWebComponent extends LightningElement{
    @api recordId;
    /*FIELDS = [
        'Contact.Name',
        'Contact.Title'
    ];*/

    @wire(getContacts,{accountId: '$recordId'}) contacts;
    //@wire(getContacts)
    //contacts;
}