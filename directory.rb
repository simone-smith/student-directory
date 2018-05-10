@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end 

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      puts "What file would you like to save to?"
      filename = STDIN.gets.chomp
      save_students(filename)
    when "4"
      puts "What file would you like to load from?"
      filename = STDIN.gets.chomp
      load_students(filename)
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students, followed by their cohort, country of
  birth and height, and hit return to finish."
  # get the first name, cohort, country and height
  puts "Name: "
  name = STDIN.gets.delete("\n").capitalize
  puts "Cohort: "
  cohort = STDIN.gets.delete("\n").capitalize.to_sym
  puts "Country: "
  country = STDIN.gets.delete("\n").capitalize
  puts "Height: "
  height = STDIN.gets.delete("\n").capitalize
  # while the name is not empty, repeat this code
  while !name.empty? do
    cohort = "May" if cohort.empty?
    country = "UK" if country.empty?
    height = "6 ft" if height.empty?

    # add the student hash to the array
    push_students(name, cohort, country, height)
    puts "Now we have #{@students.count} student" if @students.count == 1
    puts "Now we have #{@students.count} students" if @students.count > 1
    # get another name, cohort, country and height from the user
    puts "Enter another name, or hit return again to finish."
    name = STDIN.gets.delete("\n").capitalize
    if !name.empty?
      puts "Cohort: "
      cohort = STDIN.gets.delete("\n").capitalize.to_sym
      puts "Country: "
      country = STDIN.gets.delete("\n").capitalize
      puts "Height: "
      height = STDIN.gets.delete("\n").capitalize
    end
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  if @students.count > 0
    puts "The students of Villains Academy".center(50)
    puts "-------------".center(50)
  end
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort. Country of birth:
    #{student[:country]}, height: #{student[:height]}.".center(50)
  end
end

def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student.".center(50) 
  else 
    puts "Overall, we have #{@students.count} great students".center(50)
  end
end

def save_students(filename = "students.csv")
  # open the file for writing
  file = File.open(filename, "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:country], 
    student[:height]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "Students successfully saved to file!"
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, country, height = line.chomp.split(",")
    push_students(name, cohort, country, height)
  end
  file.close
  puts "Students successfully loaded from file!"
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  filename = "students.csv" if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def push_students(name, cohort, country, height)
  @students << {name: name, cohort: cohort.to_sym, country: country, height: height}
end

# nothing happens until we call the method
try_load_students
interactive_menu