def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    # 2. read the input and save it to a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
    end
  end
end

def input_students
  puts "Please enter the names of the students and hit return"
  puts "Then enter their cohort month"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets[0..-2]
  month = gets[0..-2]
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: month}
    puts "Now we have #{students.count} student" if students.count == 1
    puts "Now we have #{students.count} students" if students.count > 1
    # get another name from the user
    name = gets[0..-2]
    month = gets[0..-2]
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  cohorts = []

  if students.any?
  
    students.each do |hash|
      cohorts.push(hash[:cohort]).uniq!
    end
  
    cohorts.each do |value|
      puts value
      students.each do |x|
        puts x[:name] if x[:cohort] == value
      end
    end
  else 
    puts "There are no students"
  end
end 

def print_footer(students)
  puts "Overall, we have #{students.count} great student" if students.count == 1
  puts "Overall, we have #{students.count} great students" if students.count > 1
end

interactive_menu
