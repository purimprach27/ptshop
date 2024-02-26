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

<div class="payment-options", style = 'text-align: left;'>
  <form id="paymentForm" method="POST" action="index.php">
    <input type="radio" id="cashPayment" name="paymentMethod" value="cash" required>
    <label for="cashPayment" style = 'text-align: left;'>
      {l s='จ่ายผ่านพร้อมเพย์ <br>เบอร์โทรศัพท์ : 099-999-9999<br> เลขบัตรประชาชน : 1 9999 99999 99 9<br>ชื่อบัญชี : มหาวิทยาลัยขอนแก่น' d='Shop.Theme.Checkout'}</label><br>
    <div id="cashMessage">
</div>

<div class="payment-options", style = 'text-align: left;'>
  <form id="paymentForm" method="POST" action="index.php">
    <input type="radio" id="cashPaymentBank" name="paymentMethod" value="bank" required>
    <label for="cashPaymentBank" style = 'text-align: left;'>
      {l s='จ่ายผ่านธนาคารโดยตรง <br>ธนาคาร : ไทยพาณิชย์ <br> เลขบัญชี : 551-443-2341<br>ชื่อบัญชี : นางสาวปุริมปรัชญ์ ธงทอง' d='Shop.Theme.Checkout'}</label><br>
    <div id="cashMessage">
</div>
    
    <input type="radio" id="transferPayment" name="paymentMethod" value="transfer" required>
    <label for="transferPayment" style = 'text-align: left;'>{l s='จ่ายผ่านการสแกน QR Code<br>ชื่อบัญชี นางสาวปุริมปรัชญ์ ธงทอง' d='Shop.Theme.Checkout'}</label>
    <body>
      <div id="imageContainer">
        <img src="https://www.i-pic.info/i/q36U661005.jpg">
      </div>
    </body>
    <input type="radio" id="counterPayment" name="paymentMethod" value="counter" required>
    <label for="counterPayment" style = 'text-align: left;'>{l s='จ่ายผ่าน couter service<br>ชื่อบัญชี นางสาวปุริมปรัชญ์ ธงทอง' d='Shop.Theme.Checkout'}</label>
    <body>
      <div id="imageContainer">
        <img src="https://www.i-pic.info/i/5gpe661009.png">
      </div>
    </body>
    <br><br><br>
    <div id="uploadFileSection" class="ps-upload-file-section">
      <label for="fileUpload">{l s='อัปโหลดสลิป' d='Shop.Theme.Checkout'}</label>
      <input type="file" id="fileUpload" name="fileUpload" required>
    </div>
  
    {* Add tax invoice selection radio button and customer information form *}
    

    <div class="payment-options">
      <form id="paymentForm" method="POST" action="index.php">
        <label for="taxInvoiceOption" style="display: inline-block;">
          {l s='ต้องใบกำกับภาษีหรือไม่' d='Shop.Theme.Checkout'}
        </label>
        <input type="radio" id="taxInvoiceOption" name="taxInvoiceOption" value="yes" required style="display: inline-block;">
        <label for="taxInvoiceOption" style="display: inline-block;">
          {l s='ต้องการ' d='Shop.Theme.Checkout'}
        </label>
        <input type="radio" id="taxInvoiceOption" name="taxInvoiceOption" value="no" required style="display: inline-block;">
        <label for="taxInvoiceOption" style="display: inline-block;">
          {l s='ไม่ต้องการ' d='Shop.Theme.Checkout'}
        </label>
      </form>
    </div>
    
  
    <div class="customer-information-form" id="customerInformationForm" style="display: none;">
      <div class="payment-options">
        <form id="paymentForm" method="POST" action="index.php">
          <input type="radio" id="M" name="gender" value="นาย" required style="display: inline-block;">
          <label for="M" style="display: inline-block;">นาย</label>
          
          <input type="radio" id="WM" name="gender" value="นาง" required style="display: inline-block;">
          <label for="WM" style="display: inline-block;">นาง</label>
          
          <input type="radio" id="WMs" name="gender" value="นางสาว" required style="display: inline-block;">
          <label for="WMs" style="display: inline-block;">นางสาว</label>
        </form>
      </div>
      
      <label for="customerName">{l s='ชื่อจริง' d='Shop.Theme.Checkout'}</label>
      <input type="text" id="customerName" name="customerName" required>
      <label for="customerName">{l s='นามสกุล' d='Shop.Theme.Checkout'}</label>
      <input type="text" id="customerName" name="customerName" required>
      <br>
      <label for="customerAddress">{l s='ที่อยู่' d='Shop.Theme.Checkout'}</label>
      <input type="address" id="customerAddress" name="customerAddress" required>
      <br>
      <script>
        function validateTelephone(input) {
          var tel = input.value.trim();
          if (tel.length !== 10) {
            alert("กรอกหมายเลขโทรศัพท์ให้ครบถ้วนทั้ง 10 หมายเลข");
            return false;
          }
          return true;
        }
      </script>
      
      <div class="payment-options">
        <form id="paymentForm" method="POST" action="index.php">
          <label for="customerTel">
            {l s='เบอร์โทรศัพท์' d='Shop.Theme.Checkout'}
          </label>
          <input type="tel" id="customerTel" name="customerTel" onblur="validateTelephone(this)" required>
        </form>
      </div>
      <br>
      <script>
        function validateTaxId(input) {
          var taxId = input.value.trim();
          if (taxId.length !== 13) {
            alert("กรอกหมายเลขประจำตัวผู้เสียภาษีให้ครบถ้วนทั้ง 13 หมายเลข");
            return false;
          }
          return true;
        }
      </script>
      
      <div class="payment-options">
        <form id="paymentForm" method="POST" action="index.php">
          <label for="taxId">
            {l s='หมายเลขประจำตัวผู้เสียภาษี' d='Shop.Theme.Checkout'}
          </label>
          <input type="text" id="taxId" name="taxId" onblur="validateTaxId(this)" required>
        </form>
      </div>
      
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