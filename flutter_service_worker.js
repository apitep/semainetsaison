'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "4ea1bb3e3e130dcae441684036aa5e81",
"/": "4ea1bb3e3e130dcae441684036aa5e81",
"main.dart.js": "e20c0327c3b01cb5913ba7b180c71725",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "c3be92d44e1c3fdf2d961e1383906aa0",
"fonts/MontserratAlternates/MontserratAlternates-Thin.ttf": "6e886333f6bd82efa51d4c734d9a15b3",
"fonts/MontserratAlternates/MontserratAlternates-BlackItalic.ttf": "554197ea1f2aae385367a6d636cf152c",
"fonts/MontserratAlternates/MontserratAlternates-Bold.ttf": "858597948628fafd5ba6d71a820cf7f6",
"fonts/MontserratAlternates/MontserratAlternates-ExtraLightItalic.ttf": "9118d19c662e3cd69f6848c24a2dcb20",
"fonts/MontserratAlternates/MontserratAlternates-Black.ttf": "afa40ea840bfbd499ad6586e94c4e489",
"fonts/MontserratAlternates/MontserratAlternates-LightItalic.ttf": "1117f6b3d0340c3b0c5723f794f7d397",
"fonts/MontserratAlternates/MontserratAlternates-Medium.ttf": "55b7b1d414ea6d2094b85e3a834e32b8",
"fonts/MontserratAlternates/MontserratAlternates-MediumItalic.ttf": "eb22d47a0b4b7891695374c70effc968",
"fonts/MontserratAlternates/MontserratAlternates-Italic.ttf": "9ad5b4624c9b7b582c8d0705779c9f53",
"fonts/MontserratAlternates/MontserratAlternates-ExtraBoldItalic.ttf": "c07bb85cb211c8e4e69d31cfe42e1bcf",
"fonts/MontserratAlternates/MontserratAlternates-BoldItalic.ttf": "7ad02dea12bbc6e4d8ffadac7bc61c86",
"fonts/MontserratAlternates/MontserratAlternates-Light.ttf": "9d57f922362adf8bf6e3ad79f01207ff",
"fonts/MontserratAlternates/MontserratAlternates-ExtraLight.ttf": "ce3e6591e29aa7808adb6aba6bd24d30",
"fonts/MontserratAlternates/MontserratAlternates-Regular.ttf": "778e16de3b7bbf4100f31ff4d6307216",
"fonts/MontserratAlternates/MontserratAlternates-ThinItalic.ttf": "786e2b0cc485e13ae0403b42c3aca346",
"fonts/MontserratAlternates/MontserratAlternates-SemiBold.ttf": "2e719d5e579b791d74a1c5d84e0b766b",
"fonts/MontserratAlternates/MontserratAlternates-ExtraBold.ttf": "66e38dda7bea2a9ebb8f85e4b2a99ede",
"fonts/MontserratAlternates/MontserratAlternates-SemiBoldItalic.ttf": "584d58bbefcfdd1023cae6ae5ebc70f6",
"assets/LICENSE": "a59d9e60a2ca0f10208dcf4724ac64d4",
"assets/AssetManifest.json": "0d719582e1bd63b03800ef4fc54eb9bb",
"assets/FontManifest.json": "ddc129685cd605abbd99129bd6879be5",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/assets/images/girafe1.png": "66f69d871daace38fcd7d1b6a8c013fd",
"assets/assets/images/ApitepBearSmallLogo.png": "e66a14704f91ca9e058159ab35d236b9",
"assets/assets/images/girafe2.png": "22b91c52ae881dc204ea02a020bca9bc",
"assets/assets/images/ApitepBearLogo.png": "bf9e9ae018b0d2269a3f2cb5bc751288",
"assets/assets/images/ecoleloisirslogo.png": "a637d6a61ce7a48183fb4e7d7e123902",
"assets/assets/images/girafe3.png": "787b6adfd5bb5dd007eac00e5c517b31",
"assets/assets/images/bluewagon.png": "2edc65e3d48c37d2ba6567b4dd358e10",
"assets/assets/images/greenwagon.png": "b5d97d371ef7b867ab7fd005dbadeaeb",
"assets/assets/images/trainbleudesmots.png": "67a8936b165d8265df531e0f9dc2cacf",
"assets/assets/images/blueloco.png": "9aefa6c556be7fbbe4325abab008bb0a",
"assets/assets/sounds/trainvapeur.mp3": "18d479f852f4c003e318579523099457",
"assets/assets/sounds/sifflement.mp3": "c5bdda315cc769a14a9b9c4b5f94c418",
"assets/assets/sounds/success.mp3": "5acc4c358abe356ab34cb46990213c87",
"assets/assets/sounds/homeintro.mp3": "955952d73d9c61ea7149ca25e0af2c7d",
"assets/assets/fonts/Montserrat-Alternates/MontserratAlternates-Thin.ttf": "6e886333f6bd82efa51d4c734d9a15b3",
"assets/assets/fonts/Montserrat-Alternates/MontserratAlternates-Bold.ttf": "858597948628fafd5ba6d71a820cf7f6",
"assets/assets/fonts/Montserrat-Alternates/MontserratAlternates-Light.ttf": "9d57f922362adf8bf6e3ad79f01207ff",
"assets/assets/fonts/Montserrat-Alternates/MontserratAlternates-ExtraLight.ttf": "ce3e6591e29aa7808adb6aba6bd24d30",
"assets/assets/fonts/Montserrat-Alternates/MontserratAlternates-Regular.ttf": "778e16de3b7bbf4100f31ff4d6307216",
"assets/assets/fonts/Montserrat-Alternates/MontserratAlternates-SemiBold.ttf": "2e719d5e579b791d74a1c5d84e0b766b",
"assets/assets/fonts/Montserrat-Alternates/MontserratAlternates-SemiBoldItalic.ttf": "584d58bbefcfdd1023cae6ae5ebc70f6",
"assets/assets/data/stories.json": "d0bcd37b6f0c5b7fa25257f25e33b492"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
