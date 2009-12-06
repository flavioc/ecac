#!/usr/bin/python

# Script to generate .b, .f and .n files suitable for using with the ILP system
# Aleph (http://www.comlab.ox.ac.uk/activities/machinelearning/Aleph/aleph.html)

import sys

if len(sys.argv) != 3:
    print "generate_clauses.py <input> <output>"
    sys.exit(1)

def normalize_field(field):
    return field.lower().replace('-', '_')

def write_details(backf):
    string_details = """
:- modeh(1, more_than_50K(+person)).
:- modeb(1, young(+person)).
:- modeb(1, middle_aged(+person)).
:- modeb(1, senior(+person)).
:- modeb(1, old(+person)).
:- modeb(1, work_private(+person)).
:- modeb(1, work_self_emp_not_inc(+person)).
:- modeb(1, work_self_emp_inc(+person)).
:- modeb(1, work_federal_gov(+person)).
:- modeb(1, work_local_gov(+person)).
:- modeb(1, work_state_gov(+person)).
:- modeb(1, work_without_pay(+person)).
:- modeb(1, work_never_worked(+person)).
:- modeb(1, education_bachelors(+person)).
:- modeb(1, education_some_college(+person)).
:- modeb(1, education_11th(+person)).
:- modeb(1, education_hs_grad(+person)).
:- modeb(1, education_prof_school(+person)).
:- modeb(1, education_assoc_acdm(+person)).
:- modeb(1, education_assoc_voc(+person)).
:- modeb(1, education_9th(+person)).
:- modeb(1, education_7th_8th(+person)).
:- modeb(1, education_12th(+person)).
:- modeb(1, education_masters(+person)).
:- modeb(1, education_1st_4th(+person)).
:- modeb(1, education_10th(+person)).
:- modeb(1, education_doctorate(+person)).
:- modeb(1, education_5th_6th(+person)).
:- modeb(1, education_preschool(+person)).
:- modeb(1, married_civ_spouse(+person)).
:- modeb(1, divorced(+person)).
:- modeb(1, never_married(+person)).
:- modeb(1, separated(+person)).
:- modeb(1, widowed(+person)).
:- modeb(1, married_spouse_absent(+person)).
:- modeb(1, married_af_spouse(+person)).
:- modeb(1, occupation_tech_support(+person)).
:- modeb(1, occupation_craft_repair(+person)).
:- modeb(1, occupation_other_service(+person)).
:- modeb(1, occupation_sales(+person)).
:- modeb(1, occupation_exec_managerial(+person)).
:- modeb(1, occupation_prof_specialty(+person)).
:- modeb(1, occupation_handlers_cleaners(+person)).
:- modeb(1, occupation_machine_op_inspect(+person)).
:- modeb(1, occupation_adm_clerical(+person)).
:- modeb(1, occupation_farming_fishing(+person)).
:- modeb(1, occupation_transport_moving(+person)).
:- modeb(1, occupation_priv_house_serv(+person)).
:- modeb(1, occupation_protective_serv(+person)).
:- modeb(1, occupation_armed_forces(+person)).
:- modeb(1, wife(+person)).
:- modeb(1, own_child(+person)).
:- modeb(1, husband(+person)).
:- modeb(1, not_in_family(+person)).
:- modeb(1, other_relative(+person)).
:- modeb(1, unmarried(+person)).
:- modeb(1, white(+person)).
:- modeb(1, asian_pac_islander(+person)).
:- modeb(1, amer_indian_eskimo(+person)).
:- modeb(1, other(+person)).
:- modeb(1, black(+person)).
:- modeb(1, female(+person)).
:- modeb(1, male(+person)).
:- modeb(1, no_capital_gain(+person)).
:- modeb(1, very_low_capital_gain(+person)).
:- modeb(1, low_capital_gain(+person)).
:- modeb(1, medium_capital_gain(+person)).
:- modeb(1, high_capital_gain(+person)).
:- modeb(1, very_high_capital_gain(+person)).
:- modeb(1, no_capital_loss(+person)).
:- modeb(1, very_low_capital_loss(+person)).
:- modeb(1, low_capital_loss(+person)).
:- modeb(1, medium_capital_loss(+person)).
:- modeb(1, high_capital_loss(+person)).
:- modeb(1, very_high_capital_loss(+person)).
:- modeb(1, part_time_worker(+person)).
:- modeb(1, full_time_worker(+person)).
:- modeb(1, over_time_worker(+person)).
:- modeb(1, workaholic(+person)).
:- modeb(1, is_native_of_united_states(+person)).
:- modeb(1, is_native_of_cambodia(+person)).
:- modeb(1, is_native_of_england(+person)).
:- modeb(1, is_native_of_puerto_rico(+person)).
:- modeb(1, is_native_of_canada(+person)).
:- modeb(1, is_native_of_germany(+person)).
:- modeb(1, is_native_of_outlying_us(+person)).
:- modeb(1, is_native_of_india(+person)).
:- modeb(1, is_native_of_japan(+person)).
:- modeb(1, is_native_of_greece(+person)).
:- modeb(1, is_native_of_south(+person)).
:- modeb(1, is_native_of_china(+person)).
:- modeb(1, is_native_of_cuba(+person)).
:- modeb(1, is_native_of_iran(+person)).
:- modeb(1, is_native_of_honduras(+person)).
:- modeb(1, is_native_of_philippines(+person)).
:- modeb(1, is_native_of_italy(+person)).
:- modeb(1, is_native_of_poland(+person)).
:- modeb(1, is_native_of_jamaica(+person)).
:- modeb(1, is_native_of_vietnam(+person)).
:- modeb(1, is_native_of_mexico(+person)).
:- modeb(1, is_native_of_portugal(+person)).
:- modeb(1, is_native_of_ireland(+person)).
:- modeb(1, is_native_of_france(+person)).
:- modeb(1, is_native_of_dominican_republic(+person)).
:- modeb(1, is_native_of_laos(+person)).
:- modeb(1, is_native_of_ecuador(+person)).
:- modeb(1, is_native_of_taiwan(+person)).
:- modeb(1, is_native_of_haiti(+person)).
:- modeb(1, is_native_of_columbia(+person)).
:- modeb(1, is_native_of_hungary(+person)).
:- modeb(1, is_native_of_guatemala(+person)).
:- modeb(1, is_native_of_nicaragua(+person)).
:- modeb(1, is_native_of_scotland(+person)).
:- modeb(1, is_native_of_thailand(+person)).
:- modeb(1, is_native_of_yugoslavia(+person)).
:- modeb(1, is_native_of_el_salvador(+person)).
:- modeb(1, is_native_of_trinadad_tobago(+person)).
:- modeb(1, is_native_of_peru(+person)).
:- modeb(1, is_native_of_hong(+person)).
:- modeb(1, is_native_of_holand_netherlands(+person)).

:- determination(more_than_50K/1, young/1).
:- determination(more_than_50K/1, middle_aged/1).
:- determination(more_than_50K/1, senior/1).
:- determination(more_than_50K/1, old/1).
:- determination(more_than_50K/1, work_private/1).
:- determination(more_than_50K/1, work_self_emp_not_inc/1).
:- determination(more_than_50K/1, work_self_emp_inc/1).
:- determination(more_than_50K/1, work_federal_gov/1).
:- determination(more_than_50K/1, work_local_gov/1).
:- determination(more_than_50K/1, work_state_gov/1).
:- determination(more_than_50K/1, work_without_pay/1).
:- determination(more_than_50K/1, work_never_worked/1).
:- determination(more_than_50K/1, education_bachelors/1).
:- determination(more_than_50K/1, education_some_college/1).
:- determination(more_than_50K/1, education_11th/1).
:- determination(more_than_50K/1, education_hs_grad/1).
:- determination(more_than_50K/1, education_prof_school/1).
:- determination(more_than_50K/1, education_assoc_acdm/1).
:- determination(more_than_50K/1, education_assoc_voc/1).
:- determination(more_than_50K/1, education_9th/1).
:- determination(more_than_50K/1, education_7th_8th/1).
:- determination(more_than_50K/1, education_12th/1).
:- determination(more_than_50K/1, education_masters/1).
:- determination(more_than_50K/1, education_1st_4th/1).
:- determination(more_than_50K/1, education_10th/1).
:- determination(more_than_50K/1, education_doctorate/1).
:- determination(more_than_50K/1, education_5th_6th/1).
:- determination(more_than_50K/1, education_preschool/1).
:- determination(more_than_50K/1, married_civ_spouse/1).
:- determination(more_than_50K/1, divorced/1).
:- determination(more_than_50K/1, never_married/1).
:- determination(more_than_50K/1, separated/1).
:- determination(more_than_50K/1, widowed/1).
:- determination(more_than_50K/1, married_spouse_absent/1).
:- determination(more_than_50K/1, married_af_spouse/1).
:- determination(more_than_50K/1, occupation_tech_support/1).
:- determination(more_than_50K/1, occupation_craft_repair/1).
:- determination(more_than_50K/1, occupation_other_service/1).
:- determination(more_than_50K/1, occupation_sales/1).
:- determination(more_than_50K/1, occupation_exec_managerial/1).
:- determination(more_than_50K/1, occupation_prof_specialty/1).
:- determination(more_than_50K/1, occupation_handlers_cleaners/1).
:- determination(more_than_50K/1, occupation_machine_op_inspect/1).
:- determination(more_than_50K/1, occupation_adm_clerical/1).
:- determination(more_than_50K/1, occupation_farming_fishing/1).
:- determination(more_than_50K/1, occupation_transport_moving/1).
:- determination(more_than_50K/1, occupation_priv_house_serv/1).
:- determination(more_than_50K/1, occupation_protective_serv/1).
:- determination(more_than_50K/1, occupation_armed_forces/1).
:- determination(more_than_50K/1, wife/1).
:- determination(more_than_50K/1, own_child/1).
:- determination(more_than_50K/1, husband/1).
:- determination(more_than_50K/1, not_in_family/1).
:- determination(more_than_50K/1, other_relative/1).
:- determination(more_than_50K/1, unmarried/1).
:- determination(more_than_50K/1, white/1).
:- determination(more_than_50K/1, asian_pac_islander/1).
:- determination(more_than_50K/1, amer_indian_eskimo/1).
:- determination(more_than_50K/1, other/1).
:- determination(more_than_50K/1, black/1).
:- determination(more_than_50K/1, female/1).
:- determination(more_than_50K/1, male/1).
:- determination(more_than_50K/1, no_capital_gain/1).
:- determination(more_than_50K/1, very_low_capital_gain/1).
:- determination(more_than_50K/1, low_capital_gain/1).
:- determination(more_than_50K/1, medium_capital_gain/1).
:- determination(more_than_50K/1, high_capital_gain/1).
:- determination(more_than_50K/1, very_high_capital_gain/1).
:- determination(more_than_50K/1, no_capital_loss/1).
:- determination(more_than_50K/1, very_low_capital_loss/1).
:- determination(more_than_50K/1, low_capital_loss/1).
:- determination(more_than_50K/1, medium_capital_loss/1).
:- determination(more_than_50K/1, high_capital_loss/1).
:- determination(more_than_50K/1, very_high_capital_loss/1).
:- determination(more_than_50K/1, part_time_worker/1).
:- determination(more_than_50K/1, full_time_worker/1).
:- determination(more_than_50K/1, over_time_worker/1).
:- determination(more_than_50K/1, workaholic/1).
:- determination(more_than_50K/1, is_native_of_united_states/1).
:- determination(more_than_50K/1, is_native_of_cambodia/1).
:- determination(more_than_50K/1, is_native_of_england/1).
:- determination(more_than_50K/1, is_native_of_puerto_rico/1).
:- determination(more_than_50K/1, is_native_of_canada/1).
:- determination(more_than_50K/1, is_native_of_germany/1).
:- determination(more_than_50K/1, is_native_of_outlying_us/1).
:- determination(more_than_50K/1, is_native_of_india/1).
:- determination(more_than_50K/1, is_native_of_japan/1).
:- determination(more_than_50K/1, is_native_of_greece/1).
:- determination(more_than_50K/1, is_native_of_south/1).
:- determination(more_than_50K/1, is_native_of_china/1).
:- determination(more_than_50K/1, is_native_of_cuba/1).
:- determination(more_than_50K/1, is_native_of_iran/1).
:- determination(more_than_50K/1, is_native_of_honduras/1).
:- determination(more_than_50K/1, is_native_of_philippines/1).
:- determination(more_than_50K/1, is_native_of_italy/1).
:- determination(more_than_50K/1, is_native_of_poland/1).
:- determination(more_than_50K/1, is_native_of_jamaica/1).
:- determination(more_than_50K/1, is_native_of_vietnam/1).
:- determination(more_than_50K/1, is_native_of_mexico/1).
:- determination(more_than_50K/1, is_native_of_portugal/1).
:- determination(more_than_50K/1, is_native_of_ireland/1).
:- determination(more_than_50K/1, is_native_of_france/1).
:- determination(more_than_50K/1, is_native_of_dominican_republic/1).
:- determination(more_than_50K/1, is_native_of_laos/1).
:- determination(more_than_50K/1, is_native_of_ecuador/1).
:- determination(more_than_50K/1, is_native_of_taiwan/1).
:- determination(more_than_50K/1, is_native_of_haiti/1).
:- determination(more_than_50K/1, is_native_of_columbia/1).
:- determination(more_than_50K/1, is_native_of_hungary/1).
:- determination(more_than_50K/1, is_native_of_guatemala/1).
:- determination(more_than_50K/1, is_native_of_nicaragua/1).
:- determination(more_than_50K/1, is_native_of_scotland/1).
:- determination(more_than_50K/1, is_native_of_thailand/1).
:- determination(more_than_50K/1, is_native_of_yugoslavia/1).
:- determination(more_than_50K/1, is_native_of_el_salvador/1).
:- determination(more_than_50K/1, is_native_of_trinadad_tobago/1).
:- determination(more_than_50K/1, is_native_of_peru/1).
:- determination(more_than_50K/1, is_native_of_hong/1).
:- determination(more_than_50K/1, is_native_of_holand_netherlands/1).

"""
    backf.write(string_details)

