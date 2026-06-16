const { chromium, devices } = require('playwright');
const TARGET_URL =
  'http://localhost:8080/source/52573823-d69d-4b3e-89a7-3eb252e61d8a/_preview.html';

(async () => {
  const iphone = devices['iPhone 12'];
  const browser = await chromium.launch({ headless: false });
  const context = await browser.newContext({ ...iphone });
  const page = await context.newPage();
  const logs = [];
  page.on('console', (m) => logs.push(`[${m.type()}] ${m.text()}`));
  page.on('pageerror', (e) => logs.push(`[pageerror] ${e.message}`));
  page.on('requestfailed', (r) =>
    logs.push(`[reqfail] ${r.url()} ${r.failure()?.errorText}`),
  );

  await page.goto(TARGET_URL, { waitUntil: 'networkidle', timeout: 20000 });
  await page.waitForTimeout(4000); // main() async + animationend(0.01s) + slideToLoop(1500)

  const state = await page.evaluate(() => {
    const logo = document.getElementById('logo');
    const finalBtn = document.getElementById('logo-final-btn');
    const bf = document.querySelector('.banner-frame');
    const activeImg = document.querySelector('.swiper-slide-active img');
    return {
      hasContainer: !!document.getElementById('onead-dash-container'),
      hasBanner: !!document.getElementById('banner'),
      slideCount: document.querySelectorAll('.swiper-slide').length,
      logoDisplay: logo ? getComputedStyle(logo).display : 'no-logo',
      finalBtnDisplay: finalBtn ? getComputedStyle(finalBtn).display : 'no-finalBtn',
      finalBtnLeft: finalBtn ? getComputedStyle(finalBtn).left : null,
      bannerOpacity: bf ? getComputedStyle(bf).opacity : 'no-bf',
      activeImgSrc: activeImg ? activeImg.getAttribute('src') : null,
    };
  });
  console.log('== STATE (4s) ==');
  console.log(JSON.stringify(state, null, 2));
  await page.screenshot({ path: '/tmp/dash-stub.png', fullPage: false });
  console.log('📸 /tmp/dash-stub.png');

  console.log('\n== LOGS ==\n' + logs.join('\n'));
  await page.waitForTimeout(1500);
  await browser.close();
})();
