import { LightningElement,api } from 'lwc';
export default class Randevu extends LightningElement {
  @api calendlyLink;
  @api leadId;
  @api leadName;
  @api leadEmail;
  // calendlyLink=https://calendly.com/alex_victor/cw-demo-randevu
  // https%3A//calendly.com/Falex_victor/Fcw-demo-randevu
// leadId=${!getLead.Id}&leadName={!getLead.Name}&leadEmail={!getLead.Email}
  connectedCallback(){
    console.log('this.calendlyLink');
 
    console.log(this.calendlyLink);
    this.calendlyLink=this.calendlyLink.replaceAll('%2F','/').replaceAll('%3A',':'); //.replaceAll('%20',' ')
    let name='?name='+this.leadId+' '+this.leadName;
    let email ='&email='+this.leadEmail;
    this.calendlyLink+=name+email;
    // ? name=
    // & email=
    console.log(this.calendlyLink);
  }
}