def convert_line(line, id, backf, posf, negf):
    vec = line.split(', ')
    if len(vec) < 14:
        return

    pid = 'p' + str(id)

    backf.write('person(' + pid + ').\n')

    age = vec[0]
    if int(age) < 25:
        backf.write('young(' + pid + ').\n')
    elif int(age) < 40:
        backf.write('middle_aged(' + pid + ').\n')
    elif int(age) < 60:
        backf.write('senior(' + pid + ').\n')
    elif int(age) >= 60:
        backf.write('old(' + pid + ').\n')

    workclass = normalize_field(vec[1])
    if workclass != '?':
        backf.write('work_' + workclass + '(' + pid + ').\n')

    education = normalize_field(vec[3])
    if education != '?':
        backf.write('education_' + education + '(' + pid + ').\n')

    marital_status = normalize_field(vec[5])
    if marital_status != '?':
        backf.write(marital_status + '(' + pid + ').\n')

    occupation = normalize_field(vec[6])
    if occupation != '?':
        backf.write('occupation_' + occupation + '(' + pid + ').\n')

    relationship = normalize_field(vec[7])
    if relationship != '?':
        backf.write(relationship + '(' + pid + ').\n')

    race = normalize_field(vec[8])
    if race != '?':
        backf.write(race + '(' + pid + ').\n')

    sex = normalize_field(vec[9])
    if sex != '?':
        backf.write(sex + '(' + pid + ').\n')

    capital_gain = vec[10]
    if int(capital_gain) == 0:
        backf.write('no_capital_gain(' + pid + ').\n')
    elif int(capital_gain) < 100:
        backf.write('very_low_capital_gain(' + pid + ').\n')
    elif int(capital_gain) < 1000:
        backf.write('low_capital_gain(' + pid + ').\n')
    elif int(capital_gain) < 5000:
        backf.write('medium_capital_gain(' + pid + ').\n')
    elif int(capital_gain) < 10000:
        backf.write('high_capital_gain(' + pid + ').\n')
    elif int(capital_gain) >= 10000:
        backf.write('very_high_capital_gain(' + pid + ').\n')

    capital_loss = vec[11]
    if int(capital_loss) == 0:
        backf.write('no_capital_loss(' + pid + ').\n')
    elif int(capital_loss) < 100:
        backf.write('very_low_capital_loss(' + pid + ').\n')
    elif int(capital_loss) < 1000:
        backf.write('low_capital_loss(' + pid + ').\n')
    elif int(capital_loss) < 5000:
        backf.write('medium_capital_loss(' + pid + ').\n')
    elif int(capital_loss) < 10000:
        backf.write('high_capital_loss(' + pid + ').\n')
    elif int(capital_loss) >= 10000:
        backf.write('very_high_capital_loss(' + pid + ').\n')

    hours_per_week = vec[12]
    if int(hours_per_week) < 25:
        backf.write('part_time_worker(' + pid + ').\n')
    elif int(hours_per_week) < 41:
        backf.write('full_time_worker(' + pid + ').\n')
    elif int(hours_per_week) < 60:
        backf.write('over_time_worker(' + pid + ').\n')
    elif int(hours_per_week) >= 60:
        backf.write('workaholic(' + pid + ').\n')

    native_country = normalize_field(vec[13])
    if native_country == 'trinadad&tobago':
        native_country = 'trinadad_tobago'
    if native_country == 'outlying_us(guam_usvi_etc)':
        native_country = 'outlying_us'
    if native_country != '?':
        backf.write('is_native_of_' + native_country + '(' + pid + ').\n')

    plus_50 = vec[14]
    if plus_50 == '>50K\n':
        posf.write('more_than_50K(' + pid + ').\n')
    else:
        negf.write('more_than_50K(' + pid + ').\n')

def convert_data(input_filename, output_filename):
    inf = open(input_filename, 'r')
    backf = open(output_filename + ".b", 'w')
    posf = open(output_filename + ".f", 'w')
    negf = open(output_filename + ".n", 'w')
    write_details(backf)
    id = 0
    for line in inf:
        convert_line(line, id, backf, posf, negf)
        id += 1
    inf.close()
    backf.close()
    posf.close()
    negf.close()

convert_data(sys.argv[1], sys.argv[2])
