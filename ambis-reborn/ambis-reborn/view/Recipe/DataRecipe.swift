//
//  DataRecipe.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 03/08/21.
//

import Foundation

struct DataRecipe {
    static var recipes : [RecipeSample] = {
        var recipes: [RecipeSample] = []
        recipes = DataMeatRecipe.meatRecipes + DataSeafoodRecipe.seafoodRecipes + DataEggRecipe.eggRecipes
        return recipes
    }()
}

struct DataEggRecipe {
    static var eggRecipes: [RecipeSample] = [
        RecipeSample(
            name: "Telur Kornet",
            cookStep: [
                "Campur kornet, telur, bawang prei dan cabe yg sudah di iris tipis.",
                "Tambahkan garam merica saos tiram secukupnya dan tepung terigu.",
                "Goreng 1 sdm dulu setelah matang baru cek rasa.",
                "Dirasa sudah pas. Adonan siap di goreng.😊"],
            ingredient: [
                IngredientSample(name: "Kornet"),
                IngredientSample(name: "Bawang Prei"),
                IngredientSample(name: "Telur"),
                IngredientSample(name: "Tepung Terigu"),
                IngredientSample(name: "Cabe Rawit"),
                IngredientSample(name: "Garam"),
                IngredientSample(name: "Merica"),
                IngredientSample(name: "Saus Tiram")]),
        
        RecipeSample(
            name: "Telur Ceplok Kecap",
            cookStep: [
                "Ceplok telur lalu sisihkan",
                "Iris tipis dua bawang, cabe dan tomat",
                "Panaskan minyak tumis bumbu sampai harum",
                "Tambahkan kecap masukan telur tambahkan air sampai bumbu meresap",
                "Angkat dan sajikan dengan nasi panas"],
            ingredient: [
                IngredientSample(name: "Telur"),
                IngredientSample(name: "Bawang Merah"),
                IngredientSample(name: "Bawang Putih"),
                IngredientSample(name: "Tomat"),
                IngredientSample(name: "Cabe Merah Besar"),
                IngredientSample(name: "Kecap Bango")]),
        
        RecipeSample(
            name: "Telur Dadar Padang",
            cookStep: [
                "Kocok telur sebentar saja,jika kelamaan telurnya kempes saat didadar.",
                "Masukkan bumbu halus,aduk rata.",
                "Tambahkan bahan lainnya,beri garam dan kaldu bubuk,tes rasa.",
                "Panaskan wajan datar anti lengket dengan api besar, beri minyak goreng secukupnya.",
                "Setelah minyak panas,tuang kocokan telur,kecilkan api,tutup wajan.",
                "Jika sudah kokoh,balik telur dan masak sisi lainnya hingga matang.",
                "Angkat dan tiriskan.",
                "Sajikan saat masih hangat dengan nasi panas..lamakk banaa..ngga perlu sambel lagi..karna ini udah pedess..😰😰"],
            ingredient: [
                IngredientSample(name: "Telur Ayam atau Bebek"),
                IngredientSample(name: "Kelapa Parut"),
                IngredientSample(name: "Tepung Beras"),
                IngredientSample(name: "Air"),
                IngredientSample(name: "Daun Kunyit"),
                IngredientSample(name: "Daun Bawang"),
                IngredientSample(name: "Garam dan Kaldu Bubuk"),
                IngredientSample(name: "Bumbu Halus"),
                IngredientSample(name: "Cabe Merah"),
                IngredientSample(name: "Cabe Rawit"),
                IngredientSample(name: "Bawang Merah"),
                IngredientSample(name: "Bawang Putih"),
                IngredientSample(name: "Kunyit"),
                IngredientSample(name: "Kari Bubuk"),
                IngredientSample(name: "Ketumbar Bubuk"),
                IngredientSample(name: "Lada Bubuk")]),
        
        RecipeSample(
            name: "Telor Ceplok Saus Asam Manis",
            cookStep: [
                "Ceplok telur sisihkan",
                "Tumis bawang putih dan bawang bombay sampai harum lalu masukkan wortel",
                "Tumis sampai agak layu",
                "Kecilkan api",
                "tambahkan air dan masukkan duo saus serta bumbu perasa lain",
                "Aduk rata dan masak sampai meletup letup, lalu guyurkan ke telur ceplok"],
            ingredient: [
                IngredientSample(name: "Telur"),
                IngredientSample(name: "Wortel"),
                IngredientSample(name: "Bawang Putih"),
                IngredientSample(name: "Bawang Bombay"),
                IngredientSample(name: "Saus Tomat"),
                IngredientSample(name: "Saus Sambel"),
                IngredientSample(name: "Garam"),
                IngredientSample(name: "Merica"),
                IngredientSample(name: "Kaldu Bubuk"),
                IngredientSample(name: "Gula"),
                IngredientSample(name: "Air")]),
        
        RecipeSample(
            name: "Semur Telur Ayam",
            cookStep: [
                "Panaskan 3 sdm minyak goreng.",
                "Tumis bumbu halus sampai harum tambahkan tomat yg telah dihaluskan masak sampai matang",
                "Masukan salam, pala, lengkuas, jahe, kayu manis, bunga lawang, cengkeh dan sereh.",
                "Aduk2 sampai tercium aroma wangi rempahnya",
                "Masukan 2 - 3 gelas air tunggu sampai mendidih baru tambahkan telur, garam, gula, kecap, penyedap rasa (Masako Sapi)",
                "Masak terus sambil sesekali diaduk.",
                "Sampai kuah agak menyusut.",
                "Jika ingin berkuah banyak tinggal tambahkan air sesuai selera dan koreksi rasanya",
                "Angkat dan siap dihidangkan dg taburan bawang goreng"],
            ingredient: [
                IngredientSample(name: "Telur Ayam"),
                IngredientSample(name: "Daun Salam"),
                IngredientSample(name: "Sereh"),
                IngredientSample(name: "Kapulaga"),
                IngredientSample(name: "Bunga Lawang"),
                IngredientSample(name: "Cengkeh"),
                IngredientSample(name: "Kayu Manis"),
                IngredientSample(name: "Pala"),
                IngredientSample(name: "Jahe"),
                IngredientSample(name: "Lengkuas"),
                IngredientSample(name: "Gula Pasir"),
                IngredientSample(name: "Garam"),
                IngredientSample(name: "Kecap Manis Bango"),
                IngredientSample(name: "Bumbu Halus"),
                IngredientSample(name: "Bawang Merah"),
                IngredientSample(name: "Bawang Putih"),
                IngredientSample(name: "Merica"),
                IngredientSample(name: "Kemiri Sangrai"),
                IngredientSample(name: "Tomat Merah")])
        
    ]
    
    
}

