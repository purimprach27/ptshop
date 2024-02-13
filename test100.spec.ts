import { test, expect } from '@playwright/test';

test('test', async ({ page }) => {
  await page.goto('http://localhost:8000/');
  await page.getByRole('link', { name: 'voucher 100 baht' }).first().click();
  await page.getByRole('button', { name: ' Add to cart' }).click();
  await page.getByRole('link', { name: ' Proceed to checkout' }).click();
  await page.getByRole('link', { name: 'Proceed to checkout' }).click();
  await page.getByLabel('Pay by bank wireSCB').check();
  await page.getByText('Upload Slip').click();
  await page.getByLabel('Upload Slip').setInputFiles('images.jpg');
  await page.getByLabel('Yes').check();
  await page.getByLabel('Name').click();
  await page.getByLabel('Name').fill('firstname');
  await page.getByLabel('Address').click();
  await page.getByLabel('Address').fill('322');
  await page.getByLabel('Tel').click();
  await page.getByLabel('Tel').fill('020000');
  await page.getByLabel('Tax ID').click();
  await page.getByLabel('Tax ID').fill('123456');
  await page.getByRole('button', { name: 'Place Order' }).click();
});