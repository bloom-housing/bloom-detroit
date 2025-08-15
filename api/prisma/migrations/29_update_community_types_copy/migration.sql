UPDATE multiselect_questions SET
  options = jsonb_set(options, '{0,text}', '"I am a part of this community"')
  WHERE application_section = 'programs';

UPDATE multiselect_questions SET
  options = jsonb_set(options, '{1,text}', '"I am not a part of this community"')
  WHERE application_section = 'programs';

UPDATE multiselect_questions SET
  text = 'Family',
  description = 'This property offers housing for all family types, with no age restrictions (other than the lead applicant must be over 18 years old). Contact the property manager for more information. Please select ''I am a part of this community'' to continue the application.'
  WHERE application_section = 'programs'
    and text='Families';

UPDATE multiselect_questions SET
  description = 'This property offers housing for those experiencing homelessness, and may require additional processes that applicants must complete to qualify.'
  WHERE application_section = 'programs'
    and text = 'Supportive Housing for the Homeless';

UPDATE multiselect_questions SET
  description = 'This property offers housing for those who have served active duty in branches of the U.S. Armed Forces, and were discharged under conditions other than dishonorable.'
  WHERE application_section = 'programs'
    and text = 'Veterans';
