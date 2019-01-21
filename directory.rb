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
  puts "--------------------------------"
  puts "No.".center(4) +
        "Name".center(12) +
        "Cohort".center(10) +
        "Hobby".center(11) +
        "Height".center(8) +
        "Country".center(9)
end

def print(students, initial, max)
#  students.select {|s| s[:name].start_with?(initial) && s[:name].length < max}.each_with_index do |student, i|
#    puts "#{i+1}. #{student[:name]} (#{student[:cohort]} cohort)"
#  end
  i = 0
  while i < students.length do
    if students[i][:name].start_with?(initial) && students[i][:name].length < max
      puts "#{i+1}.".center(4) +
            "#{students[i][:name]}".center(12) +
            "#{students[i][:cohort]}".center(10) +
            "#{students[i][:hobby]}".center(11) +
            "#{students[i][:height]}".center(8) +
            "#{students[i][:country]}".center(9)
    end
    i += 1
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
  puts students.count == 1 ?
    "Overall, we have 1 great student" :
    "Overall, we have #{students.count} great students"
end

def random_height
  heights = ["5ft 2in", "5ft 6in", "5ft 9in", "6ft 1in"]
  return heights[rand(4)]
end

def random_hobby
  hobbys = ["Reading", "Football", "Swimming", "Music"]
  return hobbys[rand(4)]
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
    students << {name: name, cohort: :november,
                hobby: random_hobby, height: random_height,
                country: "UK"}
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
