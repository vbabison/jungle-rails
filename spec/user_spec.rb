require 'rails_helper'

RSpec.describe User, type: :model do

  context "Validations" do

    it "has all valid properties " do
      @user = User.create(firstname:"Alex", lastname: "Lock", email: "alex@lock.com",
                          password:"123456", password_confirmation: "123456")
      @user.validate!
      @user.errors.full_messages
    end

    it "must have a firstname" do
      @user = User.create(firstname: nil, lastname: "Lock", email: "alex@lock.com",
                          password:"123456", password_confirmation: "123456")
         expect(@user).to_not be_valid
         expect(@user.errors.full_messages).to include("Firstname can't be blank")
    end

    it "must have lastname" do
      @user = User.create(firstname:"Alex", lastname: nil, email: "alex@lock.com",
                          password:"123456", password_confirmation: "123456")
         expect(@user).to_not be_valid
         expect(@user.errors.full_messages).to include("Lastname can't be blank")
    end

     it "must have a email" do
        @user = User.create(firstname:"Alex", lastname: "Lock", email: nil,
                          password:"123456", password_confirmation: "123456")
         expect(@user).to_not be_valid
         expect(@user.errors.full_messages).to include("Email can't be blank")
     end

      it "must have unique email" do
        @user1 = User.create(firstname:"Alex", lastname: "Lock", email: "alex@lock.com",
                          password:"123456", password_confirmation: "123456")
        @user2 = User.create(firstname:"Bob", lastname: "Lock", email: "alex@lock.com",
                          password:"123456", password_confirmation: "123456")
        expect(@user2.errors.messages[:email]).to eq ["has already been taken"]

      end

      it "must have a password" do
         @user = User.create(firstname:"Alex", lastname: "Lock", email: "alex@lock.com",
                          password: nil, password_confirmation: "123456")
         expect(@user).to_not be_valid
         expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "must have a minimun password length of 6" do
          @user = User.create(firstname:"Alex", lastname: "Lock", email: "alex@lock.com",
                          password: "1234", password_confirmation: "1234")
          expect(@user).to_not be_valid
          expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
        end

     it "must have a password confirmation" do
         @user = User.create(firstname:"Alex", lastname: "Lock", email:"alex@lock.com" ,
                          password:"123456", password_confirmation: nil)
         expect(@user).to_not be_valid
         expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

  end

  describe '.authenticate_with_credentials' do
    it "must have email to sign in" do
      @user_register = User.create(firstname:"Alex", lastname: "Lock", email:"alex@lock.com" ,
                          password:"123456", password_confirmation: "123456")
      @user_signin = User.authenticate_with_credentials("alex@lock.com","123456")
      expect(@user_register).to eq(@user_signin)
    end
  end
end