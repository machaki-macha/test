import {LightningElement,api} from 'lwc';
import {NavigationMixin} from 'lightning/navigation';

export default class opportunitySearchResult extends NavigationMixin(LightningElement) {
    @api recordPageUrl;

    opportunities;
    testId  = '0065i00000HSkunAAD';

    connectedCallback(){
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes: {
                recordId: '0065i00000HSkunAAD',
                objectApiName: 'Opportunity',
                actionName: 'view'
            },
        }).then((url) => {
            this.recordPageUrl = url;
            console.log(url);
        });
        return this.recordPageUrl;
    }
}