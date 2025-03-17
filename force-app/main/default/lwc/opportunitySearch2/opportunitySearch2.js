import { LightningElement,track } from 'lwc';
import { FlowNavigationFinishEvent } from 'lightning/flowSupport';
import LightningAlert from "lightning/alert";

export default class OpportunitySearch2 extends LightningElement {    
    @track selectedValue;
    @track opportunities=[];

    columns = [
        {
            label: 'Name',
            fieldName: 'oppName',
            type: 'text'
        }
    ]

    options = [
        { label: 'テスト1', value: 'テスト1'},
        { label: 'テスト2', value: 'テスト2'},
        { label: 'テスト3', value: 'テスト3'},
    ]

    opportunitySearch(){
        this.opportunities = [
            { id: '1', oppName: 'test1'},
            { id: '2', oppName: 'test2'},
        ]
    }

}