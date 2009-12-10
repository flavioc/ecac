#!/usr/bin/python

# Script to generate .exs file suitable for using Peter Clark's CN2 software
# Refer to adult.att for the attribute definition

import sys

if len(sys.argv) != 3:
    print "generate_examples.py <input> <output>"
    sys.exit(1)

def normalize_field(field):
    return field.lower().replace('-', '_')

def convert_line(line, outputfile):
    vec = line.split(', ')
    if len(vec) < 14:
        return

    age = vec[0]
    workclass = normalize_field(vec[1])
    fnlwgt = vec[2]
    education = normalize_field(vec[3])
    if education[0].isdigit():
        education = "_" + education
    education_num = vec[4]
    marital_status = normalize_field(vec[5])
    occupation = normalize_field(vec[6])
    relationship = normalize_field(vec[7])
    race = normalize_field(vec[8])
    sex = normalize_field(vec[9])
    capital_gain = vec[10]
    capital_loss = vec[11]
    hours_per_week = vec[12]
    native_country = normalize_field(vec[13])
    plus_50 = vec[14]
    if plus_50 == '>50K\n':
        plus_50 = 'more_than_50K'
    else:
        plus_50 = 'less_or_equal_than_50K'
    if native_country == 'trinadad&tobago':
        native_country = 'trinadad_tobago'
    if native_country == 'outlying_us(guam_usvi_etc)':
        native_country = 'outlying_us'
    if native_country == '?':
        native_country = 'united_states'
    if workclass == '?':
        workclass = 'private'
    if occupation == '?':
        occupation = 'prof_specialty'
    outputfile.write(age + " " + workclass + " " + education +
                     " " + marital_status + " " + 
                     occupation + " " + relationship + " " + race + " " + sex +
                     " " + capital_gain + " " + capital_loss + " " + 
                     hours_per_week + " " + native_country + " " + plus_50 +
                     ";\n")

def convert_data(input_filename, output_filename):
    inf = open(input_filename, 'r')
    outf = open(output_filename, 'w')
    outf.write("**EXAMPLE FILE**\n\n")
    for line in inf:
        convert_line(line, outf)
    outf.write("\n")
    inf.close()
    outf.close()

convert_data(sys.argv[1], sys.argv[2])
