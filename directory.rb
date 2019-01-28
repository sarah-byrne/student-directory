
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

def print_footer
  puts @students.count == 1 ?
    "Overall, we have 1 great student" :
    "Overall, we have #{@students.count} great students"
end

def random_height
  heights = ["5ft 2in", "5ft 6in", "5ft 9in", "6ft 1in"]
  return heights[rand(4)].to_sym
end

def random_hobby
  hobbys = ["Reading", "Football", "Swimming", "Music"]
  return hobbys[rand(4)].to_sym
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.delete_suffix("\n")
  # while the name is not empty, repeat this code
  while !name.empty? do
    # ask for cohort and validate response
    puts "Which cohort is this student in?"
    cohort = STDIN.gets.chomp.downcase.to_sym

    if $cohorts.include?(cohort) == false
      cohort = $default_cohort
    end
    # add the student hash to the array
    add_student(name, cohort, random_hobby, random_height, "UK")
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def add_student(name, cohort, hobby, height, country)
  @students << {name: name, cohort: cohort,
              hobby: hobby, height: height,
              country: "UK"}
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load students from a file"
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
      save_students(specify_file)
    when "4"
      load_students(specify_file)
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

def specify_file
  puts "Which file would you like to use?"
  filename = gets.chomp
end

def save_students(filename)
  # open the file for writing
  file = File.open(filename, "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort],
                    student[:hobby], student[:height], student[:country]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "#{@students.count} students have been saved to students.csv"
end

def load_students(filename = "students.csv")
  count = 0
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, hobby, height, country = line.chomp.split(',')
    add_student(name, cohort.to_sym, hobby.to_sym, height.to_sym, country.to_sym)
    count += 1
  end
  puts "Loaded #{count} students from #{filename}"
  file.close
end

def initial_load_students
  filename = ARGV.first
  if filename.nil?
    load_students
    # puts "Loaded #{@students.count} from default file"
  else
    if File.exists?(filename)
      load_students(filename)
      # puts "Loaded #{@students.count} from #{filename}"
    else
      puts "Sorry, #{filename} doesn't exist"
      exit # quit the program
    end
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

initial_load_students
interactive_menu