struct DataMeatRecipe {
    static var meatRecipes: [RecipeSample] = [
        RecipeSample(
            name: "Ayam Goreng Bawang Khas Batam",
            cookStep: [
                "Cuci ayam hingga bersih kemudian tiriskan masukan bumbu halus,garam,kaldu jamur tepung maizena&telur aduk hingga tercampur rata",
                "Diamkan kurang lebih 30 menit di kulkas supaya bumbu meresap",
                "Panaskan minyak goreng kemudian goreng bawang putih hingga kuning&garing tiriskan",
                "Kemudian goreng ayam hingga coklat keemasan&matang merata *saya pakai api kecil saja* untuk ayam nya goreng bertahap jangan sekali goreng semua nya angkat&tiriskan",
                "Ayam goreng bawang siap di sajikan😊"],
            ingredient: [
                IngredientSample(name: "Ayam"),
                IngredientSample(name: "bawang putih"),
                IngredientSample(name: "telur"),
                IngredientSample(name: "tepung maizena"),
                IngredientSample(name: "garam & kaldu jamur"),
                IngredientSample(name: "minyak goreng"),
                IngredientSample(name: "bawang putih halus"),
                IngredientSample(name: "bawang merah halus"),
                IngredientSample(name: "ketumbar bubuk"),
                IngredientSample(name: "merica bubuk"),
                IngredientSample(name: "jahe"),
                IngredientSample(name: "kunyit")]),
        
        RecipeSample(
            name: "Ayam Goreng Kecap",
            cookStep: [
                "Lumuri ayam dg air jeruk nipis dan garam, remas2, bilas bersih. Ungkep ayam dg garam dan merica. Boleh jg lgs goreng tp potong agak kecil.",
                "Setelah diungkep, goreng ayam hngga sedikit kecokelatan, angkat.",
                "Panaskan secukupnya minyak, tumis bawang putih dan jahe, masukkan bawang bombay, tumis hingga harum. Masukkan cabe merah iris, ayam goreng, bubuhi gula garam, merica dan kecap, tuangair. Masak hingga kuah mengental, sesaat sblm diangkat, masukkan daun bawang.",
                "Angkat ayam dan sajikan😋"],
            ingredient: [
                IngredientSample(name: "Ayam"),
                IngredientSample(name: "bawang bombay"),
                IngredientSample(name: "jahe"),
                IngredientSample(name: "cabe merah"),
                IngredientSample(name: "bawang putih halus"),
                IngredientSample(name: "daun bawang"),
                IngredientSample(name: "gula"),
                IngredientSample(name: "garam"),
                IngredientSample(name: "air"),
                IngredientSample(name: "merica bubuk"),
                IngredientSample(name: "minyak goreng")]),
        
        RecipeSample(
            name: "Mie Ayam",
            cookStep: [
                "Rebus mie telur sampai matang",
                "Rebus ayam hingga empuk dengan sedikit garam kemudian potong kecil2",
                "Tumis bawang bombay, bawang merah, bawang putih hingga harum",
                "Tambahkan jahe giling, daun salam, daun jeruk dan serai.",
                "Masukkan kecap manis, kecap asin, kecap inggris, minyak wijen dan saos tiram.",
                "Masukan ayam yang telah di rebus aduk rata.",
                "Masukkan garam, penyedap rasa, dan merica bubuk sesuai selera",
                "Tambahkan sedikit air, masukan potongan daun bawang. Masak hingga empuk",
                "Bahan kuah, siapkan air. Masukkan daun bawang, kaldu ayam, dan merica bubuk",
                "Tata mie ayam. Letakkan mie, toping ayam dan siram dengan kuah."],
            ingredient: [
                IngredientSample(name: "mie telur"),
                IngredientSample(name: "ayam"),
                IngredientSample(name: "bawang bombay"),
                IngredientSample(name: "bawang merah halus"),
                IngredientSample(name: "bawang putih halus"),
                IngredientSample(name: "jahe halus"),
                IngredientSample(name: "kecap manis"),
                IngredientSample(name: "kecap asin"),
                IngredientSample(name: "saos tiram"),
                IngredientSample(name: "kecap inggris"),
                IngredientSample(name: "minyak wijen"),
                IngredientSample(name: "daun jeruk"),
                IngredientSample(name: "daun salam"),
                IngredientSample(name: "serai"),
                IngredientSample(name: "daun bawang"),
                IngredientSample(name: "garam dan penyedap rasa"),
                IngredientSample(name: "merica bubuk")]),
        
        RecipeSample(
            name: "Ayam Woku Manado",
            cookStep: ["Rebus Ayam di air Mendidih 7 Menit, buang kotorannya, bilas n Tiriskan.",
                       "Di Wajan, Tumis Bumbu halus dgn Minyak sampai Harum, masukkan daun jeruk, salam, pandan,sereh, tumis sampai Matang..",
                       "Masukkan Ayam, aduk Rata. Tambahkan Air dan Garam, gula n kaldu, tomat potong, aduk rata, koreksi Rasa.",
                       "Masak sampai Ayam Matang empuk n kuah menyusut. Matikan api, lalu masukkan daun kemangi, aduk sampai daun layu."],
            ingredient: [
                IngredientSample(name: "bawang merah halus"),
                IngredientSample(name: "bawang putih halus"),
                IngredientSample(name: "jahe halus"),
                IngredientSample(name: "kunyit halus"),
                IngredientSample(name: "kemiri halus"),
                IngredientSample(name: "cabe merah"),
                IngredientSample(name: "cabe rawit"),
                IngredientSample(name: "ayam"),
                IngredientSample(name: "daun kemangi"),
                IngredientSample(name: "daun jeruk"),
                IngredientSample(name: "daun kunyit"),
                IngredientSample(name: "daun salam"),
                IngredientSample(name: "daun pandan"),
                IngredientSample(name: "sereh"),
                IngredientSample(name: "tomat merah"),
                IngredientSample(name: "kaldu bubuk"),
                IngredientSample(name: "garam"),
                IngredientSample(name: "gula"),
                IngredientSample(name: "air"),
                IngredientSample(name: "minyak goreng")]),
        
        RecipeSample(
            name: "Chicken Katsu",
            cookStep: [
                "Potong potong fillet ayam dengan ukuran sesuai selera. Kemudian lumuri dengan jeruk nipis/lemon, lalu cuci bersih.",
                "Marinasi dengan bawang putih, garam, merica, kaldu jamur, dan gula. Diamkan sekitar 15 menit hingga bumbu meresap.",
                "Tempatkan terpung terigu dan tepung panir di masing masing piring yang berbeda. Beri sedikit garam pada kocokan telur. Ambil 1 lembar daging ayam yang sudah di marinasi, gulingkan kedalam tepung terigu, masukkan kedalam kocokan telur, dan terakhir gulingkan diatas tepung panir. Lakukan berulang sampai daging ayam habis :)",
                "Goreng di minyak panas dengan api Sedang.", "Bila ingin menggoreng nanti atau besok, Chicken katsu yang sudah dilumuri tepung panir bisa disimpan di freezer. Bila ingin digoreng, keluarkan dari freezer dan diamkan sebentar hingga chicken katsu mencapai suhu ruang baru digoreng ^-^", "Chicken katsu siap disantap."],
            ingredient: [
                IngredientSample(name: "fillet ayam"),
                IngredientSample(name: "garam"),
                IngredientSample(name: "bawang putih halus"),
                IngredientSample(name: "merica bubuk"),
                IngredientSample(name: "kaldu jamur"),
                IngredientSample(name: "gula"),
                IngredientSample(name: "telur ayam"),
                IngredientSample(name: "tepung panir"),
                IngredientSample(name: "tepung terigu")])
      
    ]
}

