import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import NAME_FIELD from '@salesforce/schema/Account.Name';

export default class AccountEdit extends LightningElement {
    // Expose a field to make it available in the template
    nameField = NAME_FIELD;

    // Flexipage provides recordId and objectApiName
    @api recordId;
    @api objectApiName;

    handleButtonClick() {
        const event = new ShowToastEvent({
            title: 'Success!',
            message: 'Record edited successfully!'
        });
        this.dispatchEvent(event);
    }
}