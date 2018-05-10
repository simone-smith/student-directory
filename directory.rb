def input_students
  puts "Please enter the names of the students, followed by their cohort, country of
  birth and height"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name, cohort, country and height
  puts "Name: "
  name = gets.delete("\n").capitalize
  puts "Cohort: "
  cohort = gets.delete("\n").capitalize.to_sym
  puts "Country: "
  country = gets.delete("\n").capitalize
  puts "Height: "
  height = gets.delete("\n").capitalize
  # while the name is not empty, repeat this code
  while !name.empty? do
    cohort = "May" if cohort.empty?
    country = "UK" if country.empty?
    height = "6 ft" if height.empty?

    # add the student hash to the array
    students << {name: name, cohort: cohort, country: country, height: height}
    puts "Now we have #{students.count} student" if students.count == 1
    puts "Now we have #{students.count} students" if students.count > 1
    # get another name, cohort, country and height from the user
    puts "Enter another name, or hit return again to finish."
    name = gets.delete("\n").capitalize
    if !name.empty?
      puts "Cohort: "
      cohort = gets.delete("\n").capitalize.to_sym
      puts "Country: "
      country = gets.delete("\n").capitalize
      puts "Height: "
      height = gets.delete("\n").capitalize
    end
  end
  # return the array of students
  students
end

def print_header(students)
  if students.count > 0
    puts "The students of Villains Academy".center(50)
    puts "-------------".center(50)
  end
end

def print(students)
  # print the students grouped by cohort
  cohort_array = []
  
  students.each do |hash|
    cohort_array.push(hash[:cohort]).uniq!
  end
  
  cohort_array.each do |month|
    puts month.center(50)
    students.each_with_index do |student, index|
      if students.count > 0
        if student[:cohort] == month
          puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
        end 
      end
    end
  end
end

def print_footer(students)
  if students.count > 0
    puts "Overall, we have #{students.count} great students".center(50)
  end
end

students = input_students
#nothing happens until we call the methods
print_header(students)
print(students)
print_footer(students)