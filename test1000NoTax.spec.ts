import { test, expect } from '@playwright/test';

test('test', async ({ page }) => {
  await page.goto('http://localhost:8000/');
  await page.getByRole('link', { name: 'Voucher', exact: true }).click();
  await page.getByRole('link', { name: 'voucher 1000 baht' }).first().click();
  await page.getByRole('button', { name: ' Add to cart' }).click();
  await page.getByRole('link', { name: ' Proceed to checkout' }).click();
  await page.getByRole('link', { name: 'Proceed to checkout' }).click();
  await page.getByLabel('Pay by bank wireSCB').check();
  await page.getByLabel('Upload Slip').click();
  await page.getByLabel('Upload Slip').setInputFiles('Black and White Elegant Digital Marketing Resume.png');
  await page.locator('#taxInvoiceOption').nth(1).check();
  await page.getByRole('button', { name: 'Place Order' }).click();
});