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
    
    //var defaultRecipes: [RecipeSample] = [RecipeSample(name: "Ayam Goreng Bawang Khas Batam", cookStep: <#T##[String]#>, ingredient: <#[IngredientSample]#>)]
    
    var seafoodRecipes: [RecipeSample] = [
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
