//
//  ArabicWord.swift
//  Arabic-Language
//
//  Created by Zohair on 18/12/2024.
//

import Foundation

struct ArabicWords{
    
    static var allWords: [CategoryWords] = [
        CategoryWords(
            name: "Greetings and basic questions",
            words: [
                Word(arabic: "مرحبًا", english: "Hello"),
                Word(arabic: "صباح الخير", english: "Good morning"),
                Word(arabic: "مساء الخير", english: "Good evening"),
                Word(arabic: "كيف حالك؟", english: "How are you?"),
                Word(arabic: "أنا بخير", english: "I am fine"),
                Word(arabic: "ما اسمك؟", english: "What is your name?"),
                Word(arabic: "اسمي", english: "My name is"),
                Word(arabic: "أين؟", english: "Where?"),
                Word(arabic: "متى؟", english: "When?"),
                Word(arabic: "لماذا؟", english: "Why?"),
                Word(arabic: "نعم", english: "Yes"),
                Word(arabic: "لا", english: "No"),
                Word(arabic: "من فضلك", english: "Please"),
                Word(arabic: "شكرًا", english: "Thank you"),
                Word(arabic: "عفوًا", english: "You're welcome")
            ]),
        CategoryWords(
            name: "Family",
            words: [
                Word(arabic: "أب", english: "Father"),
                Word(arabic: "أم", english: "Mother"),
                Word(arabic: "أخ", english: "Brother"),
                Word(arabic: "أخت", english: "Sister"),
                Word(arabic: "جد", english: "Grandfather"),
                Word(arabic: "جدة", english: "Grandmother"),
                Word(arabic: "عم", english: "Uncle (paternal)"),
                Word(arabic: "عمة", english: "Aunt (paternal)"),
                Word(arabic: "خال", english: "Uncle (maternal)"),
                Word(arabic: "خالة", english: "Aunt (maternal)"),
                Word(arabic: "ابن", english: "Son"),
                Word(arabic: "ابنة", english: "Daughter"),
                Word(arabic: "زوج", english: "Husband"),
                Word(arabic: "زوجة", english: "Wife"),
                Word(arabic: "طفل", english: "Child"),
                Word(arabic: "أسرة", english: "Family")
            ]
        ),
        CategoryWords(
            name: "Numbers",
            words: [
                Word(arabic: "واحد", english: "One"),
                Word(arabic: "اثنان", english: "Two"),
                Word(arabic: "ثلاثة", english: "Three"),
                Word(arabic: "أربعة", english: "Four"),
                Word(arabic: "خمسة", english: "Five"),
                Word(arabic: "ستة", english: "Six"),
                Word(arabic: "سبعة", english: "Seven"),
                Word(arabic: "ثمانية", english: "Eight"),
                Word(arabic: "تسعة", english: "Nine"),
                Word(arabic: "عشرة", english: "Ten"),
                Word(arabic: "عشرون", english: "Twenty"),
                Word(arabic: "ثلاثون", english: "Thirty"),
                Word(arabic: "أربعون", english: "Forty"),
                Word(arabic: "خمسون", english: "Fifty"),
                Word(arabic: "مئة", english: "Hundred")
            ]
        ),
        CategoryWords(
            name: "Days of the week",
            words: [
                Word(arabic: "الأحد", english: "Sunday"),
                Word(arabic: "الاثنين", english: "Monday"),
                Word(arabic: "الثلاثاء", english: "Tuesday"),
                Word(arabic: "الأربعاء", english: "Wednesday"),
                Word(arabic: "الخميس", english: "Thursday"),
                Word(arabic: "الجمعة", english: "Friday"),
                Word(arabic: "السبت", english: "Saturday")
            ]
        ),
        CategoryWords(
            name: "Islamic",
            words: [
                Word(arabic: "الله أكبر", english: "God is Great"),
                Word(arabic: "الحمد لله", english: "Praise be to God"),
                Word(arabic: "بسم الله", english: "In the name of God"),
                Word(arabic: "السلام عليكم", english: "Peace be upon you"),
                Word(arabic: "رمضان", english: "Ramadan"),
                Word(arabic: "صلاة", english: "Prayer"),
                Word(arabic: "حج", english: "Hajj"),
                Word(arabic: "قرآن", english: "Quran"),
                Word(arabic: "حديث", english: "Hadith"),
                Word(arabic: "مكة", english: "Mecca"),
                Word(arabic: "المدينة", english: "Medina"),
                Word(arabic: "مسجد", english: "Mosque"),
                Word(arabic: "زكاة", english: "Alms"),
                Word(arabic: "صدقة", english: "Charity"),
                Word(arabic: "الإيمان", english: "Faith")
            ]),
        CategoryWords(
            name: "Professions",
            words: [
                Word(arabic: "طبيب", english: "Doctor"),
                Word(arabic: "ممرض", english: "Nurse"),
                Word(arabic: "معلم", english: "Teacher"),
                Word(arabic: "محامي", english: "Lawyer"),
                Word(arabic: "مهندس", english: "Engineer"),
                Word(arabic: "مزارع", english: "Farmer"),
                Word(arabic: "خباز", english: "Baker"),
                Word(arabic: "سائق", english: "Driver"),
                Word(arabic: "عامل", english: "Worker"),
                Word(arabic: "فنان", english: "Artist"),
                Word(arabic: "كاتب", english: "Writer"),
                Word(arabic: "مطور", english: "Developer"),
                Word(arabic: "صحفي", english: "Journalist"),
                Word(arabic: "مترجم", english: "Translator"),
                Word(arabic: "مصور", english: "Photographer")
            ]
        ),
        CategoryWords(
            name: "Everyday Actions",
            words: [
                Word(arabic: "أكل", english: "Eat"),
                Word(arabic: "شرب", english: "Drink"),
                Word(arabic: "نوم", english: "Sleep"),
                Word(arabic: "مشا", english: "Walk"),
                Word(arabic: "ركض", english: "Run"),
                Word(arabic: "قراءة", english: "Read"),
                Word(arabic: "كتابة", english: "Write"),
                Word(arabic: "استماع", english: "Listen"),
                Word(arabic: "حديث", english: "Talk"),
                Word(arabic: "غسل", english: "Wash"),
                Word(arabic: "غسل اليدين", english: "Wash hands"),
                Word(arabic: "الاستحمام", english: "Shower"),
                Word(arabic: "الطبخ", english: "Cook"),
                Word(arabic: "التنظيف", english: "Clean"),
                Word(arabic: "التسوق", english: "Shopping")
            ]
        ),
        CategoryWords(
            name: "Classroom",
            words: [
                Word(arabic: "فصل", english: "Class"),
                Word(arabic: "سبورة", english: "Board"),
                Word(arabic: "قلم", english: "Pen"),
                Word(arabic: "دفتر", english: "Notebook"),
                Word(arabic: "كتاب", english: "Book"),
                Word(arabic: "كرسي", english: "Chair"),
                Word(arabic: "طاولة", english: "Table"),
                Word(arabic: "معلم", english: "Teacher"),
                Word(arabic: "طالب", english: "Student"),
                Word(arabic: "دراسة", english: "Study"),
                Word(arabic: "اختبار", english: "Test"),
                Word(arabic: "واجب", english: "Homework"),
                Word(arabic: "درس", english: "Lesson"),
                Word(arabic: "عقاب", english: "Punishment"),
                Word(arabic: "مكتبة", english: "Library")
            ]
        ),
        CategoryWords(
            name: "Food and Beverage",
            words: [
                Word(arabic: "طعام", english: "Food"),
                Word(arabic: "شراب", english: "Drink"),
                Word(arabic: "ماء", english: "Water"),
                Word(arabic: "عصير", english: "Juice"),
                Word(arabic: "شاي", english: "Tea"),
                Word(arabic: "قهوة", english: "Coffee"),
                Word(arabic: "خبز", english: "Bread"),
                Word(arabic: "لحم", english: "Meat"),
                Word(arabic: "دجاج", english: "Chicken"),
                Word(arabic: "سمك", english: "Fish"),
                Word(arabic: "خضار", english: "Vegetables"),
                Word(arabic: "فاكهة", english: "Fruit"),
                Word(arabic: "حساء", english: "Soup"),
                Word(arabic: "أرز", english: "Rice"),
                Word(arabic: "معكرونة", english: "Pasta")
            ]
        ),
        CategoryWords(
            name: "Time",
            words: [
                Word(arabic: "الساعة", english: "Clock"),
                Word(arabic: "دقيقة", english: "Minute"),
                Word(arabic: "ساعة", english: "Hour"),
                Word(arabic: "يوم", english: "Day"),
                Word(arabic: "أسبوع", english: "Week"),
                Word(arabic: "شهر", english: "Month"),
                Word(arabic: "سنة", english: "Year"),
                Word(arabic: "الآن", english: "Now"),
                Word(arabic: "غدًا", english: "Tomorrow"),
                Word(arabic: "أمس", english: "Yesterday"),
                Word(arabic: "صباحًا", english: "In the morning"),
                Word(arabic: "مساءً", english: "In the evening"),
                Word(arabic: "منتصف الليل", english: "Midnight"),
                Word(arabic: "الظهر", english: "Noon"),
                Word(arabic: "الوقت", english: "Time")
            ]
        ),
        CategoryWords(
            name: "House",
            words: [
                Word(arabic: "منزل", english: "House"),
                Word(arabic: "غرفة", english: "Room"),
                Word(arabic: "مطبخ", english: "Kitchen"),
                Word(arabic: "صالة", english: "Living room"),
                Word(arabic: "حمام", english: "Bathroom"),
                Word(arabic: "حديقة", english: "Garden"),
                Word(arabic: "باب", english: "Door"),
                Word(arabic: "نافذة", english: "Window"),
                Word(arabic: "سرير", english: "Bed"),
                Word(arabic: "كرسي", english: "Chair"),
                Word(arabic: "طاولة", english: "Table"),
                Word(arabic: "سجاد", english: "Carpet"),
                Word(arabic: "ثلاجة", english: "Refrigerator"),
                Word(arabic: "مغسلة", english: "Sink"),
                Word(arabic: "مكتبة", english: "Bookshelf")
            ]
        ),
        CategoryWords(
            name: "Weather",
            words: [
                Word(arabic: "جو", english: "Weather"),
                Word(arabic: "مطر", english: "Rain"),
                Word(arabic: "ثلج", english: "Snow"),
                Word(arabic: "رياح", english: "Wind"),
                Word(arabic: "شمس", english: "Sun"),
                Word(arabic: "غيم", english: "Clouds"),
                Word(arabic: "ضباب", english: "Fog"),
                Word(arabic: "حرارة", english: "Temperature"),
                Word(arabic: "رطوبة", english: "Humidity"),
                Word(arabic: "دافئ", english: "Warm"),
                Word(arabic: "بارد", english: "Cold"),
                Word(arabic: "حار", english: "Hot"),
                Word(arabic: "عاصفة", english: "Storm"),
                Word(arabic: "طقس", english: "Climate"),
                Word(arabic: "معتدل", english: "Mild")
            ]
        ),
        CategoryWords(
            name: "Clothes",
            words: [
                Word(arabic: "قميص", english: "Shirt"),
                Word(arabic: "بنطال", english: "Pants"),
                Word(arabic: "فستان", english: "Dress"),
                Word(arabic: "جاكيت", english: "Jacket"),
                Word(arabic: "معطف", english: "Coat"),
                Word(arabic: "حذاء", english: "Shoes"),
                Word(arabic: "سروال", english: "Trousers"),
                Word(arabic: "قبعة", english: "Hat"),
                Word(arabic: "جوارب", english: "Socks"),
                Word(arabic: "مظلة", english: "Umbrella"),
                Word(arabic: "حزام", english: "Belt"),
                Word(arabic: "ملابس", english: "Clothes"),
                Word(arabic: "بذلة", english: "Suit"),
                Word(arabic: "قميص نوم", english: "Nightshirt"),
                Word(arabic: "بدلة رياضية", english: "Tracksuit")
            ]
        ),
        CategoryWords(
            name: "Colors",
            words: [
                Word(arabic: "أبيض", english: "White"),
                Word(arabic: "أسود", english: "Black"),
                Word(arabic: "أحمر", english: "Red"),
                Word(arabic: "أزرق", english: "Blue"),
                Word(arabic: "أصفر", english: "Yellow"),
                Word(arabic: "أخضر", english: "Green"),
                Word(arabic: "برتقالي", english: "Orange"),
                Word(arabic: "بني", english: "Brown"),
                Word(arabic: "رمادي", english: "Gray"),
                Word(arabic: "زهري", english: "Pink"),
                Word(arabic: "بنفسجي", english: "Purple"),
                Word(arabic: "ذهبي", english: "Gold"),
                Word(arabic: "فضي", english: "Silver"),
                Word(arabic: "أزرق فاتح", english: "Light Blue"),
                Word(arabic: "أخضر فاتح", english: "Light Green")
            ]
        ),
        CategoryWords(
            name: "Sports",
            words: [
                Word(arabic: "كرة القدم", english: "Football (Soccer)"),
                Word(arabic: "كرة السلة", english: "Basketball"),
                Word(arabic: "كرة اليد", english: "Handball"),
                Word(arabic: "السباحة", english: "Swimming"),
                Word(arabic: "التنس", english: "Tennis"),
                Word(arabic: "الركض", english: "Running"),
                Word(arabic: "الملاكمة", english: "Boxing"),
                Word(arabic: "الجمباز", english: "Gymnastics"),
                Word(arabic: "الجري", english: "Jogging"),
                Word(arabic: "الهوكي", english: "Hockey"),
                Word(arabic: "كرة الطائرة", english: "Volleyball"),
                Word(arabic: "رياضة", english: "Sport"),
                Word(arabic: "دراجات", english: "Cycling"),
                Word(arabic: "الطيران", english: "Flying"),
                Word(arabic: "مباراة", english: "Match")
            ]
        ),
        CategoryWords(
            name: "Money",
            words: [
                Word(arabic: "مال", english: "Money"),
                Word(arabic: "دولار", english: "Dollar"),
                Word(arabic: "ريال", english: "Riyal"),
                Word(arabic: "يورو", english: "Euro"),
                Word(arabic: "جنيه", english: "Pound"),
                Word(arabic: "رسم", english: "Fee"),
                Word(arabic: "خصم", english: "Discount"),
                Word(arabic: "سعر", english: "Price"),
                Word(arabic: "نقدًا", english: "Cash"),
                Word(arabic: "بطاقة ائتمان", english: "Credit Card"),
                Word(arabic: "سحب", english: "Withdraw"),
                Word(arabic: "إيداع", english: "Deposit"),
                Word(arabic: "حساب", english: "Account"),
                Word(arabic: "ربح", english: "Profit"),
                Word(arabic: "خسارة", english: "Loss")
            ]
        ),
        CategoryWords(
            name: "Health",
            words: [
                Word(arabic: "صحة", english: "Health"),
                Word(arabic: "مستشفى", english: "Hospital"),
                Word(arabic: "طبيب", english: "Doctor"),
                Word(arabic: "دواء", english: "Medicine"),
                Word(arabic: "علاج", english: "Treatment"),
                Word(arabic: "ألم", english: "Pain"),
                Word(arabic: "حساسية", english: "Allergy"),
                Word(arabic: "حرارة", english: "Fever"),
                Word(arabic: "ضغط دم", english: "Blood Pressure"),
                Word(arabic: "فحص", english: "Check-up"),
                Word(arabic: "إصابة", english: "Injury"),
                Word(arabic: "طوارئ", english: "Emergency"),
                Word(arabic: "مريض", english: "Patient"),
                Word(arabic: "علاج طبيعي", english: "Physical Therapy"),
                Word(arabic: "صحة جيدة", english: "Good health")
            ]
        ),
        CategoryWords(
            name: "Prepositions",
            words: [
                Word(arabic: "على", english: "On"),
                Word(arabic: "في", english: "In"),
                Word(arabic: "تحت", english: "Under"),
                Word(arabic: "فوق", english: "Above"),
                Word(arabic: "إلى", english: "To"),
                Word(arabic: "من", english: "From"),
                Word(arabic: "مع", english: "With"),
                Word(arabic: "بدون", english: "Without"),
                Word(arabic: "عن", english: "About"),
                Word(arabic: "خارج", english: "Outside"),
                Word(arabic: "داخل", english: "Inside"),
                Word(arabic: "خلف", english: "Behind"),
                Word(arabic: "أمام", english: "In front of"),
                Word(arabic: "بين", english: "Between"),
                Word(arabic: "قريب", english: "Near")
            ]
        ),
        CategoryWords(
            name: "Question Words",
            words: [
                Word(arabic: "ماذا", english: "What"),
                Word(arabic: "من", english: "Who"),
                Word(arabic: "أين", english: "Where"),
                Word(arabic: "متى", english: "When"),
                Word(arabic: "لماذا", english: "Why"),
                Word(arabic: "كيف", english: "How"),
                Word(arabic: "كم", english: "How much"),
                Word(arabic: "أي", english: "Which"),
                Word(arabic: "أي واحد", english: "Which one"),
                Word(arabic: "ما", english: "What (used with nouns)"),
                Word(arabic: "هل", english: "Is/Are"),
                Word(arabic: "أين هو", english: "Where is"),
                Word(arabic: "متى يأتي", english: "When does it come"),
                Word(arabic: "لماذا لا", english: "Why not"),
                Word(arabic: "كم من الوقت", english: "How long")
            ]
        ),
        CategoryWords(
            name: "Travel and Vacation",
            words: [
                Word(arabic: "سفر", english: "Travel"),
                Word(arabic: "عطلة", english: "Vacation"),
                Word(arabic: "طائرة", english: "Airplane"),
                Word(arabic: "حجز", english: "Reservation"),
                Word(arabic: "فندق", english: "Hotel"),
                Word(arabic: "شاطئ", english: "Beach"),
                Word(arabic: "مدينة", english: "City"),
                Word(arabic: "رحلة", english: "Trip"),
                Word(arabic: "جواز سفر", english: "Passport"),
                Word(arabic: "تذكرة", english: "Ticket"),
                Word(arabic: "خريطة", english: "Map"),
                Word(arabic: "مطار", english: "Airport"),
                Word(arabic: "سيارة أجرة", english: "Taxi"),
                Word(arabic: "موقع سياحي", english: "Tourist spot"),
                Word(arabic: "مرشد سياحي", english: "Tour guide")
            ]
        ),
        CategoryWords(
            name: "Adjectives",
            words: [
                Word(arabic: "كبير", english: "Big"),
                Word(arabic: "صغير", english: "Small"),
                Word(arabic: "طويل", english: "Tall"),
                Word(arabic: "قصير", english: "Short"),
                Word(arabic: "جميل", english: "Beautiful"),
                Word(arabic: "قبيح", english: "Ugly"),
                Word(arabic: "سريع", english: "Fast"),
                Word(arabic: "بطيء", english: "Slow"),
                Word(arabic: "جديد", english: "New"),
                Word(arabic: "قديم", english: "Old"),
                Word(arabic: "سهل", english: "Easy"),
                Word(arabic: "صعب", english: "Difficult"),
                Word(arabic: "ممتاز", english: "Excellent"),
                Word(arabic: "جيد", english: "Good"),
                Word(arabic: "سيئ", english: "Bad")
            ]
        ),
        CategoryWords(
            name: "Animals",
            words: [
                Word(arabic: "حيوان", english: "Animal"),
                Word(arabic: "كلب", english: "Dog"),
                Word(arabic: "قطة", english: "Cat"),
                Word(arabic: "حصان", english: "Horse"),
                Word(arabic: "طائر", english: "Bird"),
                Word(arabic: "سمكة", english: "Fish"),
                Word(arabic: "بقرة", english: "Cow"),
                Word(arabic: "خروف", english: "Sheep"),
                Word(arabic: "جمل", english: "Camel"),
                Word(arabic: "دجاجة", english: "Chicken"),
                Word(arabic: "فيل", english: "Elephant"),
                Word(arabic: "أسد", english: "Lion"),
                Word(arabic: "زرافة", english: "Giraffe"),
                Word(arabic: "دب", english: "Bear"),
                Word(arabic: "قرد", english: "Monkey")
            ]
        ),
        CategoryWords(
            name: "Places",
            words: [
                Word(arabic: "مدينة", english: "City"),
                Word(arabic: "قرية", english: "Village"),
                Word(arabic: "مكتبة", english: "Library"),
                Word(arabic: "مدرسة", english: "School"),
                Word(arabic: "جامعة", english: "University"),
                Word(arabic: "مستشفى", english: "Hospital"),
                Word(arabic: "فندق", english: "Hotel"),
                Word(arabic: "مطار", english: "Airport"),
                Word(arabic: "مركز تجاري", english: "Shopping center"),
                Word(arabic: "مقهى", english: "Cafe"),
                Word(arabic: "مكتبة", english: "Bookstore"),
                Word(arabic: "مسرح", english: "Theater"),
                Word(arabic: "حديقة", english: "Park"),
                Word(arabic: "شاطئ", english: "Beach"),
                Word(arabic: "مطعم", english: "Restaurant")
            ]
        ),
        CategoryWords(
            name: "Shopping",
            words: [
                Word(arabic: "تسوق", english: "Shopping"),
                Word(arabic: "ملابس", english: "Clothes"),
                Word(arabic: "حذاء", english: "Shoes"),
                Word(arabic: "فستان", english: "Dress"),
                Word(arabic: "قميص", english: "Shirt"),
                Word(arabic: "بندقية", english: "Gun"),
                Word(arabic: "هاتف", english: "Phone"),
                Word(arabic: "ساعة", english: "Watch"),
                Word(arabic: "سعر", english: "Price"),
                Word(arabic: "خصم", english: "Discount"),
                Word(arabic: "عروض", english: "Offers"),
                Word(arabic: "محل", english: "Shop"),
                Word(arabic: "مركز تجاري", english: "Shopping mall"),
                Word(arabic: "طعام", english: "Food"),
                Word(arabic: "منتجات", english: "Products"),
                Word(arabic: "ملحق", english: "Accessory"),
                Word(arabic: "دفع", english: "Payment"),
                Word(arabic: "كارت", english: "Card"),
                Word(arabic: "شراء", english: "Purchase"),
                Word(arabic: "بيع", english: "Sale")
            ])
    ]
    
}


