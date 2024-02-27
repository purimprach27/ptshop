import { test, expect } from '@playwright/test';

test('test', async ({ page }) => {
  await page.goto('http://localhost:8000/en/cart?action=show');
  await page.getByRole('link', { name: 'Voucher' }).click();
  await page.getByRole('link', { name: 'voucher 100 baht' }).first().click();
  await page.getByRole('button', { name: ' Add to cart' }).click();
  await page.getByRole('link', { name: ' Proceed to checkout' }).click();
  await page.getByRole('link', { name: 'Proceed to checkout' }).click();
  await page.getByLabel('จ่ายผ่านพร้อมเพย์ เบอร์โทรศัพท์ : 099-999-9999 เลขบัตรประชาชน : 1 9999 99999 99').check();
  await page.getByText('ต้องใบกำกับภาษีหรือไม่ ต้องการ ไม่ต้องการ').click();
  await page.getByLabel('ต้องการ').check();
  await page.getByLabel('นางสาว', { exact: true }).check();
  await page.getByLabel('ที่อยู่').click();
  await page.getByLabel('ที่อยู่').fill('22/1 ขอนแก่น 42000  ');
  await page.getByLabel('เบอร์โทรศัพท์', { exact: true }).click();
  await page.getByLabel('เบอร์โทรศัพท์', { exact: true }).fill('0904036020');
  await page.getByLabel('หมายเลขประจำตัวผู้เสียภาษี').click();
  await page.getByLabel('หมายเลขประจำตัวผู้เสียภาษี').fill('1429900468109');
  await page.getByLabel('อัปโหลดสลิป').click();
  await page.getByLabel('อัปโหลดสลิป').setInputFiles('barcode.png');
  await page.getByRole('button', { name: 'Place Order' }).click();
});