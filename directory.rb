def input_students
  puts "Please enter the names of the students, followed by their country of
  birth and height"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name, country and height
  puts "Name: "
  name = gets.chomp.capitalize
  puts "Country: "
  country = gets.chomp.capitalize
  puts "Height: "
  height = gets.chomp.capitalize
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november, country: country, height: height}
    puts "Now we have #{students.count} students"
    # get another name, country and height from the user
    puts "Name: "
    name = gets.chomp.capitalize
    puts "Country: "
    country = gets.chomp.capitalize
    puts "Height: "
    height = gets.chomp.capitalize
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print(students)
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(50)
end

students = input_students
#nothing happens until we call the methods
print_header
print(students)
print_footer(students)