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
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students, followed by their cohort, country of
  birth and height"
  puts "To finish, just hit return twice"
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
    @students << {name: name, cohort: cohort, country: country, height: height}
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
  # print the students grouped by cohort
  cohort_array = []
  
  @students.each do |hash|
    cohort_array.push(hash[:cohort]).uniq!
  end
  
  cohort_array.each do |month|
    puts month.to_s.center(50)
    @students.each_with_index do |student, index|
      if @students.count > 0
        if student[:cohort] == month
          puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
        end 
      end
    end
  end
end

def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student.".center(50) 
  else 
    puts "Overall, we have #{@students.count} great students".center(50)
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, country, height = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym, country: country, height: height}
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

# nothing happens until we call the method
try_load_students
interactive_menu