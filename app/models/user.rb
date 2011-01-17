class User < ActiveRecord::Base
has_many :questions
has_many :karmas
has_many :answers
has_many :badges
has_many :favorites
has_many :replies

validates_presence_of :password_confirmation
validates_confirmation_of :password
validates_uniqueness_of :name, :case_sensitive => :false

require 'digest/sha2'
require 'unicode'

attr_accessor :password_confirmation, :password, :local
attr_accessible :name, :email, :realname, :website, :age, :ville, :password, :password_confirmation

validates_presence_of :name, :password, :if => :check_local


def encrypt_password
  return unless @password
  self.salt = [Array.new(9){rand(256).chr}.join].pack('m').chomp
  self.encrypted_password = Digest::SHA256.hexdigest(@password+self.salt)
end

def self.create_with_omniauth(auth)  
  create! do |user|  
    user.provider = auth["provider"]  
    user.uid = auth["uid"]  
    user.name = auth["user_info"]["name"]  
  end  
end  

def to_param
  "#{id}#{Unicode::normalize_KD("-"+name+"-").downcase.gsub(/[^a-z0-9\s_-]+/,'').gsub(/[\s_-]+/,'-')[0..100].chomp("-")}"
end 

def check_local
  return true if self.local
end

end
