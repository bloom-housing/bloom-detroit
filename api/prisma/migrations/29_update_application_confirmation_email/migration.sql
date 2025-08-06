-- Updates application confirmation email copy

-- Removes preference related strings in addition to updating copy
UPDATE translations
SET translations = jsonb_set(
    translations,
    '{confirmation, eligible}',
    '{"fcfs": "Applicants will be contacted on a first come first serve basis until vacancies are filled.",
    "lottery": "Once the application period closes, applicants will be placed in order based on lottery rank order.",
    "waitlist":"Applicants will be placed on the waitlist on a first come first serve basis until waitlist spots are filled.",
    "waitlistContact":"You may be contacted while on the waitlist to confirm that you wish to remain on the waitlist."}'
    )
WHERE language = 'en';

UPDATE translations
SET translations = jsonb_set(
    translations,
    '{confirmation, leasingAgent, footer}',
    '"If you need to update information on your application, do not apply again. Instead, contact the Property Agent for this listing."'
    )
WHERE language = 'en';


UPDATE translations
SET translations = jsonb_set(
    translations,
    '{confirmation, eligible}',
    '{"fcfs": "Se contactará a los solicitantes por orden de llegada hasta que se cubran las vacantes.",
    "lottery": "Una vez finalizado el plazo de solicitud, los solicitantes se ordenarán según el orden de clasificación del sorteo.",
    "waitlist": "Los solicitantes se incluirán en la lista de espera por orden de llegada hasta que se cubran las plazas.",
    "waitlistContact": "Es posible que nos pongamos en contacto con usted mientras esté en la lista de espera para confirmar su deseo de permanecer en ella."}'
    )
WHERE language = 'es';

UPDATE translations
SET translations = jsonb_set(
    translations,
    '{confirmation, leasingAgent, footer}',
    '"Si necesita actualizar la información de su solicitud, no la vuelva a solicitar. En su lugar, contacte al agente inmobiliario de este anuncio."'
    )
WHERE language = 'es';


UPDATE translations
SET translations = jsonb_set(
    translations,
    '{confirmation, eligible}',
    '{"fcfs": "سيتم الاتصال بالمتقدمين على أساس أسبقية الحضور حتى يتم شغل الوظائف الشاغرة.",
    "lottery": "بمجرد إغلاق فترة تقديم الطلبات، سيتم ترتيب المتقدمين حسب ترتيب اليانصيب.",
    "waitlist":"سيتم وضع المتقدمين على قائمة الانتظار على أساس أسبقية الحضور حتى يتم ملء أماكن قائمة الانتظار.",
    "waitlistContact":"قد يتم الاتصال بك أثناء وجودك في قائمة الانتظار لتأكيد رغبتك في البقاء في قائمة الانتظار."}'
    )
WHERE language = 'ar';

UPDATE translations
SET translations = jsonb_set(
    translations,
    '{confirmation, leasingAgent, footer}',
    '"إذا كنت بحاجة إلى تحديث معلومات طلبك، فلا تتقدم بطلب جديد. بدلاً من ذلك، تواصل مع وكيل العقارات المسؤول عن هذا الإعلان."'
    )
WHERE language = 'ar';


UPDATE translations
SET translations = jsonb_set(
    translations,
    '{confirmation, eligible}',
    '{"fcfs": "শূন্যপদ পূরণ না হওয়া পর্যন্ত আবেদনকারীদের সাথে আগে আসলে আগে পাবেন ভিত্তিতে যোগাযোগ করা হবে।",
    "lottery": "আবেদনের সময়সীমা শেষ হয়ে গেলে, লটারির র‍্যাঙ্ক ক্রমের ভিত্তিতে আবেদনকারীদের ক্রমানুসারে রাখা হবে।",
    "waitlist":"অপেক্ষা তালিকার আসন পূরণ না হওয়া পর্যন্ত আবেদনকারীদের আগে আসলে আগে পাবেন ভিত্তিতে অপেক্ষা তালিকায় রাখা হবে।",
    "waitlistContact":"অপেক্ষা তালিকায় থাকাকালীন আপনার সাথে যোগাযোগ করা হতে পারে এবং নিশ্চিত করা যেতে পারে যে আপনি অপেক্ষা তালিকায় থাকতে চান।"}'
    )
WHERE language = 'bn';

UPDATE translations
SET translations = jsonb_set(
    translations,
    '{confirmation, leasingAgent, footer}',
    '"যদি আপনার আবেদনের তথ্য আপডেট করার প্রয়োজন হয়, তাহলে আর আবেদন করবেন না। পরিবর্তে, এই তালিকার জন্য সম্পত্তি এজেন্টের সাথে যোগাযোগ করুন।"'
    )
WHERE language = 'bn';
