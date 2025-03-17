import { LightningElement, wire, track } from 'lwc';
import getContacts from '@salesforce/apex/LWCExampleController.getContacts';
import getOpportunity from '@salesforce/apex/OpportunityController.getOpportunity';


// datatable columns
const columns = [
    {
        label: 'Name',
        fieldName: 'oppName',
        type: 'url',
        typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}
    }, {
        label: 'Amount',
        fieldName: 'Amount',
        type: 'currency',
    }
];

export default class HyperlinkNameInDatatable extends LightningElement {
    oppData = [];
    columns = columns;

    @wire(getOpportunity)
    opportunities({ data,error }) {

        if (data) {
            let tempOppList = []; 
            
            data.forEach((record) => {
                console.log('record'+ record);
                let tempOppRec = Object.assign({}, record);  
                console.log('tempOppRec'+ tempOppRec);
                tempOppRec.oppName = '/' + tempOppRec.Id;
                console.log('tempOppList' + tempOppList);
                tempOppList.push(tempOppRec);
                console.log('tempOppList' + tempOppList);

                
            });
            
            this.oppData = tempOppList;
            this.error = undefined;

            console.table(this.oppData);

        } else if (error) {
            this.error = result.error;
        }
    }
}