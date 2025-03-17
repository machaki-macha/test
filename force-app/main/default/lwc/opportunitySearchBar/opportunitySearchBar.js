import {LightningElement, track} from 'lwc';
import getOpportunity from '@salesforce/apex/OpportunityController.getOpportunity';

export default class opportunitySearchBar extends LightningElement {

    columns = [
        {
            label: 'Name',
            fieldName: 'oppName',
            type: 'url',
            typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}
        },
        
        { label: 'Amount', fieldName: 'Amount', type: 'currency'}
    ];

    @track searchKey = '';
    @track opportunities;
    @track tempOpp;
    @track error;
    @track test1;

    handleChange(event){
        this.searchKey = event.target.value;
        //System.debug(event.target.value);
        
    }

    opportunitySearch(){


        
        getOpportunity({searchKey:this.searchKey})
        .then((result) => {
            let tempOppList = []; 

            result.forEach((record) => {
                //record変数の中身をtempOppに入れている。
                let tempOpp = Object.assign({},record);
                tempOpp.oppName = '/' + record.Id;
                tempOppList.push(tempOpp);
            });
            this.opportunities = tempOppList;
            this.error = undefined;
            })
        .catch((error) => {
            this.error = error;
            this.opportunities = undefined;
            });
    }
}

            /*for(i=0;i<result.length;i++){
                console.log("result1"+result[i]);
            }*/

            /*for(record in result){
                console.log('record' + record);
            }*/

            /*for(record of result){
                console.log('record' + record);
            }*/

            /*result.foreach(function(record){
                console.log(record);
            });*/

            
            

    /*
    opportunitySearch(){
        console.log(this.searchKey);
        getOpportunity({searchKey:this.searchKey})
        .then((result) => {
            this.opportunities = result;
            this.error = undefined;
            })
            .catch((error) => {
            this.error = error;
            this.opportunities = undefined;
            });
        
        console.log("てすと");
        this.opportunities.map(opportunity => {url = this.getUrl(opportunity);
        return url;});
        console.log("url"+url);
        console.log("opportunity"+opportunity);
    }
    */

    /*
        //画面遷移
        this.opportunityRecordPage = {
            type: 'standard__recordPage',
            attributes: {
                recordId: '0065i00000HSkunAAD',
                objectApiName: 'opportunity',
                actionName: 'view'
            }
        };
        this[NavigationMixin.GenerateUrl](this.opportunityRecordPage).then((url) => (this.url = url));
    */

    /*
        //画面遷移URL生成
        console.log("url");
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes: {
                recordId: '0065i00000HSkunAAD',
                objectApiName: 'Opportunity',
                actionName: 'view'
            },
        }).then((url) => {
            this.recordPageUrl = url;
            
        });
        return this.recordPageUrl;
    */