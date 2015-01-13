require 'csv'
require 'colorize'

class Contact

  attr_accessor :name, :email

  def initialize(name, email, phone_number_hash)
    # TODO: assign local variables to instance variables
    @name = name
    @email = email
    @phone_number_hash = phone_number_hash
    @contact_id = File.open('count.txt', 'r').readline[0].to_i
    @contact_id += 1
    File.open('count.txt', 'w'){|file| file.puts @contact_id}
    csv_array = [@name, @email, @phone_number_hash, @contact_id]
    CSV.open('contacts.csv', 'a'){|csv_object| csv_object << csv_array}
    return @contact_id
  end
 
  # def to_s
  #   # TODO: return string representation of Contact
  #   "Name: #{@name} Email: #{@email} ID: #{@contact_id}"
  # end

  def self.list
    row_count = 0
    CSV.foreach('contacts.csv') do |row|
      row_count +=1
      puts "#{row[-1].colorize(:magenta)}: #{row[0]} #{row[1]} #{row[2]}"
    end
    puts "----------------\nTotal Records: #{row_count}"
  end

  ##pass in int
  def self.show(id)
    CSV.foreach('contacts.csv') do |row|
      if row[-1] == id
        puts "Name: #{row[0]}"
        puts "Email: #{row[1]}"
        puts "Phone: #{row[2]}"
        puts "ID: #{row[-1]}"
        return
      end
    end
    puts "No user with that ID."
  end

  def self.find(search_term)
    CSV.foreach('contacts.csv') do |row|
      row.each do |row_ele|
        if row_ele.include?(search_term)
          puts "Name: #{row[0]}"
          puts "Email: #{row[1]}"
          puts "Phone: #{row[2]}"
          puts "ID: #{row[-1]}"
          return
        end
      end
    end
    puts "No users found."
  end

  def self.email_already_in_db?(email)
    CSV.foreach('contacts.csv') do |row|
      if row[1].downcase == email.downcase
        return true
      end
    end
    false
  end

  # def self.add(id)
  #   CSV.foreach('contacts.csv') do |row|
  #     if row[-1] == id
  #       add_number = true
  #       while add_number
  #         print "Enter phone type (ie. 'home', 'mobile', 'work': "
  #         phone_hash_key = gets.chomp
  #         print "Enter phone number (ie. 123-123-123): "
  #         phone_hash_value = gets.chomp
  #         row[-2][phone_hash_key] = phone_hash_value
  #         print "Add another number? (y/n): "
  #         another_number_input = gets.chomp
  #           if another_number_input == "n"
  #             add_number = false
  #           end
  #       end
  #     end
  #   end
  # end


#   ## Class Methods
#   class << self
#     def create(name, email)
#       # TODO: Will initialize a contact as well as add it to the list of contacts

#     end
 
#     def find(index)
#       # TODO: Will find and return contact by index
#     end
 
#     def all
#       # TODO: Return the list of contacts, as is
#     end
    
#     def show(id)
#       # TODO: Show a contact, based on ID
#     end
    
#   end
 
end