-- Updates application confirmation email copy

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
