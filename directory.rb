# let's put all students into an array
# students = [
#   {name: "Dr. Hannibal Lecter", cohort: :november},
#   {name: "Darth Vader", cohort: :november},
#   {name: "Nurse Ratched", cohort: :november},
#   {name: "Michael Corleone", cohort: :november},
#   {name: "Alex DeLarge", cohort: :november},
#   {name: "The Wicked Witch of the West", cohort: :november},
#   {name: "Terminator", cohort: :november},
#   {name: "Freddy Krueger", cohort: :november},
#   {name: "The Joker", cohort: :november},
#   {name: "Joffrey Baratheon", cohort: :november},
#   {name: "Norman Bates", cohort: :november}
# ]

def print_header
  puts "The students of Villains Academy"
  puts "---------------"
end

def print(students, initial, max)
  students.select {|s| s[:name].start_with?(initial) && s[:name].length < max}.each_with_index do |student, i|
    puts "#{i+1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

#  def print_if_initial(students, initial)
#    students.select {|s| s[:name].start_with?(initial)}.each do |student|
#      puts "#{student[:name]} (#{student[:cohort]} cohort)"
#    end
#  end
#
#  def print_if_name_shorter_than(students, max)
#    students.select {|s| s[:name].length < max}.each do |student|
#      puts "#{student[:name]} (#{student[:cohort]} cohort)"
#    end
#  end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of input_students
  students
end

# nothing happens until we call the methods
students = input_students
print_header
print(students, "t", 12)
print_footer(students)
# print_if_initial(students, "t")