struct DataSeafoodRecipe {
    
    static var seafoodRecipes: [RecipeSample] = [
        RecipeSample(
            name: "Tenggiri Kuah Asam Pedas",
            cookStep: ["Cuci bersih ikan dan lumuri air jeruk nipis, diamkan 15 menit",
                       "Kemudian cuci kembali sampai bersih dan sisihkan.",
                       "Rebus air dalam panci hingga mendidih.",
                       "Tumis bumbu sampai wangi, masukkan cabe, daun jeruk, kunyit, serai & jahe, aduk2 sampai layu, tuang tumisan bumbu kedalam panci berisi air mendidih, bumbui garam & gula, masukkan ikan, masak sampai mendidih kembali.",
                       "Masukkan belimbing wuluh & cabe rawit utuh, masak sampai bumbu meresap, tes rasa, sebelum diangkat masukkan irisan tomat hijau, matikan api, taburi daun bawang sajikan."],
            ingredient: [
                IngredientSample(name: "Ikan Tenggiri"),
                IngredientSample(name: "Jeruk Nipis"),
                IngredientSample(name: "Tomat Hijau"),
                IngredientSample(name: "Serai"),
                IngredientSample(name: "Kunyit"),
                IngredientSample(name: "Belimbing"),
                IngredientSample(name: "Cabe Rawit"),
                IngredientSample(name: "Cabe Merah"),
                IngredientSample(name: "Daun Bawang"),
                IngredientSample(name: "Jahe"),
                IngredientSample(name: "Garam"),
                IngredientSample(name: "Gula"),
                IngredientSample(name: "Lada Bubuk"),
                IngredientSample(name: "Bawang Merah"),
                IngredientSample(name: "Bawang Putih")
            ]),
        
        RecipeSample(
            name: "Tongkol Jengkol Balado",
            cookStep: ["Cuci bersih ikan kemudian lumuri dengan air jeruk nipis dan beri sedikit garam diamkan sebentar.",
                       "Panaskan minyak goreng masukan jengkol masak hingga jengkol empuk,buang kulit nya.",
                       "Pipihkan dan sisihkan kemudian goreng ikan tongkol sampai matang angkat tiriskan.",
                       "Bila minyak terlalu kotor ganti dengan yang baru.",
                       "masukan bumbu halus tambahkan garam kemudian masak hingga bau langu cabe hilang tambahkan kaldu jamur tes rasa bila sudah pas campur rata tongkol&jengkol dengan bumbu balado salin ke wadah dan sajikan."],
            ingredient: [
                IngredientSample(name: "Ikan Tongkol"),
                IngredientSample(name: "Jengkol"),
                IngredientSample(name: "Jeruk Nipis"),
                IngredientSample(name: "Minyak Goreng"),
                IngredientSample(name: "Garam"),
                IngredientSample(name: "Kaldu Jamur"),
                IngredientSample(name: "Cabe Merah"),
                IngredientSample(name: "Bawang Merah"),
                IngredientSample(name: "Bawang Putih")
            ]),
        
        RecipeSample(
            name: "Pecak Gurame",
            cookStep: ["Bersihkan ikan lalu cuci bersih.",
                       "Lumuri dengan jeruk nipis. Biarkan 15 menit.",
                       "Haluskan bumbu ikan lalu lumuri kebadan ikan hingga rata. Biarkan 15 menit.",
                       "Goreng ikan hingga kering. Api kecil, dan jangan balik sebelum benar2 kering. Tutup penggorengannya ya. Angkat dan tiriskan.",
                       "Buat bumbu pecak. Sangrai bumbu pecak hinga kering lalu tumbuk kasar.",
                       "Tumis bumbu pecak hingga harum. Masukan bumbu pelengkap serai, daun jeruk dan tomat hijau. Masak hingga wangi.",
                       "Masukan air, air asam, gula dan garam. Aduk rata lalu koreksi rasa. Masak air tinggal sedikit.",
                       "Tata di piring saji. Siram ikan gurame goreng dengan sambal pecak."],
            ingredient: [
                IngredientSample(name: "Ikan Gurame"),
                IngredientSample(name: "Jeruk Nipis"),
                IngredientSample(name: "Bawang Putih"),
                IngredientSample(name: "Bawang Merah"),
                IngredientSample(name: "Kunyit"),
                IngredientSample(name: "Ketumbar"),
                IngredientSample(name: "Minyak Goreng"),
                IngredientSample(name: "Garam"),
                IngredientSample(name: "Jahe"),
                IngredientSample(name: "Kencur"),
                IngredientSample(name: "Kemiri"),
                IngredientSample(name: "Cabe Merah"),
                IngredientSample(name: "Cabe Merah Keriting"),
                IngredientSample(name: "Cabe Rawit"),
            ]),
        
        RecipeSample(
            name: "Lele Goreng",
            cookStep: ["Rendam lele dgn bumbu halus yg sdh diberi air dan cuka kurang lebih 15-30 menit",
                       "Sesaat sblm digoreng, taburi tepung bumbu lalu ratakan.",
                       "Goreng dlm minyak banyak yg sdh panas dgn api sedang, goreng hingga kecoklatan kemudian angkat dan sajikan."],
            ingredient: [
                IngredientSample(name: "Ikan Lele"),
                IngredientSample(name: "Tepung Bumbu"),
                IngredientSample(name: "Bawang Putih"),
                IngredientSample(name: "Kunyit"),
                IngredientSample(name: "Kemiri"),
                IngredientSample(name: "Garam"),
                IngredientSample(name: "Ketumbar")
            ]),
        
        RecipeSample(
            name: "Nasi Goreng Salmon",
            cookStep: ["Tumis sebagian bawang putih dan sedikit garam dengan 2 sdm minyak sayur.",
                       "Kemudian masukkan salmon fillet yang sudah dipotong dadu sampai matang dan sisihkan.",
                       "Lalu masukkan kembali 2sdm minyak sayur lalu tumis sebagian lagi bawang putih, bawang merah, garam sampai wangi lalu masukkan kecap manis kemudian terakhir masukkan nasi dan beri lada sesuai selera.",
                       "Masukkan ikan salmon, tumis kembali sampai menyatu. Lalu angkat dan sajikan."],
            ingredient: [
                IngredientSample(name: "Salmon"),
                IngredientSample(name: "Nasi"),
                IngredientSample(name: "Kecap Manis"),
                IngredientSample(name: "Bawang Putih"),
                IngredientSample(name: "Bawang Merah"),
                IngredientSample(name: "Garam"),
                IngredientSample(name: "Minyak Goreng"),
                IngredientSample(name: "Lada")
            ])
    ]
}
