{extends file='checkout/_partials/steps/checkout-step.tpl'}

{block name='step_content'}

  {hook h='displayPaymentTop'}

  {* used by javascript to correctly handle cart updates when we are on payment step (eg vouchers added) *}
  <div style="display:none" class="js-cart-payment-step-refresh"></div>

  {if !empty($display_transaction_updated_info)}
  <p class="cart-payment-step-refreshed-info">
    {l s='Transaction amount has been correctly updated' d='Shop.Theme.Checkout'}
  </p>
  {/if}

<div class="payment-options">
  <form id="paymentForm" method="POST" action="index.php">
    <input type="radio" id="cashPayment" name="paymentMethod" value="cash" required>
    <label for="cashPayment">{l s='Pay by bank wire<br>SCB 5514432341' d='Shop.Theme.Checkout'}</label><br>
    <div id="cashMessage"></div>
    
    <input type="radio" id="transferPayment" name="paymentMethod" value="transfer" required>
    <label for="transferPayment">{l s='Pay by QR Code' d='Shop.Theme.Checkout'}</label>
    <body>
      <div id="imageContainer">
        <img src="https://www.i-pic.info/i/jUlP652303.jpg">
      </div>
    </body>
    <div id="uploadFileSection" class="ps-upload-file-section">
      <label for="fileUpload">{l s='Upload Slip' d='Shop.Theme.Checkout'}</label>
      <input type="file" id="fileUpload" name="fileUpload" required>
    </div>
  
    {* Add tax invoice selection radio button and customer information form *}
    <div class="tax-invoice-section">
      <label for="taxInvoiceOption">{l s='Do you want to receive a tax invoice?' d='Shop.Theme.Checkout'}</label>
      <input type="radio" id="taxInvoiceOption" name="taxInvoiceOption" value="yes" required>
      <label for="taxInvoiceOption">{l s='Yes' d='Shop.Theme.Checkout'}</label>
      <input type="radio" id="taxInvoiceOption" name="taxInvoiceOption" value="no" required>
      <label for="taxInvoiceOption">{l s='No' d='Shop.Theme.Checkout'}</label>
    </div>
  
    <div class="customer-information-form" id="customerInformationForm" style="display: none;">
      <label for="customerName">{l s='Name' d='Shop.Theme.Checkout'}</label>
      <input type="text" id="customerName" name="customerName" required>
      <br>
      <label for="customerAddress">{l s='Address' d='Shop.Theme.Checkout'}</label>
      <input type="address" id="customerAddress" name="customerAddress" required>
      <br>
      <label for="customerTel">{l s='Tel' d='Shop.Theme.Checkout'}</label>
      <input type="tel" id="customerTel" name="customerTel" required>
      <br>
      <label for="taxId">{l s='Tax ID' d='Shop.Theme.Checkout'}</label>
      <input type="text" id="taxId" name="taxId" required>
    </div>

    <button type="submit">{l s='Place Order' d='Shop.Theme.Checkout'}</button>
  </form>
</div>


  <script>
    // Add an event listener to the file input
    document.getElementById('fileUpload').addEventListener('change', function() {
      // Get the file input value
      var fileValue = this.value;
      
      // Get the Place order button
      var placeOrderButton = document.getElementById('placeOrderButton');

      // Enable or disable the Place order button based on whether a file has been uploaded
      placeOrderButton.disabled = (fileValue === '');
    });

    // Add an event listener to the radio button
    document.getElementById('taxInvoiceOption').addEventListener('change', function() {
      // Get the value of the selected option
      var selectedValue = this.value;
      
      // Get the customer information form container
      var customerInformationForm = document.getElementById('customerInformationForm');

      // Display or hide the customer information form based on the selected value
      if (selectedValue === 'yes') {
        customerInformationForm.style.display = 'block';
      } else {
        customerInformationForm.style.display = 'none';
      }
    });
    
  </script>

  {hook h='displayCheckoutBeforeConfirmation'}

  {hook h='displayPaymentByBinaries'}
  
{/block}