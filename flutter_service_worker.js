'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "3ebd2dcf49c12895f75cc55dc0482b9f",
".git/config": "1f8dfd32daebcf7fe98818f56edadece",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "36d2e6bfefea098ed28d3260f6fd2002",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "827f436be42a28ed4bb65095a1e94474",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "20a7b878f01b62ac2aa87d85eae30e02",
".git/logs/refs/heads/deploy": "629cefe3fc3aaa53ce9adc7a61380a5b",
".git/logs/refs/remotes/origin/deploy": "c5125909526f5a268197999d8922016f",
".git/objects/02/204bc0d44db43924c8bb04594b61b95b7f8dd1": "ed4e2f8e5e4fe928081041f55c4fa27a",
".git/objects/08/27c17254fd3959af211aaf91a82d3b9a804c2f": "360dc8df65dabbf4e7f858711c46cc09",
".git/objects/0c/3a46dec1a0ff77b4b13ef625036748875827d7": "948cdeff3a1413422649566218f38fb1",
".git/objects/0e/0d6aee137ce651891a9cb2e248f06ad19d184e": "eba9ce788a8ef668fc20fa9e9d469caf",
".git/objects/1e/11e9d2ed99d1b57d50311dab853d0cf299be44": "0972ee4f245b8cd955b86be700fd07f1",
".git/objects/24/ba434f232d4f1729ea8e4039ee5f5256527f50": "ae1d02c4bfb9fa9d212039b60c6139fb",
".git/objects/2d/157d035cb1e05604f28ac021e49bb110d0f249": "3c2b2ca97e69ae36e1ffb8fb23790308",
".git/objects/33/bebb6b056c78601126a55c5c65caa6c1ef131e": "0cb90aeb589d775e9ef289e110c3edf3",
".git/objects/36/3a77bcb8ee073b6a99a73566164d9c0ae243b2": "bdf071fa859eb9cc8f1cfbf7fa3d8118",
".git/objects/37/dd833bf4f19c91da5b6f5a3812a56ae53b52c7": "f32d9a8511736e007ff7ccce5fba3ea8",
".git/objects/3a/8cda5335b4b2a108123194b84df133bac91b23": "1636ee51263ed072c69e4e3b8d14f339",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/47/c955a6e9b8d82bb4d69b5b3bc6bfeacf1cf070": "f119210b2af23ef31300055648c9df03",
".git/objects/48/40e8e7e299a9129f2cea8cd10c7790e49a0143": "2bbd73785c1da699140ea5e6eb8989da",
".git/objects/4a/62f678ece1d84f6b8fe05e2d13609c61d064b6": "435a755d30c9a61a5874cf1e8c93f987",
".git/objects/51/03e757c71f2abfd2269054a790f775ec61ffa4": "d437b77e41df8fcc0c0e99f143adc093",
".git/objects/51/93ba9d362b457b22d239f40547d0b7519cc3b3": "acb19fe91d7d19abbb47f328ff9f857f",
".git/objects/52/247279b275a47cd0cd59007e79ac80220c53a6": "8540a5ebd61c8894b64bde00ba68b6c8",
".git/objects/52/f98dfaf28a41d2ecddaab1e0b88cd475d25025": "327295d6664df0a642852f53384bbb64",
".git/objects/59/9b708d96be5657f97f53a3a9f579e4e5301211": "641d5e04840c8e532df904eecfdf7afa",
".git/objects/68/43fddc6aef172d5576ecce56160b1c73bc0f85": "2a91c358adf65703ab820ee54e7aff37",
".git/objects/6a/f5b0dd885bfde8e6d482e9b749e3ad874b71c3": "cb6ac532e10255bbc1bba6c9219f5c24",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/6d/d2b7b911f533bd350da16856b9c6b5a1ced5c6": "21070ee4c88c5c0daa338e0d2dcda90a",
".git/objects/6f/7661bc79baa113f478e9a717e0c4959a3f3d27": "985be3a6935e9d31febd5205a9e04c4e",
".git/objects/73/377530c1677411dd865e62822152993f321e0b": "f513c7a30388ebd2e1e3e84b881b33a8",
".git/objects/75/d12d117b7d97cd14705ba0ed2e358f105647a9": "f13658bdd8fac07b9268e3c674ab1e62",
".git/objects/7c/3463b788d022128d17b29072564326f1fd8819": "37fee507a59e935fc85169a822943ba2",
".git/objects/82/001fd3c30259313ef361619a94bc5e53b91e05": "e1fb5d957ccfe64ee90293dd531c4dee",
".git/objects/85/63aed2175379d2e75ec05ec0373a302730b6ad": "997f96db42b2dde7c208b10d023a5a8e",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/89/807203695f10ae6ecea1f00fbf4b74fbeedcc9": "2a30df04e7a0210b499ee0f0f2460bb9",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8e/21753cdb204192a414b235db41da6a8446c8b4": "1e467e19cabb5d3d38b8fe200c37479e",
".git/objects/93/b363f37b4951e6c5b9e1932ed169c9928b1e90": "c8d74fb3083c0dc39be8cff78a1d4dd5",
".git/objects/94/cecfa8b81cf264db94b4d91e500e7d861d7e21": "e89f33e73ad69757b59248b61cb1a33a",
".git/objects/98/4d01db75edb6e35d338c019a6b7e819e1ec94a": "a5a45dfe6ad5de8455f2516d41f5b0e0",
".git/objects/a6/069b0628de3f22052acc5f1e00bed38e7f05ac": "2aeefde6c1d7b71971b08a0e97b98627",
".git/objects/a7/3f4b23dde68ce5a05ce4c658ccd690c7f707ec": "ee275830276a88bac752feff80ed6470",
".git/objects/aa/f4297ecc777fb36885f53e3b0740d55f4d57f9": "8afa1ae091b22a29216ef9aa60dfb81e",
".git/objects/ad/ced61befd6b9d30829511317b07b72e66918a1": "37e7fcca73f0b6930673b256fac467ae",
".git/objects/b2/2657fd1fcaeafedaec9194a33d703df1675ad2": "ae990bcec9accd4754f1c2fc5a714844",
".git/objects/b5/9c6d1843722b4c807bfd829204ed1eda30a3e1": "40b455a15ae12cc163fdf1f45ecaefef",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/3e39bd49dfaf9e225bb598cd9644f833badd9a": "666b0d595ebbcc37f0c7b61220c18864",
".git/objects/ba/28ec4bf8bec3943cafecf74cbf10e610468171": "683eaa5b95aeeb625ca4fdde72244b55",
".git/objects/c3/576162eba4de1af31f552c0210ba1e440fe6ee": "f573db5eb9a849bc67917d1ddde10e97",
".git/objects/c4/c032ab86d027aac5bcb98ae964f37a75f5768a": "e6c5cce2ce126319677ec30b21855ffe",
".git/objects/c8/3af99da428c63c1f82efdcd11c8d5297bddb04": "144ef6d9a8ff9a753d6e3b9573d5242f",
".git/objects/d4/17456ff86c3a7d986fdfa6b98f45877bf4ed5c": "736696d7040e975c8262dd3c6fbc6603",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d7/7cfefdbe249b8bf90ce8244ed8fc1732fe8f73": "9c0876641083076714600718b0dab097",
".git/objects/d9/5b1d3499b3b3d3989fa2a461151ba2abd92a07": "a072a09ac2efe43c8d49b7356317e52e",
".git/objects/db/7179708df52478e5b06ed7f7958e10c9aa75ba": "bd33c58631a5bfa64d980a07201e2523",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/e9/ca608d5410626e5791b6a13e41b603c83c0c3f": "08826c44a2d7076cb5154b69e2f34662",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ed/0e9b5593d34762f29a4619eec7deb9d48db355": "5cea3085a67c07aeb530a4c6a74a698a",
".git/objects/f3/3e0726c3581f96c51f862cf61120af36599a32": "afcaefd94c5f13d3da610e0defa27e50",
".git/objects/f5/05628661ebde30f96abcab06c0c9bf8ee0b491": "d2b4e8bc054f1a091549ef4c9167fad9",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/f6/e6c75d6f1151eeb165a90f04b4d99effa41e83": "95ea83d65d44e4c524c6d51286406ac8",
".git/objects/f7/8020c1b02c0f5a794308bc26a1b05a77cf998d": "4dd82f198d2cc995f25949a7faf136f9",
".git/objects/fd/05cfbc927a4fedcbe4d6d4b62e2c1ed8918f26": "5675c69555d005a1a244cc8ba90a402c",
".git/refs/heads/deploy": "d8540bac291a734fb1f8d63653b118f3",
".git/refs/remotes/origin/deploy": "d8540bac291a734fb1f8d63653b118f3",
"assets/AssetManifest.bin": "09632ebcd2ea485e0b829dc48482cd32",
"assets/AssetManifest.bin.json": "8476d0f9e79ffebecc19afc1703a6c0d",
"assets/assets/images/bg_logo.png": "a0ad9d24f1d2073db0295fbf5999139d",
"assets/assets/images/call.PNG": "986d8f8ca22cbefd9827b05d20de08de",
"assets/assets/images/certifird_iso.PNG": "ec41399113435cc046a122e426f25371",
"assets/assets/images/close.PNG": "bf4a91292676e6805a2f690c265f29ae",
"assets/assets/images/email.PNG": "15bba875d52b478733de2f4ad4fd2c0b",
"assets/assets/images/facebook.PNG": "7452a5700f2ff7dcbfeb1d7607215216",
"assets/assets/images/india_mart.PNG": "987e5418a42ec07da1a4fe1a03af1b9c",
"assets/assets/images/india_mart_a.PNG": "9fafa1e55b59bbafe35b45df043fa043",
"assets/assets/images/insta.PNG": "e0b28a062eec6b95d6e5353e25a199e5",
"assets/assets/images/linkdink.PNG": "f31d458df158099133468ec54e303fb3",
"assets/assets/images/logo.PNG": "e85846d9b7d9b3d9abdc932fd97eb909",
"assets/assets/images/logoh.png": "32f333d71e3ae56c6610cb011d5b47e4",
"assets/assets/images/message.PNG": "1549e35db564b7efe005299f1a20b476",
"assets/assets/images/msme.PNG": "a1fa3ce9c527015ef2675cab96657e4a",
"assets/assets/images/plant.png": "381993a9fa895f4658cdf262268d20fb",
"assets/assets/images/psara.PNG": "dc9ffe7e81f1f9e6ecad1145f26d670e",
"assets/assets/images/roggar.PNG": "40dc96ccada33e68fc14c46b471ea828",
"assets/assets/images/twitter.PNG": "331ccf0d76c236beb3f9ef2adf8c9306",
"assets/assets/images/whatsapp.PNG": "06df920d0d0dada2f391d8983857117b",
"assets/assets/images/youtube.PNG": "497e24d5b8b74c8517ee960516c9bfde",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "c4cf4c8cc4cc1927e30579560419064e",
"assets/NOTICES": "107b986cf93d42e933cb35063b947fc9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "dedd8ed7c89dcc27670f430d824cc382",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "e91c3cbb702b084afccb041ae70b068e",
"/": "e91c3cbb702b084afccb041ae70b068e",
"main.dart.js": "5cf14931da936b48645e16fb8736fa00",
"manifest.json": "7ffdf66d3f844f2b1f64a095a6bf5441",
"version.json": "d5c008fcf42e49453ce9ed0c4f0a49bc"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
