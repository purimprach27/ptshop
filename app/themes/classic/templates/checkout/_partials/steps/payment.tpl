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

  {if $is_free}
    <p class="cart-payment-step-not-needed-info">{l s='No payment needed for this order' d='Shop.Theme.Checkout'}</p>
  {/if}
  <div class="payment-options {if $is_free}hidden-xs-up{/if}">
    {foreach from=$payment_options item="module_options"}
      {foreach from=$module_options item="option"}
        <div>
          <div id="{$option.id}-container" class="payment-option clearfix">
            {* This is the way an option should be selected when Javascript is enabled *}
            <span class="custom-radio float-xs-left">
              <input
                class="ps-shown-by-js {if $option.binary} binary {/if}"
                id="{$option.id}"
                data-module-name="{$option.module_name}"
                name="payment-option"
                type="radio"
                required
                {if ($selected_payment_option == $option.id || $is_free) || ($payment_options|@count === 1 && $module_options|@count === 1)} checked {/if}
              >
              <span></span>
            </span>
            {* This is the way an option should be selected when Javascript is disabled *}
            <form method="GET" class="ps-hidden-by-js">
              {if $option.id === $selected_payment_option}
                {l s='Selected' d='Shop.Theme.Checkout'}
              {else}
                <button class="ps-hidden-by-js" type="submit" name="select_payment_option" value="{$option.id}">
                  {l s='Choose' d='Shop.Theme.Actions'}
                </button>
              {/if}
            </form>

            <label for="{$option.id}">
              <span>{$option.call_to_action_text}</span>
              {if $option.logo}
                <img src="{$option.logo}" loading="lazy">
              {/if}
            </label>

          </div>
        </div>

        {if $option.additionalInformation}
          <div
            id="{$option.id}-additional-information"
            class="js-additional-information definition-list additional-information{if $option.id != $selected_payment_option} ps-hidden {/if}"
          >
            {$option.additionalInformation nofilter}
          </div>
        {/if}

        <div
          id="pay-with-{$option.id}-form"
          class="js-payment-option-form {if $option.id != $selected_payment_option} ps-hidden {/if}"
        >
          {if $option.form}
            {$option.form nofilter}
          {else}
            <form id="payment-{$option.id}-form" method="POST" action="{$option.action nofilter}">
              {foreach from=$option.inputs item=input}
                <input type="{$input.type}" name="{$input.name}" value="{$input.value}">
              {/foreach}
              <button style="display:none" id="pay-with-{$option.id}" type="submit"></button>
            </form>
          {/if}
        </div>
      {/foreach}
    {foreachelse}
      <p class="alert alert-danger">{l s='Unfortunately, there are no payment methods available.' d='Shop.Theme.Checkout'}</p>
    {/foreach}
  </div>
  {* This is the way an option should be selected when Javascript is enabled *}
  <span class="custom-radio float-xs-left">
    <input
      class="ps-shown-by-js"
      id="bankPaymentOption"
      name="paymentMethod"
      type="radio"
      value="bankTransfer"
    >
    <span></span>
  </span>
 

  </span>
  <label for="qrCodePaymentOption">Pay with QR Code</label>
  <br>

  <div id="selectedBankDetails" style="display: none;">

  </div>

  <div id="selectedQRCodeDetails" style="display: none;">
    <!-- สร้าง QR Code ที่นี่ -->
  </div>


  <!DOCTYPE html>
  <html lang="en">
  <head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  </head>
  <body>
    <div id="imageContainer">
      <img src="C:\Users\WINDOWS 11\Desktop\ptshop\app\themes\classic\preview.png">
    </div>
  </body>
  </html>


</body>
</html>

  
    {* อัพไฟล์ *}
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

  {* ปุ่ม PLACE ORDER *}
  <div id="payment-confirmation" class="js-payment-confirmation">
    <div class="ps-shown-by-js">
      <button type="submit" class="btn btn-primary center-block" id="placeOrderButton" disabled>
        {l s='Place order' d='Shop.Theme.Checkout'}
      </button>
    </div>
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