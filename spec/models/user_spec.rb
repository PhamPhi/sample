require 'spec_helper'

describe User do

  before do
    @user= User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end
  subject{ @user }

  #
  # Validating for the fields of table "User" such as: name, email, password_digest, password_confirmation
  #

  it{ should respond_to(:name)}
  it{ should respond_to(:email)}
  it{ should respond_to(:password_digest)}
  it{ should respond_to(:password_confirmation)}
  it{ should respond_to(:authenticate)}

  it{ should be_valid }

  #
  # Test Case: when user input the null-name...
  #
  #
  describe "When name is not present" do
    before do
      @user.name = " "
    end
    it{ should_not be_valid }
  end
  #
  #
  #
  #

  describe "When name is too long" do
    before {@user.name = "a" * 51}
    it{should_not be_valid}
  end

  #
  # Test Case: when user input the email address that has wrong format...
  # Functional Test
  #
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses =%w[user@foo user_at_foo.org example.user@foo.foo@bar_baz,com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email= invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  #
  # Test Case: when user input the email that has been wrong format..  Using the Regex expression for checking the
  # The validation of the email's address. And also checking the input-array of address...
  #

  describe "when email format is valid" do
    it "should be valid" do
      addresses= %W[user@foo.COM A_US_ER@f.b.org frst.lst@foo.jp a+b@baz.com]
      addresses.each do |valid_address|
        @user.email= valid_address
        expect(@user).to be_valid
      end
    end
  end

  #
  # Testing the case: when user input the email address which has already existed...
  # TESTCASE: Existed email address...
  #

=begin
  describe "when email address is already taken " do
    before do
      user_with_same_email = @user.dup
      user_with_same_email = @user.email.upcase
      #user_with_same_email.save
    end
    it{ should_not be_valid}
  end
=end

  #
  # Testing the testcase: when the user input the password was not present...
  # TESTCASE: Password is not present...
  #
  describe "when password is not present" do
    before do
      @user= User.new(name: "Example User", email: "user@example.com", password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end


  #
  # Testing the testcase: when the user input the password's confirmation was not matched.
  # TESTCASE: Password Not Match...
  #

  describe "when password doesn't match configuration" do
    before do
      @user.password_confirmation= "mismatch"
    end
    it{ should_not be_valid}
  end

  #
  # Test Case: Authentication
  # Testing about authentication method of site,,,
  #
  describe "return value of authenticate method " do
    before { @user.save }
    let(:found_user){ User.find_by(email: @user.email) }

    # Testing the valid password case
    describe "with valid password" do
      it{ should eq found_user.authenticate(@user.password)}
    end

    # Testing the invalid password case
    describe "with invalid password" do
      let(:user_for_invalid_password){ found_user.authenticate("invalid")}
      it{ should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false}
    end
  end

end

