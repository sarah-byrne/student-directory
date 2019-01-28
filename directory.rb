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
@students = [] # an empty array accessible to all methods

$cohorts = [:january, :february, :march,
          :april, :may, :june,  :july,
          :august, :september,  :october,
          :november,  :december]

$default_cohort = :november

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

def print_students_list
  counter = 1
  $cohorts.each do |cohort|
    students = @students.select {|s| s[:cohort] == cohort}
    i = 0
    while i < students.length do
      puts "#{counter}.".center(4) +
            "#{students[i][:name].capitalize}".center(12) +
            "#{students[i][:cohort].capitalize}".center(10) +
            "#{students[i][:hobby].capitalize}".center(11) +
            "#{students[i][:height]}".center(8) +
            "#{students[i][:country].capitalize}".center(9)
      i += 1
      counter += 1
    end
  end
end

#  def print_students_list(initial, max)
#  #  students.select {|s| s[:name].start_with?(initial) && s[:name].length < max}.each_with_index do |student, i|
#  #    puts "#{i+1}. #{student[:name]} (#{student[:cohort]} cohort)"
#  #  end
#    counter = 1
#    $cohorts.each do |cohort|
#      students = @students.select {|s| s[:cohort] == cohort}
#      i = 0
#      while i < students.length do
#        if students[i][:name].start_with?(initial) && students[i][:name].length < max
#          puts "#{counter}.".center(4) +
#                "#{students[i][:name].capitalize}".center(12) +
#                "#{students[i][:cohort].capitalize}".center(10) +
#                "#{students[i][:hobby].capitalize}".center(11) +
#                "#{students[i][:height]}".center(8) +
#                "#{students[i][:country].capitalize}".center(9)
#        end
#        i += 1
#        counter += 1
#      end
#    end
#  end

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

def print_footer
  puts @students.count == 1 ?
    "Overall, we have 1 great student" :
    "Overall, we have #{@students.count} great students"
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
  # get the first name
  name = gets.delete_suffix("\n")
  # while the name is not empty, repeat this code
  while !name.empty? do
    # ask for cohort and validate response
    puts "Which cohort is this student in?"
    cohort = gets.chomp.downcase.to_sym

    if $cohorts.include?(cohort) == false
      cohort = $default_cohort
    end
    # add the student hash to the array
    @students << {name: name, cohort: cohort,
                hobby: random_hobby, height: random_height,
                country: "UK"}
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = gets.chomp
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load students from students.csv"
  puts "9. Exit"  # 9 because we'll be adding more items
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort],
                    student[:hobby], student[:height], student[:country]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    name, cohort, hobby, height, country = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym,
                  hobby: hobby.to_sym, height: height.to_sym,
                  country: country.to_sym}
  end

  file.close
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

interactive_menu

# nothing happens until we call the methods
#  students = input_students
#  if students.length > 0
#    print_header
#    print(students, "t", 12)
#    print_footer(students)
#  end
