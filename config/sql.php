<?php

// #############
// PATIENTS INFO
// #############

//ALL INFO FROM PATIENTS
define('SQL_SELECT_ALL_PATIENTS',<<<THIS_DELIMITER
    select  id_type,
            id,
            first_name,
            last_name,
            birth_date
    from    patients
    THIS_DELIMITER);

//ALL INFO FROM SPECIFIC PATIENT
define('SQL_SELECT_PATIENTS_ONE_WITH_TYPE',<<<THIS_DELIMITER
    select  id_type,
            id,
            first_name,
            last_name,
            birth_date
    from    patients
    where   id_type = %s0
    and     id = %s1
    THIS_DELIMITER);

define('SQL_SELECT_PATIENTS_ONE',<<<THIS_DELIMITER
    select  id_type,
            id,
            first_name,
            last_name,
            birth_date
    from    patients
    where   id = %s0
    THIS_DELIMITER);


define('SQL_SELECT_BY_PATIENT_LAST',<<<THIS_DELIMITER
    select  topic_id, level_date, level_value
    from    blood_count
    where   patient_id_type = %s0
    and     patient_id = %s1
    and     level_date = (
        select  max(level_date)
        from    blood_count a1
        where   patient_id_type = %s0
        and     patient_id = %s1
    )
    order by level_date, topic_id
    THIS_DELIMITER);

define('SQL_SELECT_BY_PATIENT_ALL',<<<THIS_DELIMITER
    select  topic_id, level_date, level_value
    from    blood_count
    where   patient_id_type = %s0
    and     patient_id = %s1
    order by level_date, topic_id
    THIS_DELIMITER);

define('SQL_SELECT_RISK_FACTOR',<<<THIS_DELIMITER
    select  illness.description,
            risk_factors.illness_id,
            risk_factors.risk_factor
    from    risk_factors, illness
    where   risk_factors.illness_id = illness.id
    and     risk_factors.topic_id = 'SUGAR'
    and     %d0 between risk_factors.min_level and risk_factors.max_level
    union
    select  illness.description,
            risk_factors.illness_id,
            risk_factors.risk_factor
    from    risk_factors, illness
    where   risk_factors.illness_id = illness.id
    and     risk_factors.topic_id = 'FAT'
    and     %d1 between risk_factors.min_level and risk_factors.max_level
    union
    select  illness.description,
            risk_factors.illness_id,
            risk_factors.risk_factor
    from    risk_factors, illness
    where   risk_factors.illness_id = illness.id
    and     risk_factors.topic_id = 'OXYGEN'
    and     %d2 between risk_factors.min_level and risk_factors.max_level
    THIS_DELIMITER);


?>
