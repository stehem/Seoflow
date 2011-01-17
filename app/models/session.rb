class Session  
  include ActiveModel::Validations  
  include ActiveModel::Conversion  
  extend ActiveModel::Naming  

    
  attr_accessor :name, :password
   
  validates_presence_of :name, :password 


  def initialize(attributes = {})  
    attributes.each do |name, value|  
      send("#{name}=", value)  
    end  
  end 

 def persisted?  
    false  
 end 


 private

  def self.authenticate(name,password)
    if user = User.find_by_name(name)
      salt = user.salt
      pass = Digest::SHA256.hexdigest(password+salt)
    end
    User.find_by_name_and_encrypted_password(name, pass)
  end
 
end 
