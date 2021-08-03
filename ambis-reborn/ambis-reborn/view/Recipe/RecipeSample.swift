//
//  RecipeSample.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/29/21.
//

import Foundation

struct RecipeSample {
    var name: String
    var prepTime: Int = 0
    var cookTime: Int = 0
    var cookMethod: String = ""
    var cookStep: [String]
    var totalServes: Int = 0
    
    var ingredient: [IngredientSample]
    
    var defaultRecipes: [RecipeSample] = [RecipeSample(name: "Ayam Goreng Bawang Khas Batam",
                                                       cookStep: ["Cuci ayam hingga bersih kemudian tiriskan masukan bumbu halus,garam,kaldu jamur tepung maizena&telur aduk hingga tercampur rata", "Diamkan kurang lebih 30 menit di kulkas supaya bumbu meresap", "Panaskan minyak goreng kemudian goreng bawang putih hingga kuning&garing tiriskan", "Kemudian goreng ayam hingga coklat keemasan&matang merata *saya pakai api kecil saja* untuk ayam nya goreng bertahap jangan sekali goreng semua nya angkat&tiriskan", "Ayam goreng bawang siap di sajikan😊"],
                                                       ingredient: [IngredientSample(name: "Ayam"), IngredientSample(name: "bawang putih"), IngredientSample(name: "telur"), IngredientSample(name: "tepung maizena"), IngredientSample(name: "garam & kaldu jamur"), IngredientSample(name: "minyak goreng"), IngredientSample(name: "bawang putih halus"), IngredientSample(name: "bawang merah halus"), IngredientSample(name: "ketumbar bubuk"), IngredientSample(name: "merica bubuk"), IngredientSample(name: "jahe"), IngredientSample(name: "kunyit")]),
                                          RecipeSample(name: "Ayam Goreng Kecap",
                                                       cookStep: ["Lumuri ayam dg air jeruk nipis dan garam, remas2, bilas bersih. Ungkep ayam dg garam dan merica. Boleh jg lgs goreng tp potong agak kecil.", "Setelah diungkep, goreng ayam hngga sedikit kecokelatan, angkat.", "Panaskan secukupnya minyak, tumis bawang putih dan jahe, masukkan bawang bombay, tumis hingga harum. Masukkan cabe merah iris, ayam goreng, bubuhi gula garam, merica dan kecap, tuangair. Masak hingga kuah mengental, sesaat sblm diangkat, masukkan daun bawang.", "Angkat ayam dan sajikan😋"],
                                                       ingredient: [IngredientSample(name: "Ayam"), IngredientSample(name: "bawang bombay"), IngredientSample(name: "jahe"), IngredientSample(name: "cabe merah"), IngredientSample(name: "bawang putih halus"), IngredientSample(name: "daun bawang"), IngredientSample(name: "gula"), IngredientSample(name: "garam"), IngredientSample(name: "air"), IngredientSample(name: "merica bubuk"), IngredientSample(name: "minyak goreng")]),
                                          RecipeSample(name: "Mie Ayam",
                                                       cookStep: ["Rebus mie telur sampai matang", "Rebus ayam hingga empuk dengan sedikit garam kemudian potong kecil2", "Tumis bawang bombay, bawang merah, bawang putih hingga harum", "Tambahkan jahe giling, daun salam, daun jeruk dan serai.", "Masukkan kecap manis, kecap asin, kecap inggris, minyak wijen dan saos tiram.", "Masukan ayam yang telah di rebus aduk rata.", "Masukkan garam, penyedap rasa, dan merica bubuk sesuai selera", "Tambahkan sedikit air, masukan potongan daun bawang. Masak hingga empuk", "Bahan kuah, siapkan air. Masukkan daun bawang, kaldu ayam, dan merica bubuk", "Tata mie ayam. Letakkan mie, toping ayam dan siram dengan kuah."],
                                                       ingredient: [IngredientSample(name: "mie telur"), IngredientSample(name: "ayam"), IngredientSample(name: "bawang bombay"), IngredientSample(name: "bawang merah halus"), IngredientSample(name: "bawang putih halus"), IngredientSample(name: "jahe halus"), IngredientSample(name: "kecap manis"), IngredientSample(name: "kecap asin"), IngredientSample(name: "saos tiram"), IngredientSample(name: "kecap inggris"), IngredientSample(name: "minyak wijen"), IngredientSample(name: "daun jeruk"), IngredientSample(name: "daun salam"), IngredientSample(name: "serai"), IngredientSample(name: "daun bawang"), IngredientSample(name: "garam dan penyedap rasa"), IngredientSample(name: "merica bubuk")]),
                                          RecipeSample(name: "Ayam Woku Manado",
                                                       cookStep: ["Rebus Ayam di air Mendidih 7 Menit, buang kotorannya, bilas n Tiriskan.", "Di Wajan, Tumis Bumbu halus dgn Minyak sampai Harum, masukkan daun jeruk, salam, pandan,sereh, tumis sampai Matang..", "Masukkan Ayam, aduk Rata. Tambahkan Air dan Garam, gula n kaldu, tomat potong, aduk rata, koreksi Rasa.", "Masak sampai Ayam Matang empuk n kuah menyusut. Matikan api, lalu masukkan daun kemangi, aduk sampai daun layu."],
                                                       ingredient: [IngredientSample(name: "bawang merah halus"), IngredientSample(name: "bawang putih halus"), IngredientSample(name: "jahe halus"), IngredientSample(name: "kunyit halus"), IngredientSample(name: "kemiri halus"), IngredientSample(name: "cabe merah"), IngredientSample(name: "cabe rawit"), IngredientSample(name: "ayam"), IngredientSample(name: "daun kemangi"), IngredientSample(name: "daun jeruk"), IngredientSample(name: "daun kunyit"), IngredientSample(name: "daun salam"), IngredientSample(name: "daun pandan"), IngredientSample(name: "sereh"), IngredientSample(name: "tomat merah"), IngredientSample(name: "kaldu bubuk"), IngredientSample(name: "garam"), IngredientSample(name: "gula"), IngredientSample(name: "air"), IngredientSample(name: "minyak goreng")]),
                                          RecipeSample(name: "Chicken Katsu",
                                                       cookStep: ["Potong potong fillet ayam dengan ukuran sesuai selera. Kemudian lumuri dengan jeruk nipis/lemon, lalu cuci bersih.", "Marinasi dengan bawang putih, garam, merica, kaldu jamur, dan gula. Diamkan sekitar 15 menit hingga bumbu meresap.", "Tempatkan terpung terigu dan tepung panir di masing masing piring yang berbeda. Beri sedikit garam pada kocokan telur. Ambil 1 lembar daging ayam yang sudah di marinasi, gulingkan kedalam tepung terigu, masukkan kedalam kocokan telur, dan terakhir gulingkan diatas tepung panir. Lakukan berulang sampai daging ayam habis :)", "Goreng di minyak panas dengan api Sedang.", "Bila ingin menggoreng nanti atau besok, Chicken katsu yang sudah dilumuri tepung panir bisa disimpan di freezer. Bila ingin digoreng, keluarkan dari freezer dan diamkan sebentar hingga chicken katsu mencapai suhu ruang baru digoreng ^-^", "Chicken katsu siap disantap."],
                                                       ingredient: [IngredientSample(name: "fillet ayam"), IngredientSample(name: "garam"), IngredientSample(name: "bawang putih halus"), IngredientSample(name: "merica bubuk"), IngredientSample(name: "kaldu jamur"), IngredientSample(name: "gula"), IngredientSample(name: "telur ayam"), IngredientSample(name: "tepung panir"), IngredientSample(name: "tepung terigu")])
      
    ]
    
}


