import { test, expect } from '@playwright/test';

test('test', async ({ page }) => {
  await page.goto('http://localhost:8000/en/');
  await page.getByRole('link', { name: 'Voucher', exact: true }).click();
  await page.getByRole('link', { name: 'voucher 500 baht' }).first().click();
  await page.getByRole('button', { name: ' Add to cart' }).click();
  await page.getByRole('link', { name: ' Proceed to checkout' }).click();
  await page.getByRole('link', { name: 'Proceed to checkout' }).click();
  await page.getByLabel('จ่ายผ่านพร้อมเพย์ เบอร์โทรศัพท์ : 099-999-9999 เลขบัตรประชาชน : 1 9999 99999 99').check();
  await page.locator('#taxInvoiceOption').nth(1).check();
  await page.getByLabel('อัปโหลดสลิป').click();
  await page.getByLabel('อัปโหลดสลิป').setInputFiles('barcode.png');
  await page.getByRole('button', { name: 'Place Order' }).click();
});