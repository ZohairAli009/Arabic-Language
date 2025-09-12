//
//  ArabicAlphabets.swift
//  Arabic-Language
//
//  Created by Zohair on 18/12/2024.
//

import Foundation

struct ArabicAlphabets {
    
    static let arabicLetters: [ArabicLetters] = [
        ArabicLetters(letter: "ا", name: "ʾalif", forms: ArabicLetters.Forms(initial: "ا", medial: "ـا", final: "ـا")),
        ArabicLetters(letter: "ب", name: "bāʾ", forms: ArabicLetters.Forms(initial: "بـ", medial: "ـبـ", final: "ـب")),
        ArabicLetters(letter: "ت", name: "tāʾ", forms: ArabicLetters.Forms(initial: "تـ", medial: "ـتـ", final: "ـت")),
        ArabicLetters(letter: "ث", name: "thāʾ", forms: ArabicLetters.Forms(initial: "ثـ", medial: "ـثـ", final: "ـث")),
        ArabicLetters(letter: "ج", name: "jīm", forms: ArabicLetters.Forms(initial: "جـ", medial: "ـجـ", final: "ـج")),
        ArabicLetters(letter: "ح", name: "ḥāʾ", forms: ArabicLetters.Forms(initial: "حـ", medial: "ـحـ", final: "ـح")),
        ArabicLetters(letter: "خ", name: "khāʾ", forms: ArabicLetters.Forms(initial: "خـ", medial: "ـخـ", final: "ـخ")),
        ArabicLetters(letter: "د", name: "dāl", forms: ArabicLetters.Forms(initial: "د", medial: "ـد", final: "ـد")),
        ArabicLetters(letter: "ذ", name: "dhāl", forms: ArabicLetters.Forms(initial: "ذ", medial: "ـذ", final: "ـذ")),
        ArabicLetters(letter: "ر", name: "rāʾ", forms: ArabicLetters.Forms(initial: "ر", medial: "ـر", final: "ـر")),
        ArabicLetters(letter: "ز", name: "zāy", forms: ArabicLetters.Forms(initial: "ز", medial: "ـز", final: "ـز")),
        ArabicLetters(letter: "س", name: "sīn", forms: ArabicLetters.Forms(initial: "سـ", medial: "ـسـ", final: "ـس")),
        ArabicLetters(letter: "ش", name: "shīn", forms: ArabicLetters.Forms(initial: "شـ", medial: "ـشـ", final: "ـش")),
        ArabicLetters(letter: "ص", name: "ṣād", forms: ArabicLetters.Forms(initial: "صـ", medial: "ـصـ", final: "ـص")),
        ArabicLetters(letter: "ض", name: "ḍād", forms: ArabicLetters.Forms(initial: "ضـ", medial: "ـضـ", final: "ـض")),
        ArabicLetters(letter: "ط", name: "ṭāʾ", forms: ArabicLetters.Forms(initial: "طـ", medial: "ـطـ", final: "ـط")),
        ArabicLetters(letter: "ظ", name: "ẓāʾ", forms: ArabicLetters.Forms(initial: "ظـ", medial: "ـظـ", final: "ـظ")),
        ArabicLetters(letter: "ع", name: "ʿayn", forms: ArabicLetters.Forms(initial: "عـ", medial: "ـعـ", final: "ـع")),
        ArabicLetters(letter: "غ", name: "ghayn", forms: ArabicLetters.Forms(initial: "غـ", medial: "ـغـ", final: "ـغ")),
        ArabicLetters(letter: "ف", name: "fāʾ", forms: ArabicLetters.Forms(initial: "فـ", medial: "ـفـ", final: "ـف")),
        ArabicLetters(letter: "ق", name: "qāf", forms: ArabicLetters.Forms(initial: "قـ", medial: "ـقـ", final: "ـق")),
        ArabicLetters(letter: "ك", name: "kāf", forms: ArabicLetters.Forms(initial: "كـ", medial: "ـكـ", final: "ـك")),
        ArabicLetters(letter: "ل", name: "lām", forms: ArabicLetters.Forms(initial: "لـ", medial: "ـلـ", final: "ـل")),
        ArabicLetters(letter: "م", name: "mīm", forms: ArabicLetters.Forms(initial: "مـ", medial: "ـمـ", final: "ـم")),
        ArabicLetters(letter: "ن", name: "nūn", forms: ArabicLetters.Forms(initial: "نـ", medial: "ـنـ", final: "ـن")),
        ArabicLetters(letter: "ه", name: "hāʾ", forms: ArabicLetters.Forms(initial: "هـ", medial: "ـهـ", final: "ـه")),
        ArabicLetters(letter: "و", name: "wāw", forms: ArabicLetters.Forms(initial: "و", medial: "ـو", final: "ـو")),
        ArabicLetters(letter: "ي", name: "yāʾ", forms: ArabicLetters.Forms(initial: "يـ", medial: "ـيـ", final: "ـي"))
    ]
    
    
    static let countingData: [ArabicCounting] = [
        ArabicCounting(number: "٠", transliteration: "sifr"),
        ArabicCounting(number: "١", transliteration: "wāḥid"),
        ArabicCounting(number: "٢", transliteration: "ithnān"),
        ArabicCounting(number: "٣", transliteration: "thalātha"),
        ArabicCounting(number: "٤", transliteration: "ʾarbaʿa"),
        ArabicCounting(number: "٥", transliteration: "khamsa"),
        ArabicCounting(number: "٦", transliteration: "sitta"),
        ArabicCounting(number: "٧", transliteration: "sabʿa"),
        ArabicCounting(number: "٨", transliteration: "thamnīya"),
        ArabicCounting(number: "٩", transliteration: "tisʿa")
    ]
    
}
